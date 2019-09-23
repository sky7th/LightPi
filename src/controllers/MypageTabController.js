const sql = require('../query');


module.exports = {
    getConnectApplyListByUserId(req, res) {
        let {
            userInfoId
        } = req.params;
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.MypageTabSql.SELECT_CONNECT_APPLY_LIST_BY_USER_ID, [userInfoId], (err, rows) => {
                res.send({
                    data: rows
                })
            });
        });
    },
    
    getModelByMasterUserInfoId(req, res) {
        let {
            masterUserInfoId = ''
        } = req.params;
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.MypageTabSql.SELECT_MODEL_BY_MASTER_USER_INFO_ID, [masterUserInfoId], (err, rows) => {
                console.log(masterUserInfoId);
                res.send({
                    data: rows
                })
            });
        });
    },
    
    updateModelMasterUserInfoId(req, res) {
        let {
            masterUserInfoId = ''
        } = req.body;
        let {
            modelCode = ''
        } = req.body;
        let {
            modelName = ''
        } = req.body;
        console.log(req.body);
        req.getConnection((err, conn) => {
            conn.query(sql.MypageTabSql.UPDATE_MODEL_SET_MASTER_USER_INFO_ID, [masterUserInfoId, modelName, modelCode], (err, rows) => {
                console.log(masterUserInfoId, modelName, modelCode);
                if (err)
                    console.log("Error inserting : %s ", err);
                res.send({
                    data: 'Update model_user_info_id Success'
                })
            });
        });
    },
    
    updateModelName(req, res) {
        let {
            modelName = '', modelInfoId = ''
        } = req.body;
        console.log(req.body);
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.MypageTabSql.UPDATE_MODEL_NAME, [modelName, modelInfoId], (err, rows) => {
                console.log(modelName, modelInfoId);
                if (err)
                    console.log("Error inserting : %s ", err);
                res.send({
                    data: 'Insert Success'
                })
            });
        });
    }
}