import 'package:flutter/material.dart';
import 'package:light_key/tools/build_grid_card.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:light_key/screens/admin_page.dart';

class ApplyListPage extends StatefulWidget {
  @override
  _ApplyListPageState createState() => _ApplyListPageState();
}

class _ApplyListPageState extends State<ApplyListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _textEditingController =
      new TextEditingController();

  List<User> items = [];
  var selectValue = '';
  var searchValue = '';
  var searchState = false;
  var searchInit = true;
  var titleName = '${selectedModelName} 관리 페이지';
  var centerText = '오른쪽 하단에 메뉴를 눌러주세요.';

  _onAddItemPressed() {
    _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
      return Container(
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 50.0, 32.0, 32.0),
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText:
                  '찾으실 유저 ${searchValue}${searchValue == '이름' ? '을' : '를'} 입력해주세요.',
            ),
            onSubmitted: _onSubmit,
          ),
        ),
      );
    });
  }

  _onSubmit(String modelName) async {
    if (modelName == "noSearch" ? true : modelName.isNotEmpty) {
      items = [];
      var modelList;
      if (searchState == false) {
        if (selectValue == 'apply') {
          modelList = await getApplyModelListByModelId(selectedModelId);
        } else if (selectValue == 'connect') {
          modelList = await getConnectModelListByModelId(selectedModelId);
        }
      } else {
        if (selectValue == 'apply') {
          if (searchValue == '이름') {
            modelList =
                await getApplyModelListByUserName(selectedModelId, modelName);
          } else if (searchValue == '아이디') {
            modelList = await getApplyModelListByUserLoginId(
                selectedModelId, modelName);
          }
        } else if (selectValue == 'connect') {
          if (searchValue == '이름') {
            modelList =
                await getConnectModelListByUserName(selectedModelId, modelName);
          } else if (searchValue == '아이디') {
            modelList = await getConnectModelListByUserLoginId(
                selectedModelId, modelName);
          }
        }
      }
      print(modelList);

      if (modelList == null) {
      } else {
        for (var listItem in modelList) {
          items.add(User(listItem['connect_info_id'], listItem['user_login_id'],
              listItem['user_name']));
        }
      }
      print(items);
      _textEditingController.clear();
      setState(() {
        if (searchState == true) {
          titleName = "${searchValue} 검색 결과";
          centerText = "일치하는 결과가 없습니다.";
        }
      });
    }
  }

  _onDeleteItem(index) async {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "유저 삭제",
      desc: "해당 유저를 모델 사용자 목록에서 삭제하시겠습니까?",
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

  _onApplyItem(index) async {
    Alert(
      context: context,
      type: AlertType.info,
      title: "요청 수락",
      desc: "요청을 수락하시겠습니까?",
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
            await updateConnect(items[index].connectId);
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
        ),
        body: items.length > 0
            ? Container(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: <Widget>[
                          Icon(Icons.person_outline),
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 22, 0)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${items[index].userName}',
                              ),
                              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 6)),
                              Text(
                                '${items[index].userLoginId}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: selectValue == 'apply'
                          ? _applyListIcons(index)
                          : _connectListIcons(index),
                      contentPadding: EdgeInsets.fromLTRB(25, 5, 15, 5),
                    );
                  },
                ),
              )
            : Center(
                child: Text(centerText),
              ),
        floatingActionButton: _getFAB());
  }

  Widget _applyListIcons(index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add_circle),
          onPressed: () {
            _onApplyItem(index);
          },
        ),
      ],
    );
  }

  Widget _connectListIcons(index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _onDeleteItem(index);
          },
        ),
      ],
    );
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
              selectValue = 'apply';
              searchState = false;
              searchInit = false;
              titleName = '키 사용 요청 유저';
              centerText = '키 사용을 요청한 유저가 없습니다.';
            });
            if (searchState == false) {
              _onSubmit("noSearch");
            } else {
              _onAddItemPressed();
            }
          },
          label: '키 사용 요청 유저',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16.0),
          labelBackgroundColor: Colors.white,
        ),
        SpeedDialChild(
            child: Icon(Icons.people),
            backgroundColor: Colors.white,
            onTap: () {
              setState(() {
                selectValue = 'connect';
                searchState = false;
                searchInit = false;
                titleName = '키 사용 유저';
                centerText = '키를 사용하는 유저가 없습니다.';
              });
              if (searchState == false) {
                _onSubmit("noSearch");
              } else {
                _onAddItemPressed();
              }
            },
            label: '키 사용 유저',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16.0),
            labelBackgroundColor: Colors.white),
        searchInit == false
            ? SpeedDialChild(
                child: Icon(Icons.search),
                backgroundColor: Colors.white,
                onTap: () {
                  setState(() {
                    titleName =
                        '${selectValue == 'apply' ? '키 사용 요청 유저' : '키 사용 유저'} 검색 (아이디)';
                    searchValue = '아이디';
                    searchState = true;
                    centerText = '';
                  });
                  _onAddItemPressed();
                },
                label: '아이디로 검색',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.white)
            : SpeedDialChild(
                backgroundColor: Colors.white,
                onTap: () {},
              ),
        searchInit == false
            ? SpeedDialChild(
                child: Icon(Icons.search),
                backgroundColor: Colors.white,
                onTap: () {
                  setState(() {
                    titleName =
                        '${selectValue == 'apply' ? '키 사용 요청 유저' : '키 사용 유저'} 검색 (이름)';
                    searchValue = '이름';
                    searchState = true;
                    centerText = '';
                  });
                  _onAddItemPressed();
                },
                label: '이름으로 검색',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.white)
            : SpeedDialChild(
                backgroundColor: Colors.white,
                onTap: () {},
              ),
      ],
    );
  }
}
