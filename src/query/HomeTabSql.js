module.exports = {
    SELECT_MODEL_LIST_BY_USER_ID: 
    '   SELECT ' +
    '       m.id AS model_info_id' +
    '       ,m.model_name' +
    '   FROM ' +
    '       user_info AS u' +
    '   INNER JOIN' +
    '       connect_info AS c ON (u.id = c.user_info_id)' +
    '   INNER JOIN' +
    '       model_info AS m ON (c.model_info_id = m.id)' +
    '   WHERE' +
    '       u.id = ?' +
    '   AND c.connect_flag = 1',
    
    SELECT_MODEL_KEY_VALUE_BY_MODEL_ID: 
        '   SELECT' +
        '       model_key_value' +
        '   FROM' +
        '       model_info' +
        '   WHERE' +
        '       id = ?;'
}