const express = require('express'),
    path = require('path'),
    morgan = require('morgan'),
    mysql = require('mysql'),
    myConnection = require('express-myconnection');
    cron = require('node-cron');

const lightKeySql = require('./query/lightKeySql');

const app = express();

// importing routes
const lightKeyRoutes = require('./routes/lightKey');

// settings
app.set('port', process.env.PORT || 3001);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

var mysqlConnection = {
    host: 'localhost',
    user: 'root',
    password: 'dlxoghk',
    port: 3306,
    database: 'light_key'
};

// middlewares
app.use(morgan('dev'));
app.use(myConnection(mysql, mysqlConnection, 'single'));
app.use(express.urlencoded({
    extended: false
}));

// routes
app.use('/', lightKeyRoutes);

// static files
app.use(express.static(path.join(__dirname, 'public')));

// starting the server
app.listen(app.get('port'), () => {
    console.log(`server on port ${app.get('port')}`);
});



function randomString() {
    var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
    var string_length = 6;
    var randomstring = '';
    for (var i = 0; i < string_length; i++) {
        var rnum = Math.floor(Math.random() * chars.length);
        randomstring += chars.substring(rnum, rnum + 1);
    }
    //document.randform.randomfield.value = randomstring;
    return randomstring;
}

var modelIdList = [];
var connection = mysql.createConnection(mysqlConnection);

var getModelIdList = () => {
    connection.query(lightKeySql.SELECT_MODEL_ID, function (err, res, fields) {
        if (err) {
            console.log(err);
        }
        res.forEach(element => {
            modelIdList.push(element['id']);
        });
    });
}

var changeModelKeyValue = (modelId, newModelKeyValue) => {
    connection.query(lightKeySql.UPDATE_MODEL_KEY_VALUE, [newModelKeyValue, modelId], function (err, res, fields) {
        if (err) {
            console.log(err);
        }
    });
}


cron.schedule('1 * * * * *', () => {
    getModelIdList();
    modelIdList.forEach(element => {
        changeModelKeyValue(element, randomString())
    });
    console.log('keys chanege !!!');
});