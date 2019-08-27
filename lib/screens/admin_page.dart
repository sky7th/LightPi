import 'package:flutter/material.dart';
import 'package:light_key/tools/build_grid_card.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

var selectedModelId;
var selectedModelName;

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var items = [];
  var searchState = '';
  var titleName = '관리';
  var centerText = '오른쪽 하단에 메뉴를 눌러주세요.';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(titleName),
          backgroundColor: Colors.grey[850],
        ),
        body: items.length > 0
            ? Container(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                          '${items[index].modelName}',
                        ),
                        trailing: searchState == 'apply'
                            ? _applyListIcons(index)
                            : _masterListIcons(index));
                  },
                ),
              )
            : Center(
                child: Text(centerText),
              ),
        floatingActionButton: _getFAB());
  }

  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      overlayColor: Colors.grey[850],
      backgroundColor: Colors.white,
      marginBottom: 50,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.people_outline),
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
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16.0),
          labelBackgroundColor: Colors.white,
        ),
        SpeedDialChild(
            child: Icon(Icons.people),
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
                color: Colors.black,
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
          onPressed: () {},
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
