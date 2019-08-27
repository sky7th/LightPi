const controller = {};

const lightKeySql = require('../query/lightKeySql');

controller.getModelListByUserId = (req, res) => {
    let { userInfoLoginId } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MODEL_LIST_BY_USER_ID, [userInfoLoginId], (err, rows) => {
            res.send({
                data: rows
            })
        });
    });
};

controller.getModelKeyByModelId = (req, res) => {
    let { modelId } = req.params;
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
    let { modelName = '', loginId } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MODEL_BY_MODEL_NAME, [modelName, loginId], (err, rows) => {
            console.log(modelName);
            res.send({
                data: rows[0]
            })
        });
    });
};

controller.getModelByModelCode = (req, res) => {
    let { modelCode = '', loginId } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MODEL_BY_MODEL_CODE, [modelCode, loginId], (err, rows) => {
            console.log(modelCode);
            res.send({
                data: rows[0]
            })
        });
    });
};

controller.insertConnect = (req, res) => {
    console.log(req.body);
    let { userInfoId = '', modelInfoId = '' } = req.body;
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.INSERT_CONNECT, [userInfoId, modelInfoId], (err, rows) => {
            console.log(userInfoId, modelInfoId);
            if (err)
                console.log("Error inserting : %s ",err );
            res.send({
                data: 'Insert connect success'
            })
        });
    });
};

controller.updateModelMasterUserInfoId = (req, res) => {
    let { masterUserInfoId = '' } = req.body;
    let { modelCode = '' } = req.body;
    console.log(req.body);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.UPDATE_MODEL_SET_MASTER_USER_INFO_ID, [masterUserInfoId, modelCode], (err, rows) => {
            console.log(masterUserInfoId, modelCode);
            if (err)
                console.log("Error inserting : %s ",err );
            res.send({
                data: 'Update model_user_info_id Success'
            })
        });
    });
};

controller.getModelByMasterUserInfoId = (req, res) => {
    let { masterUserInfoId = '' } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.SELECT_MODEL_BY_MASTER_USER_INFO_ID, [masterUserInfoId], (err, rows) => {
            console.log(masterUserInfoId);
            if (err)
                console.log("Error inserting : %s ",err );
            res.send({
                data: 'Insert Success'
            })
        });
    });
};

controller.updateModelName = (req, res) => {
    let { modelName = '' } = req.body;
    let { modelInfoId = '' } = req.params;
    console.log(req.body);
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.UPDATE_MODEL_NAME, [modelName, modelInfoId], (err, rows) => {
            console.log(modelName, modelInfoId);
            if (err)
                console.log("Error inserting : %s ",err );
            res.send({
                data: 'Insert Success'
            })
        });
    });
};

controller.updateConnectSetConnectFlag = (req, res) => {
    let { connectInfoId = '' } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.UPDATE_CONNECT_SET_CONNECT_FLAG, [connectInfoId], (err, rows) => {
            console.log(connectInfoId);
            if (err)
                console.log("Error update connect_flag : %s ",err );
            res.send({
                data: 'update connect_flag success'
            })
        });
    });
};

controller.deleteConnectByConnectId = (req, res) => {
    let { connectInfoId = '' } = req.params;
    console.log(req.params);
    req.getConnection((err, conn) => {
        conn.query(lightKeySql.DELETE_CONNECT_BY_CONNECT_ID, [connectInfoId], (err, rows) => {
            console.log(connectInfoId);
            if (err)
                console.log("Error delete connect : %s ",err );
            res.send({
                data: 'delete connect success'
            })
        });
    });
};

module.exports = controller;