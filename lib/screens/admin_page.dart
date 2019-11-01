import 'dart:io';

import 'package:flutter/material.dart';
import 'package:light_key/tools/build_grid_card.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:light_key/tools/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

var selectedModelId;
var selectedModelName;

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _modelNameController = TextEditingController();
  final _modelCodeController = TextEditingController();

  var items = [];
  var searchState = '';
  var titleName = '관리';
  var centerText = '오른쪽 하단에 메뉴를 눌러주세요.';
  var changeModelName;

  _getConnectList(searchState) async {
    items = [];
    var myConnectList;
    if (searchState == 'apply') {
      myConnectList = await getConnectApplyList(userInfoId);
    } else {
      // 'master'
      myConnectList = await getModelByMasterUser(userInfoId);
    }

    if (myConnectList == null) {
    } else {
      for (var listItem in myConnectList) {
        if (searchState == 'apply') {
          items.add(
              MyConnect(listItem['connect_info_id'], listItem['model_name']));
        } else {
          // 'master'
          items.add(Model(listItem['model_info_id'], listItem['model_name'],
              listItem['model_code']));
        }
      }
    }
    setState(() {});
  }

  _onDeleteItem(index) async {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "신청 취소",
      desc: "신청을 취소하시겠습니까?",
      style: AlertStyle(
        backgroundColor: Colors.blueGrey,
        titleStyle: TextStyle(color: Colors.white, fontSize: 20),
        descStyle: TextStyle(color: Colors.white, fontSize: 15),
        animationType: AnimationType.grow,
        animationDuration: Duration(milliseconds: 250),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "아니요",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(200, 90, 100, 1.0),
        ),
        DialogButton(
          child: Text(
            "네",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () async {
            await deleteConnect(items[index].connectId);
            items.removeAt(index);
            setState(() {});
            Navigator.pop(context);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        )
      ],
    ).show();
  }

  _onEditItem(index) async {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "",
      desc: "\"${selectedModelName}\" 의 새로운 이름을 입력해주세요.",
      style: AlertStyle(
        backgroundColor: Colors.blueGrey,
        titleStyle: TextStyle(color: Colors.white, fontSize: 23),
        descStyle: TextStyle(color: Colors.white, fontSize: 15),
        animationType: AnimationType.grow,
        animationDuration: Duration(milliseconds: 250),
      ),
      content: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
          ),
          TextField(
            controller: _modelNameController,
            decoration: InputDecoration.collapsed(hintText: "새로운 모델 이름"),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(15),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "취소",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(200, 90, 100, 1.0),
        ),
        DialogButton(
          child: Text(
            "확인",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () async {
            await editModelName(
                _modelNameController.text, items[index].modelId);
            _modelNameController.clear();
            setState(() {});
            _getConnectList(searchState);
            Navigator.pop(context);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        )
      ],
    ).show();
  }

  _onAddItem() async {
    Alert(
      context: context,
      type: AlertType.info,
      title: "",
      desc: "추가할 모델 코드를 입력해주세요.",
      style: AlertStyle(
        backgroundColor: Colors.blueGrey,
        titleStyle: TextStyle(color: Colors.white, fontSize: 23),
        descStyle: TextStyle(color: Colors.white, fontSize: 15),
        animationType: AnimationType.grow,
        animationDuration: Duration(milliseconds: 250),
      ),
      content: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
          ),
          TextField(
            controller: _modelCodeController,
            decoration: InputDecoration.collapsed(hintText: "모델 코드를 입력해주세요."),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          TextField(
            controller: _modelNameController,
            decoration: InputDecoration.collapsed(hintText: "모델 이름을 지어주세요."),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(20),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "취소",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(200, 90, 100, 1.0),
        ),
        DialogButton(
          child: Text(
            "확인",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () async {
            await addModel(userInfoId, _modelCodeController.text,
                _modelNameController.text);
            _modelCodeController.clear();
            _modelNameController.clear();
            setState(() {});
            _getConnectList(searchState);
            Navigator.pop(context);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        )
      ],
    ).show();
  }

  _onLogoutItem() async {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "로그아웃",
      desc: "로그아웃 하시겠습니까?",
      style: AlertStyle(
        backgroundColor: Colors.blueGrey,
        titleStyle: TextStyle(color: Colors.white, fontSize: 20),
        descStyle: TextStyle(color: Colors.white, fontSize: 15),
        animationType: AnimationType.grow,
        animationDuration: Duration(milliseconds: 250),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "아니요",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(200, 90, 100, 1.0),
        ),
        DialogButton(
          child: Text(
            "네",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('userLoginId', 'none');
            prefs.setInt('userId', -1);
            setState(() {});
            Navigator.pop(context);
            exit(0);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(titleName),
          backgroundColor: kTopBottomColor,
        ),
        body: items.length > 0
            ? Container(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(4, 8, 0, 5),
                      child: ListTile(
                          title: Row(
                            children: <Widget>[
                              Icon(Icons.vpn_key),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${items[index].modelName}',
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 6)),
                                  Text(
                                    searchState == 'master'
                                        ? '${items[index].modelCode}'
                                        : '연결 수락 대기 중 (거절 시 사라짐)',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[500]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: searchState == 'apply'
                              ? _applyListIcons(index)
                              : _masterListIcons(index)),
                    );
                  },
                ),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    centerText,
                    style: kNoItemTextStyle,
                  ),
                ),
              ),
        floatingActionButton: _getFAB());
  }

  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      overlayColor: Colors.grey[850],
      backgroundColor: Colors.white,
      foregroundColor: kTopBottomColor,
      marginBottom: 50,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(
            Icons.people_outline,
            color: kTopBottomColor,
          ),
          backgroundColor: Colors.white,
          onTap: () {
            setState(() {
              searchState = 'master';
              titleName = '모델 관리';
              centerText = '등록한 모델이 없습니다.';
            });
            _getConnectList(searchState);
          },
          label: '모델 관리',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: kTopBottomColor,
              fontSize: 16.0),
          labelBackgroundColor: Colors.white,
        ),
        SpeedDialChild(
            child: Icon(
              Icons.people,
              color: kTopBottomColor,
            ),
            backgroundColor: Colors.white,
            onTap: () {
              setState(() {
                searchState = 'apply';
                titleName = '연결 신청 상태';
                centerText = "연결 신청한 모델이 없습니다.";
              });
              _getConnectList(searchState);
            },
            label: '연결 신청 상태',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: kTopBottomColor,
                fontSize: 16.0),
            labelBackgroundColor: Colors.white),
        searchState == 'master'
            ? SpeedDialChild(
                child: Icon(Icons.people),
                backgroundColor: Colors.white,
                onTap: () {
                  setState(() {
                    searchState = 'master';
                    centerText = '오른쪽 하단에 메뉴를 눌러주세요.';
                  });
                  _onAddItem();
                  _getConnectList(searchState);
                },
                label: '새 모델 추가',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: kTopBottomColor,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.white)
            : SpeedDialChild(
                backgroundColor: Colors.white,
                onTap: () {},
              ),
        SpeedDialChild(
            child: Icon(
              Icons.people,
              color: kTopBottomColor,
            ),
            backgroundColor: Colors.white,
            onTap: () {
              setState(() {});
              _onLogoutItem();
            },
            label: '로그아웃',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: kTopBottomColor,
                fontSize: 16.0),
            labelBackgroundColor: Colors.white),
      ],
    );
  }

  Widget _masterListIcons(index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.library_add),
          onPressed: () {
            setState(() {
              if (searchState == 'master') {
                selectedModelId = items[index].modelId;
                selectedModelName = items[index].modelName;
              }
            });
            Navigator.pushNamed(context, '/applyListPage');
          },
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            setState(() {
              if (searchState == 'master') {
                selectedModelId = items[index].modelId;
                selectedModelName = items[index].modelName;
              }
            });
            _onEditItem(index);
          },
        ),
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _applyListIcons(index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            _onDeleteItem(index);
          },
        ),
      ],
    );
  }
}
