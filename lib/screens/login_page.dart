//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:light_key/data/join_or_login.dart';
import 'package:light_key/screens/login_background.dart';
import 'package:light_key/screens/root_page.dart';
import 'package:light_key/tools/build_grid_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            size: size,
            painter: LoginBackground(
                isJoin: Provider.of<JoinOrLogin>(context).isJoin),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.only(top: 20),
//                child: TextFormField(
//                  textAlign: TextAlign.center,
//                  style: TextStyle(color: Colors.blue),
//                  controller: _ipController,
//                  decoration: InputDecoration(
//                    enabledBorder: UnderlineInputBorder(
//                      borderSide: BorderSide(color: Colors.blue),
//                    ),
//                    focusedBorder: UnderlineInputBorder(
//                      borderSide: BorderSide(color: Colors.blue),
//                    ),
//                  ),
//                ),
//              ),
              _logoImage,
//              FadeInImage.assetNetwork(
//                  placeholder: "assets/loading.gif",
//                  image: "https://picsum.photos/200"),
              Consumer<JoinOrLogin>(
                builder: (context, joinOrLogin, child) => Stack(
                  children: <Widget>[
                    _inputForm(size, joinOrLogin),
                    _authButton(size),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.1,
              ),
              Consumer<JoinOrLogin>(
                builder: (context, joinOrLogin, child) => GestureDetector(
                  onTap: () {
                    joinOrLogin.toggle();
                  },
                  child: Text(
                    joinOrLogin.isJoin ? "로그인하기" : "회원가입",
                    style: TextStyle(
                        color: joinOrLogin.isJoin ? Colors.red : Colors.blue,
                        fontSize: 17),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.05,
              )
            ],
          )
        ],
      ),
    );
  }

  void _register(BuildContext context, joinOrLogin) async {
    String login = await joinUser(
        _userIdController.text, _passwordController.text, _nameController.text);
    if (login == 'success') {
      joinOrLogin.toggle();
    } else {
      final snacBar = SnackBar(
        content: Text('이미 존재하는 계정 입니다.'),
      );
      Scaffold.of(context).showSnackBar(snacBar);
    }
  }

  void _login(BuildContext context, joinOrLogin) async {
    String login =
        await loginUser(_userIdController.text, _passwordController.text);

    print(login);
    if (login == 'success') {
//      await storage.write(key: 'isLogin', value: 'true');
      userInfoLoginId = _userIdController.text;
      var userId = await getUserId(userInfoLoginId);
      userInfoId = userId['id'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userLoginId', userInfoLoginId);
      prefs.setInt('userId', userInfoId);
      print('로그인버튼누름');
      print(prefs.getString('userLoginId'));
      Navigator.pushNamed(context, '/tabPage');
//      print(await storage.read(key: 'isLogin'));
    } else {
      final snacBar = SnackBar(
        content: Text('아이디와 비밀번호를 다시 한 번 확인해주세요.'),
      );
      Scaffold.of(context).showSnackBar(snacBar);
    }
  }

  Widget get _logoImage {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
        child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/cute.gif"),
            )),
      ),
    );
  }

  Widget _authButton(Size size) {
    return Positioned(
      left: size.width * 0.15,
      right: size.width * 0.15,
      bottom: 0,
      child: SizedBox(
        height: 50,
        child: Consumer<JoinOrLogin>(
          builder: (context, joinOrLogin, child) => RaisedButton(
              child: Text(
                joinOrLogin.isJoin ? "회원가입" : "로그인",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: joinOrLogin.isJoin ? Colors.red : Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              onPressed: () {
                () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  print(prefs.getString('userLoginId'));
                }();
                if (_formKey.currentState.validate()) {
                  joinOrLogin.isJoin
                      ? _register(context, joinOrLogin)
                      : _login(context, joinOrLogin);
                }
              }),
        ),
      ),
    );
  }

  Widget _inputForm(Size size, joinOrLogin) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _userIdController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.account_circle), labelText: "사용자 아이디"),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "사용자 아이디를 입력해주세요.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key), labelText: "비밀번호"),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "비밀번호를 입력해주세요.";
                    }
                    return null;
                  },
                ),
                joinOrLogin.isJoin == true
                    ? TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.call_to_action),
                            labelText: "사용자 이름"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "이름을 입력해주세요.";
                          }
                          return null;
                        },
                      )
                    : Container(),
                Container(
                  height: 8,
                ),
//                Consumer<JoinOrLogin>(
//                  builder: (context, value, child) => Opacity(
//                    opacity: value.isJoin ? 0 : 1,
//                    child: Text("비밀번호 찾기"),
//                  ),
//                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
