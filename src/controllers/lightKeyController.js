const controller = {};

const lightKeySql = require('../query/lightKeySql');

controller.getModelListByUserId = (req, res) => {
    let {
        userInfoId
    } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MODEL_LIST_BY_USER_ID, [userInfoId], (err, rows) => {
            res.send({
                data: rows
            })
        });
    });
};

controller.getConnectApplyListByUserId = (req, res) => {
    let {
        userInfoId
    } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_CONNECT_APPLY_LIST_BY_USER_ID, [userInfoId], (err, rows) => {
            res.send({
                data: rows
            })
        });
    });
};

controller.getMasterApplyListByModelInfoId = (req, res) => {
    let {
        modelInfoId
    } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MASTER_APPLY_LIST_BY_MODEL_INFO_ID, [modelInfoId], (err, rows) => {
            res.send({
                data: rows
            })
        });
    });
};

controller.getMasterApplyListByUserName = (req, res) => {
    let {
        modelInfoId,
        userName
    } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MASTER_APPLY_LIST_BY_USER_NAME, [modelInfoId, userName], (err, rows) => {
            res.send({
                data: rows
            })
        });
    });
};

controller.getMasterApplyListByUserLoginId = (req, res) => {
    let {
        modelInfoId,
        userLoginId
    } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MASTER_APPLY_LIST_BY_USER_LOGIN_ID, [modelInfoId, userLoginId], (err, rows) => {
            res.send({
                data: rows
            })
        });
    });
};

controller.getMasterConnectListByModelInfoId = (req, res) => {
    let {
        modelInfoId
    } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MASTER_CONNECT_LIST_BY_MODEL_INFO_ID, [modelInfoId], (err, rows) => {
            res.send({
                data: rows
            })
        });
    });
};

controller.getMasterConnectListByUserName = (req, res) => {
    let {
        modelInfoId,
        userName
    } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MASTER_CONNECT_LIST_BY_USER_NAME, [modelInfoId, userName], (err, rows) => {
            res.send({
                data: rows
            })
        });
    });
};

controller.getMasterConnectListByUserLoginId = (req, res) => {
    let {
        modelInfoId,
        userLoginId
    } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MASTER_CONNECT_LIST_BY_USER_LOGIN_ID, [modelInfoId, userLoginId], (err, rows) => {
            res.send({
                data: rows
            })
        });
    });
};

controller.getModelKeyByModelId = (req, res) => {
    let {
        modelId
    } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MODEL_KEY_VALUE_BY_MODEL_ID, [modelId], (err, rows) => {
            res.send({
                data: rows[0]
            })
        });
    });
};

controller.getModelByModelName = (req, res) => {
    let {
        modelName = '', userInfoId
    } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MODEL_BY_MODEL_NAME, [modelName, userInfoId], (err, rows) => {
            console.log(modelName);
            res.send({
                data: rows[0]
            })
        });
    });
};

controller.getModelByModelCode = (req, res) => {
    let {
        modelCode = '', userInfoId
    } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MODEL_BY_MODEL_CODE, [modelCode, userInfoId], (err, rows) => {
            console.log(modelCode);
            res.send({
                data: rows[0]
            })
        });
    });
};

controller.insertConnect = (req, res) => {
    console.log(req.body);
    let {
        userInfoId = '', modelInfoId = ''
    } = req.body;
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.INSERT_CONNECT, [userInfoId, modelInfoId], (err, rows) => {
            console.log(userInfoId, modelInfoId);
            if (err)
                console.log("Error inserting : %s ", err);
            res.send({
                data: 'Insert connect success'
            })
        });
    });
};

controller.updateModelMasterUserInfoId = (req, res) => {
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
        conn.query(lightKeySql.UPDATE_MODEL_SET_MASTER_USER_INFO_ID, [masterUserInfoId, modelName, modelCode], (err, rows) => {
            console.log(masterUserInfoId, modelName, modelCode);
            if (err)
                console.log("Error inserting : %s ", err);
            res.send({
                data: 'Update model_user_info_id Success'
            })
        });
    });
};

controller.getModelByMasterUserInfoId = (req, res) => {
    let {
        masterUserInfoId = ''
    } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MODEL_BY_MASTER_USER_INFO_ID, [masterUserInfoId], (err, rows) => {
            console.log(masterUserInfoId);
            res.send({
                data: rows
            })
        });
    });
};

controller.updateModelName = (req, res) => {
    let {
        modelName = '', modelInfoId = ''
    } = req.body;
    console.log(req.body);
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.UPDATE_MODEL_NAME, [modelName, modelInfoId], (err, rows) => {
            console.log(modelName, modelInfoId);
            if (err)
                console.log("Error inserting : %s ", err);
            res.send({
                data: 'Insert Success'
            })
        });
    });
};

controller.updateConnectSetConnectFlag = (req, res) => {
    let {
        connectInfoId = ''
    } = req.body;
    console.log(req.body);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.UPDATE_CONNECT_SET_CONNECT_FLAG, [connectInfoId], (err, rows) => {
            console.log(connectInfoId);
            if (err)
                console.log("Error update connect_flag : %s ", err);
            res.send({
                data: 'update connect_flag success'
            })
        });
    });
};

controller.deleteConnectByConnectId = (req, res) => {
    let {
        connectInfoId = ''
    } = req.body;
    console.log(req.body);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.DELETE_CONNECT_BY_CONNECT_ID, [connectInfoId], (err, rows) => {
            console.log(connectInfoId);
            if (err)
                console.log("Error delete connect : %s ", err);
            res.send({
                data: 'delete connect success'
            })
        });
    });
};



controller.insertUserInfo = (req, res) => {
    let {
        userLoginId = '', userLoginPw = '', userName = ''
    } = req.body;
    console.log(req.body);
    req.getConnection((err, conn) => {
        conn.query('select * from user_info where user_login_id=?', [userLoginId], function (err, rows) {
            if (err) {
                console.log(err);
            } else {
                conn.query('insert into user_info ( user_login_id, user_login_pw, user_name ) values ( ?, ?, ? )', [userLoginId, userLoginPw, userName], function (err, rows) {
                    if (err)
                        console.log("Error insert user_info : %s ", err);
                    res.send({
                        data: 'success'
                    })
                })
            }
        });
    });
};

controller.getUserLogin = (req, res) => {
    let {
        userLoginId = '', userLoginPw = ''
    } = req.body;
    console.log(req.body);
    req.getConnection((err, conn) => {
        conn.query('select * from user_info where user_login_id=? and user_login_pw=?', [userLoginId, userLoginPw], function (err, rows) {
            console.log(rows);
            if (err) {
                console.log(err);
            }
            if (rows[0] == null) {
                res.send({
                    data: 'fail'
                })
            } else {
                res.send({
                    data: 'success'
                })
            }
        });
    });
};

controller.getUserIdByUserLoginId = (req, res) => {
    let {
        userLoginId
    } = req.body;
    console.log(req.body);
    req.getConnection((err, conn) => {
        conn.query('select id from user_info where user_login_id = ?', [userLoginId], (err, rows) => {
            console.log(rows[0])
            res.send({
                data: rows[0]
            })
        });
    });
};


module.exports = controller;