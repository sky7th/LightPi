const sql = require('../query');

module.exports =  {
    getModelListByUserId(req, res) {
        let {
            userInfoId
        } = req.params;
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.HomeTabSql.SELECT_MODEL_LIST_BY_USER_ID, [userInfoId], (err, rows) => {
                res.send({
                    data: rows
                })
            });
        });
    },
    
    getModelKeyByModelId(req, res) {
        let {
            modelId
        } = req.params;
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.HomeTabSql.SELECT_MODEL_KEY_VALUE_BY_MODEL_ID, [modelId], (err, rows) => {
                res.send({
                    data: rows[0]
                })
            });
        });
    }
}