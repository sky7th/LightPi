const cron = require('node-cron');
const mysql = require('mysql');
const mysqlConnection = require('./DBConnect')
const sql = require('../query');

module.exports = {
    modelIdList: [],
    connection: mysql.createConnection(mysqlConnection),

    randomString: function () {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
        var string_length = 6;
        var randomstring = '';
        for (var i = 0; i < string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum, rnum + 1);
        }
        //document.randform.randomfield.value = randomstring;
        return randomstring;
    },
    
    getModelIdList: function () {
        this.connection.query(sql.RandomKeySql.SELECT_MODEL_ID, (err, res, fields) => {
            if (err) {
                console.log(err);
            }
            res.forEach(element => {
                this.modelIdList.push(element['id']);
            });
        });
    },
    
    changeModelKeyValue: function (modelId, newModelKeyValue) {
        this.connection.query(sql.RandomKeySql.UPDATE_MODEL_KEY_VALUE, [newModelKeyValue, modelId], (err, res, fields) => {
            if (err) {
                console.log(err);
            }
        });
    },
    
    
    start: function () {
        cron.schedule('*/10 * * * * *', () => {
            this.getModelIdList();
            this.modelIdList.forEach(element => {
                this.changeModelKeyValue(element, this.randomString())
            });
            console.log('keys chanege !!!');
        })
    }
}
