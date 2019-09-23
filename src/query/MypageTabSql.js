module.exports = {
    SELECT_CONNECT_APPLY_LIST_BY_USER_ID:
    '   SELECT ' +
    '       c.id AS connect_info_id' +
    '       ,m.model_name' +
    '   FROM ' +
    '       user_info AS u' +
    '   INNER JOIN' +
    '       connect_info AS c ON (u.id = c.user_info_id)' +
    '   INNER JOIN' +
    '       model_info AS m ON (c.model_info_id = m.id)' +
    '   WHERE' +
    '       u.id = ?' +
    '   AND c.connect_flag = 0',

    // 제품 마스터 등록
    UPDATE_MODEL_SET_MASTER_USER_INFO_ID:
    '   UPDATE model_info ' +
    '   SET master_user_info_id = ?, model_name = ?' +
    '   WHERE master_user_info_id IS NULL' +
    '   AND model_code = ?',

    // 사용자가 마스터인 제품 가져오기
    SELECT_MODEL_BY_MASTER_USER_INFO_ID:
    '   SELECT id AS model_info_id' +
    '         ,model_name' +
    '         ,model_code' +
    '   FROM model_info' +
    '   WHERE master_user_info_id = ?',

    // 모델 이름 변경
    UPDATE_MODEL_NAME:
    '   UPDATE model_info ' +
    '   SET model_name = ?' +
    '   WHERE id = ?;'
}