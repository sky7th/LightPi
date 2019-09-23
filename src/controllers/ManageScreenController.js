const sql = require('../query');

module.exports = {
    getMasterApplyListByModelInfoId(req, res) {
        let {
            modelInfoId
        } = req.params;
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.ManageScreenSql.SELECT_MASTER_APPLY_LIST_BY_MODEL_INFO_ID, [modelInfoId], (err, rows) => {
                res.send({
                    data: rows
                })
            });
        });
    },
    
    getMasterApplyListByUserName(req, res) {
        let {
            modelInfoId,
            userName
        } = req.params;
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.ManageScreenSql.SELECT_MASTER_APPLY_LIST_BY_USER_NAME, [modelInfoId, userName], (err, rows) => {
                res.send({
                    data: rows
                })
            });
        });
    },
    
    getMasterApplyListByUserLoginId(req, res) {
        let {
            modelInfoId,
            userLoginId
        } = req.params;
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.ManageScreenSql.SELECT_MASTER_APPLY_LIST_BY_USER_LOGIN_ID, [modelInfoId, userLoginId], (err, rows) => {
                res.send({
                    data: rows
                })
            });
        });
    },
    
    getMasterConnectListByModelInfoId(req, res) {
        let {
            modelInfoId
        } = req.params;
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.ManageScreenSql.SELECT_MASTER_CONNECT_LIST_BY_MODEL_INFO_ID, [modelInfoId], (err, rows) => {
                res.send({
                    data: rows
                })
            });
        });
    },
    
    getMasterConnectListByUserName(req, res) {
        let {
            modelInfoId,
            userName
        } = req.params;
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.ManageScreenSql.SELECT_MASTER_CONNECT_LIST_BY_USER_NAME, [modelInfoId, userName], (err, rows) => {
                res.send({
                    data: rows
                })
            });
        });
    },
    
    getMasterConnectListByUserLoginId(req, res) {
        let {
            modelInfoId,
            userLoginId
        } = req.params;
        console.log(req.params);
        req.getConnection((err, conn) => {
            conn.query(sql.ManageScreenSql.SELECT_MASTER_CONNECT_LIST_BY_USER_LOGIN_ID, [modelInfoId, userLoginId], (err, rows) => {
                res.send({
                    data: rows
                })
            });
        });
    },
    
    updateConnectSetConnectFlag(req, res) {
        let {
            connectInfoId = ''
        } = req.body;
        console.log(req.body);
        req.getConnection((err, conn) => {
            conn.query(sql.ManageScreenSql.UPDATE_CONNECT_SET_CONNECT_FLAG, [connectInfoId], (err, rows) => {
                console.log(connectInfoId);
                if (err)
                    console.log("Error update connect_flag : %s ", err);
                res.send({
                    data: 'update connect_flag success'
                })
            });
        });
    },
    
    deleteConnectByConnectId(req, res) {
        let {
            connectInfoId = ''
        } = req.body;
        console.log(req.body);
        req.getConnection((err, conn) => {
            conn.query(sql.ManageScreenSql.DELETE_CONNECT_BY_CONNECT_ID, [connectInfoId], (err, rows) => {
                console.log(connectInfoId);
                if (err)
                    console.log("Error delete connect : %s ", err);
                res.send({
                    data: 'delete connect success'
                })
            });
        });
    }
}