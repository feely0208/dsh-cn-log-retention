// 合规留存：180 天；只记行为不记值
const cfg = { level: 'info', maxDays: 180 };
logger.info('login attempt user=' + userId + ' result=' + ok);
// 反例：这些都不该报 —— 记的是行为不是值
logger.info('user password policy checked for ' + userId);
logger.info('token expired at ' + exp);
