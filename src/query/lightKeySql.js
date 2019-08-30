const lightKeySql = {};

lightKeySql.SELECT_MODEL_LIST_BY_USER_ID = 
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
    '   AND c.connect_flag = 1'

lightKeySql.SELECT_CONNECT_APPLY_LIST_BY_USER_ID = 
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
    '   AND c.connect_flag = 0'

lightKeySql.SELECT_MASTER_APPLY_LIST_BY_MODEL_INFO_ID = 
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
    '   AND c.connect_flag = 0'

lightKeySql.SELECT_MASTER_APPLY_LIST_BY_USER_NAME = 
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
    '   AND u.user_name = ?';

lightKeySql.SELECT_MASTER_APPLY_LIST_BY_USER_LOGIN_ID = 
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
    '   AND u.user_login_id = ?';

///////////////////////////////////////////////////////////////////////////////////////////////

lightKeySql.SELECT_MASTER_CONNECT_LIST_BY_MODEL_INFO_ID = 
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
    '   AND c.connect_flag = 1'

lightKeySql.SELECT_MASTER_CONNECT_LIST_BY_USER_NAME = 
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
    '   AND u.user_name = ?';

lightKeySql.SELECT_MASTER_CONNECT_LIST_BY_USER_LOGIN_ID = 
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
    '   AND u.user_login_id = ?';

/////////////////////////////////////////////////////////////////////////////////////////

lightKeySql.SELECT_MODEL_KEY_VALUE_BY_MODEL_ID = 
    '   SELECT' +
    '       model_key_value' +
    '   FROM' +
    '       model_info' +
    '   WHERE' +
    '       id = ?;';

lightKeySql.SELECT_MODEL_BY_MODEL_NAME = 
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
    '                    WHERE u.id = ?)';

lightKeySql.SELECT_MODEL_BY_MODEL_CODE = 
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
    '                    WHERE u.id = ?)';

// 연결 신청
lightKeySql.INSERT_CONNECT = 
    '   INSERT INTO connect_info ' + 
    '       ( user_info_id, model_info_id, connect_flag )' +
    '   VALUES ( ?, ?, 0 )';

// 제품 마스터 등록
lightKeySql.UPDATE_MODEL_SET_MASTER_USER_INFO_ID = 
    '   UPDATE model_info ' + 
    '   SET master_user_info_id = ?, model_name = ?' +
    '   WHERE master_user_info_id IS NULL' +
    '   AND model_code = ?'

// 사용자가 마스터인 제품 가져오기
lightKeySql.SELECT_MODEL_BY_MASTER_USER_INFO_ID = 
    '   SELECT id AS model_info_id' +
    '         ,model_name' +
    '         ,model_code' +
    '   FROM model_info' +
    '   WHERE master_user_info_id = ?'

// 모델 이름 변경
lightKeySql.UPDATE_MODEL_NAME = 
    '   UPDATE model_info ' + 
    '   SET model_name = ?' +
    '   WHERE id = ?;';

// 요청 수락 버튼
lightKeySql.UPDATE_CONNECT_SET_CONNECT_FLAG = 
    '   UPDATE connect_info ' +
    '   SET connect_flag = 1' +
    '   WHERE id = ?'

// 요청 거절 버튼
lightKeySql.DELETE_CONNECT_BY_CONNECT_ID = 
    '   DELETE FROM connect_info ' +
    '   WHERE id = ?'




lightKeySql.SELECT_MODEL_ID = 
    '   SELECT id' +
    '   FROM model_info';

lightKeySql.UPDATE_MODEL_KEY_VALUE = 
    '   UPDATE model_info' +
    '   SET model_key_value = ?' +
    '   WHERE id = ?';

module.exports = lightKeySql;