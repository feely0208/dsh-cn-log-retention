# @deepwhale-cn/dsh-cn-log-retention

[![Listed on dsh-plugin.org](https://dsh-plugin.org/badges/listed.svg)](https://dsh-plugin.org/plugins/feely0208/dsh-cn-log-retention)


**关键词**：日志留存 · 日志保留 · 审计日志 · 网络日志 · 网络安全法 · 六个月 · 留存不少于六个月 · 日志合规
**Keywords**: log retention · audit log retention · network log · six months retention · China cybersecurity law
**日志留存合规** —— 检查日志是否开着、是否记了该记的、是否留够**法定的 6 个月**。

## 不装它会怎样

你的日志轮转配的是 `maxDays: 7`（日志库的常见默认值）—— 排障够用。

半年后出了事，监管问：**这半年的网络日志呢？**

《网络安全法》第二十一条要求**留存不少于六个月**。日志已经在第 8 天被轮转删掉了。

## 它查什么

| 级别 | 内容 |
|---|---|
| 🔴 高 | 留存期 < 180 天 |
| 🔴 高 | 日志级别被关闭（`off`/`none`/`silent`）|
| 🔴 高 | 日志里打印了口令/令牌的**值** |
| 🟡 中 | 找不到任何日志方案 |

## 排障日志 ≠ 合规日志

```
排障：maxDays: 7        够了
合规：maxDays: >= 180   法定下限，且不能被应用进程随意删
```

两者通常**需要分开**：业务日志短留存，审计日志长留存、单独存放。

## 安装

```bash
dsh plugin --profile web add @deepwhale-cn/dsh-cn-log-retention
# 或纯 CLI
npx @deepwhale-cn/dsh-cn-log-retention
```

## 用法

```bash
dsh-cn-log-retention --demo          # 看检出效果
dsh-cn-log-retention --list-rules    # 列出规则和依据
dsh-cn-log-retention --html r.html   # HTML 报告
```

![dsh-cn-log-retention 检查报告示例](https://www.deepwhale.org.cn/plugin-assets/dsh-cn-log-retention/report.png)

![dsh-cn-log-retention 演示模式输出](https://www.deepwhale.org.cn/plugin-assets/dsh-cn-log-retention/demo.png)

![dsh-cn-log-retention 规则与依据](https://www.deepwhale.org.cn/plugin-assets/dsh-cn-log-retention/rules.png)

## 边界

- **不做缺项判定** —— 没有轮转配置不代表日志没留 180 天（可能由部署层统一留存）。
- **只看应用层** —— 数据库审计、网络设备、操作系统日志不在范围。
- **不校验不可篡改性** —— 那需要看存储层设计。
- 与其他插件分工：[dsh-cn-mlps](https://github.com/feely0208/dsh-cn-mlps) 做等保其它项。

本插件是一个工具。使用者必须遵守所在地区法律法规，**对使用本项目造成的任何后果自行承担责任。**

---

## 深鲸网安守护系列（共 38 个）

> 一个插件做一件事。**安全问题是链式的** —— 配套用才完整。

**国内合规**（12）｜ [等保对照](https://github.com/feely0208/dsh-cn-mlps) · [日志留存](https://github.com/feely0208/dsh-cn-log-retention) · [备案公示](https://github.com/feely0208/dsh-cn-filing) · [用户同意](https://github.com/feely0208/dsh-consent-guard) · [个人信息权利](https://github.com/feely0208/dsh-data-rights) · [未成年人保护](https://github.com/feely0208/dsh-minor-guard) · [影响评估](https://github.com/feely0208/dsh-pipia) · [数据分类分级](https://github.com/feely0208/dsh-data-classify) · [算法备案](https://github.com/feely0208/dsh-algorithm-filing) · [数据出境](https://github.com/feely0208/dsh-cn-data-export) · [国密合规](https://github.com/feely0208/dsh-cn-crypto) · [AI 内容标识](https://github.com/feely0208/dsh-cn-ai-labeling)

**AI 与 Agent 治理**（6）｜ [AI 输出信任](https://github.com/feely0208/dsh-ai-output-trust) · [外部内容信任](https://github.com/feely0208/dsh-content-trust) · [MCP 安全](https://github.com/feely0208/dsh-mcp-audit) · [Agent 权限](https://github.com/feely0208/dsh-agent-scope) · [策略核对](https://github.com/feely0208/dsh-agent-policy) · [可疑指令](https://github.com/feely0208/dsh-phishing-guard)

**数据与凭据**（5）｜ [敏感数据](https://github.com/feely0208/dsh-data-scan) · [密钥轮换](https://github.com/feely0208/dsh-key-rotate) · [数据留存](https://github.com/feely0208/dsh-data-lifecycle) · [配置审计](https://github.com/feely0208/dsh-env-audit) · [密钥扫描](https://github.com/feely0208/dsh-secret-scan)

**供应链与构建**（5）｜ [开源许可](https://github.com/feely0208/dsh-license-guard) · [依赖投毒](https://github.com/feely0208/dsh-dep-audit) · [CI 安全](https://github.com/feely0208/dsh-ci-guard) · [工具审查](https://github.com/feely0208/dsh-tool-vet) · [物料清单](https://github.com/feely0208/dsh-sbom)

**权限与应急**（3）｜ [最小权限](https://github.com/feely0208/dsh-least-privilege) · [告警外发](https://github.com/feely0208/dsh-alert-relay) · [应急证据包](https://github.com/feely0208/dsh-incident-package)

**行业专项**（4）｜ [医疗行业专项](https://github.com/feely0208/dsh-industry-medical) · [教育行业专项](https://github.com/feely0208/dsh-industry-education) · [金融行业专项](https://github.com/feely0208/dsh-industry-finance) · [地方数据条例](https://github.com/feely0208/dsh-local-regulation)

**编排与交付**（3）｜ [一键体检](https://github.com/feely0208/dsh-guard-suite) · [改前改后复核](https://github.com/feely0208/dsh-fix-verify) · [合规可交付文档](https://github.com/feely0208/dsh-compliance-doc)

都在 DSH 插件市场（dsh-plugin.org）、npm 和 deepwhale.org.cn/guard.html 上。
