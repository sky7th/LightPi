module.exports = {
    SELECT_MODEL_BY_MODEL_NAME:
    '   SELECT ' +
    '       m.id AS model_info_id' +
    '       ,m.model_name' +
    '   FROM ' +
    '       model_info AS m' +
    '   WHERE' +
    '       m.model_name = ?' +
    '   AND' +
    '       m.id NOT IN (SELECT c.model_info_id ' +
    '                    FROM user_info AS u' +
    '                    INNER JOIN connect_info AS c' +
    '                    ON u.id = c.user_info_id' +
    '                    WHERE u.id = ?)',

    SELECT_MODEL_BY_MODEL_CODE:
    '   SELECT ' +
    '       m.id AS model_info_id' +
    '       ,m.model_name' +
    '   FROM ' +
    '       model_info AS m' +
    '   WHERE' +
    '       m.model_code = ?' +
    '   AND' +
    '       m.id NOT IN (SELECT c.model_info_id ' +
    '                    FROM user_info AS u' +
    '                    INNER JOIN connect_info AS c' +
    '                    ON u.id = c.user_info_id' +
    '                    WHERE u.id = ?)',

    // 연결 신청
    INSERT_CONNECT:
    '   INSERT INTO connect_info ' +
    '       ( user_info_id, model_info_id, connect_flag )' +
    '   VALUES ( ?, ?, 0 )'
}