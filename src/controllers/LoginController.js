const lightKeySql = require('../query');

module.exports =  {
    insertUserInfo(req, res) {
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
    },
    
    getUserLogin(req, res) {
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
    },
    
    getUserIdByUserLoginId(req, res) {
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
    }
}
