const sql = require('../query');

module.exports = {
    getModelByModelName(req, res) {
        let {
            modelName = '', userInfoId
        } = req.params;
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.SearchTabSql.SELECT_MODEL_BY_MODEL_NAME, [modelName, userInfoId], (err, rows) => {
                console.log(modelName);
                res.send({
                    data: rows[0]
                })
            });
        });
    },
    
    getModelByModelCode(req, res) {
        let {
            modelCode = '', userInfoId
        } = req.params;
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.SearchTabSql.SELECT_MODEL_BY_MODEL_CODE, [modelCode, userInfoId], (err, rows) => {
                console.log(modelCode);
                res.send({
                    data: rows[0]
                })
            });
        });
    },
    
    insertConnect(req, res) {
        console.log(req.body);
        let {
            userInfoId = '', modelInfoId = ''
        } = req.body;
        req.getConnection((err, conn) => {
            conn.query(sql.SearchTabSql.INSERT_CONNECT, [userInfoId, modelInfoId], (err, rows) => {
                console.log(userInfoId, modelInfoId);
                if (err)
                    console.log("Error inserting : %s ", err);
                res.send({
                    data: 'Insert connect success'
                })
            });
        });
    }
}