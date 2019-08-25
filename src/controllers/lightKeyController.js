const controller = {};

const lightKeySql = require('../query/lightKeySql');

controller.getModelList = (req, res) => {
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

controller.getModelKey = (req, res) => {
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


module.exports = controller;