import { createPlugin, pkgRootFrom } from '@deepwhale-cn/dsh-guard-core/plugin';

export const { name, inject, apply } = createPlugin({
  name: 'cn-log-retention',
  pkgRoot: pkgRootFrom(import.meta.url),
  skillFile: 'skill/cn-log-retention.md',
  binFile: 'bin/cli.mjs',
  description: '检查日志是否开启、是否记录了该记的、是否留够法定 6 个月',
  whenToUse: 'TODO：写清什么时候该用（用户会说的话也列上）',
});
