import 'package:flutter/material.dart';
import 'package:light_key/tools/build_grid_card.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:light_key/tools/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _textEditingController =
      new TextEditingController();

  List<Model> items = [];
  var searchState = '';
  var titleName = '모델 검색';
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
                  '찾으실 모델 ${searchState}${searchState == '이름' ? '을' : '를'} 입력해주세요.',
            ),
            onSubmitted: _onSubmit,
          ),
        ),
      );
    });
  }

  _onSubmit(String modelName) async {
    if (modelName.isNotEmpty) {
      items = [];
      var modelList;
      if (searchState == '이름') {
        modelList = await getModelByModelName(modelName, userInfoId);
      } else {
        modelList = await getModelByModelCode(modelName, userInfoId);
      }
      print(modelList);
      if (modelList == null) {
      } else if (modelList.runtimeType != List) {
        items.add(
            Model(modelList['model_info_id'], modelList['model_name'], ''));
      } else {
        for (var listItem in modelList) {
          items.add(
              Model(listItem['model_info_id'], listItem['model_name'], ''));
        }
      }
      print(items);
      _textEditingController.clear();
      setState(() {
        titleName = "${searchState} 검색 결과";
        centerText = "이미 신청을 했거나, 일치하는 결과가 없습니다.";
      });
    }
  }

  _onAddItem(index) async {
    Alert(
      context: context,
      type: AlertType.info,
      title: "키 추가 신청",
      desc: "해당 모델에 키 값을 신청하시겠습니까?",
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
            await insertConnect(userInfoId, items[index].modelId);
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
          backgroundColor: kTopBottomColor,
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
                      trailing: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _onAddItem(index);
                        },
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Text(
                  centerText,
                  style: kNoItemTextStyle,
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
              searchState = '코드';
              titleName = '코드로 검색';
              centerText = '';
            });
            _onAddItemPressed();
          },
          label: '코드로 검색',
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
                searchState = '이름';
                titleName = '이름으로 검색';
                centerText = '';
              });
              _onAddItemPressed();
            },
            label: '이름으로 검색',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: kTopBottomColor,
                fontSize: 16.0),
            labelBackgroundColor: Colors.white),
      ],
    );
  }
}
