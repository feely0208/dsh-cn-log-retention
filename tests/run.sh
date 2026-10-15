#!/bin/bash
set -uo pipefail
export PATH="/usr/local/bin:$PATH"
cd "$(dirname "$0")/.."
PASS=0; FAIL=0
ok(){ echo "  ✅ $1"; PASS=$((PASS+1)); }
bad(){ echo "  ❌ $1"; FAIL=$((FAIL+1)); }
echo ""; echo "  @deepwhale-cn/dsh-cn-log-retention · 双向验证"
echo "  ────────────────────────────────────────────────"
echo ""; echo "  【正例】违规样本（必须报）"
N=$(node bin/cli.mjs --root tests/fixtures/fail/demo-project --quiet 2>&1 | grep -oE '^[0-9]+' | head -1)
[ "${N:-0}" -ge 4 ] && ok "命中 ${N} 条（≥4）" || bad "只命中 ${N} 条"
J=$(node bin/cli.mjs --root tests/fixtures/fail/demo-project --json 2>&1)
for rid in LOG-RETENTION-SHORT LOG-DISABLED LOG-SENSITIVE LOG-NO-SETUP; do
  c=$(echo "$J" | python3 -c "
import json,sys
d=json.load(sys.stdin)
print(len([f for f in d['findings'] if f['ruleId']=='$rid']))" 2>/dev/null)
  [ "${c:-0}" -gt 0 ] && ok "$rid 报出" || bad "$rid 未报出"
done
echo ""; echo "  【反例】合规样本（必须 0 命中）"
M=$(node bin/cli.mjs --root tests/fixtures/pass/clean-project --quiet 2>&1 | grep -oE '^[0-9]+' | head -1)
[ "${M:-1}" = "0" ] && ok "0 命中" || bad "误报 ${M} 条"
echo ""; echo "  【误报回归】日志里提到 password/token 但没打印其值的，不该报"
E=$(echo "$J" | python3 -c "
import json,sys
d=json.load(sys.stdin)
print(len([f for f in d['findings'] if f['ruleId']=='LOG-SENSITIVE']))" 2>/dev/null)
# 违规样本里 LOG-SENSITIVE 应该只有 1 条（值那一条），不是 3 条
[ "${E:-0}" = "1" ] && ok "只报真值 1 条（未把提及当打印）" || bad "LOG-SENSITIVE 报了 ${E} 条，疑误报"
echo ""; echo "  【溯源】每条规则必须带 source 且含法定依据"
python3 - <<'PY' && ok "全部规则均有 source" || bad "有规则缺 source"
import json,glob,sys
for f in glob.glob('rules/*.json'):
    r=json.load(open(f,encoding='utf-8'))
    if not r.get('source'): print('缺:',r.get('id'),file=sys.stderr); sys.exit(1)
PY
echo ""; echo "  ────────────────────────────────────────────────"
echo "  通过 $PASS · 失败 $FAIL"; echo ""
[ "$FAIL" -eq 0 ] || exit 1
