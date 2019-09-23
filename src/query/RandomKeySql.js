module.exports = {
    SELECT_MODEL_ID:
    '   SELECT id' +
    '   FROM model_info',

    UPDATE_MODEL_KEY_VALUE:
    '   UPDATE model_info' +
    '   SET model_key_value = ?' +
    '   WHERE id = ?'
}