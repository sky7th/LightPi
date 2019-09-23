module.exports = {
    SELECT_MASTER_APPLY_LIST_BY_MODEL_INFO_ID:
    '   SELECT ' +
    '       c.id AS connect_info_id' +
    '       ,u.user_login_id' +
    '       ,u.user_name' +
    '   FROM ' +
    '       user_info AS u' +
    '   INNER JOIN' +
    '       connect_info AS c ON (u.id = c.user_info_id)' +
    '   INNER JOIN' +
    '       model_info AS m ON (c.model_info_id = m.id)' +
    '   WHERE' +
    '       m.id = ?' +
    '   AND c.connect_flag = 0',

    SELECT_MASTER_APPLY_LIST_BY_USER_NAME:
    '   SELECT ' +
    '       c.id AS connect_info_id' +
    '       ,u.user_login_id' +
    '       ,u.user_name' +
    '   FROM ' +
    '       user_info AS u' +
    '   INNER JOIN' +
    '       connect_info AS c ON (u.id = c.user_info_id)' +
    '   INNER JOIN' +
    '       model_info AS m ON (c.model_info_id = m.id)' +
    '   WHERE' +
    '       m.id = ?' +
    '   AND c.connect_flag = 0' +
    '   AND u.user_name = ?',

    SELECT_MASTER_APPLY_LIST_BY_USER_LOGIN_ID:
    '   SELECT ' +
    '       c.id AS connect_info_id' +
    '       ,u.user_login_id' +
    '       ,u.user_name' +
    '   FROM ' +
    '       user_info AS u' +
    '   INNER JOIN' +
    '       connect_info AS c ON (u.id = c.user_info_id)' +
    '   INNER JOIN' +
    '       model_info AS m ON (c.model_info_id = m.id)' +
    '   WHERE' +
    '       m.id = ?' +
    '   AND c.connect_flag = 0' +
    '   AND u.user_login_id = ?',


    SELECT_MASTER_CONNECT_LIST_BY_MODEL_INFO_ID:
    '   SELECT ' +
    '       c.id AS connect_info_id' +
    '       ,u.user_login_id' +
    '       ,u.user_name' +
    '   FROM ' +
    '       user_info AS u' +
    '   INNER JOIN' +
    '       connect_info AS c ON (u.id = c.user_info_id)' +
    '   INNER JOIN' +
    '       model_info AS m ON (c.model_info_id = m.id)' +
    '   WHERE' +
    '       m.id = ?' +
    '   AND c.connect_flag = 1',

    SELECT_MASTER_CONNECT_LIST_BY_USER_NAME:
    '   SELECT ' +
    '       c.id AS connect_info_id' +
    '       ,u.user_login_id' +
    '       ,u.user_name' +
    '   FROM ' +
    '       user_info AS u' +
    '   INNER JOIN' +
    '       connect_info AS c ON (u.id = c.user_info_id)' +
    '   INNER JOIN' +
    '       model_info AS m ON (c.model_info_id = m.id)' +
    '   WHERE' +
    '       m.id = ?' +
    '   AND c.connect_flag = 1' +
    '   AND u.user_name = ?',

    SELECT_MASTER_CONNECT_LIST_BY_USER_LOGIN_ID:
    '   SELECT ' +
    '       c.id AS connect_info_id' +
    '       ,u.user_login_id' +
    '       ,u.user_name' +
    '   FROM ' +
    '       user_info AS u' +
    '   INNER JOIN' +
    '       connect_info AS c ON (u.id = c.user_info_id)' +
    '   INNER JOIN' +
    '       model_info AS m ON (c.model_info_id = m.id)' +
    '   WHERE' +
    '       m.id = ?' +
    '   AND c.connect_flag = 1' +
    '   AND u.user_login_id = ?',

    // 요청 수락 버튼
    UPDATE_CONNECT_SET_CONNECT_FLAG:
    '   UPDATE connect_info ' +
    '   SET connect_flag = 1' +
    '   WHERE id = ?',

    // 요청 거절 버튼
    DELETE_CONNECT_BY_CONNECT_ID:
    '   DELETE FROM connect_info ' +
    '   WHERE id = ?'
}