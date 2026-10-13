// 排障用的日志，只留 7 天；而且把口令打进日志了
const cfg = { level: 'off', maxDays: 7 };
logger.info('login attempt password=' + password);
