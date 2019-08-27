import 'package:flutter/material.dart';
import 'package:light_key/tools/build_grid_card.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  int _floatBtnCounter;

  _onAddItemPressed() {
    _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
      return Container(
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 50.0, 32.0, 32.0),
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: '찾으실 모델 이름을 입력해주세요.',
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
      modelList = await getModelByModelName(modelName, userInfoLoginId);
      print(modelList);
      if (modelList == null) {
      } else if (modelList.runtimeType != List) {
        items.add(Model(modelList['id'], modelList['model_name']));
      } else {
        for (var listItem in modelList) {
          items.add(Model(listItem['id'], listItem['model_name']));
        }
      }
      print(items);
      _textEditingController.clear();
      setState(() {});
    }
  }

  _onAddItem(index) async {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "키 추가 신청",
      desc: "해당 모델에 키 값을 신청하시겠습니까?",
      buttons: [
        DialogButton(
          child: Text(
            "아니요",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "네",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            await insertConnect(userInfoId, items[index].modelId);
            items.removeAt(index);
            setState(() {});
            Navigator.pop(context);
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text('Light-Key'),
        ),
        body: new Container(
          child: new ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  '${items[index].modelName}',
                ),
                trailing: new IconButton(
                  icon: new Icon(Icons.add),
                  onPressed: () {
                    _onAddItem(index);
                  },
                ),
              );
            },
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
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.people_outline),
          backgroundColor: Colors.white,
          onTap: () {
            setState(() {
              _floatBtnCounter = 0;
            });
          },
          label: '코드로 검색',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16.0),
          labelBackgroundColor: Colors.white,
        ),
        SpeedDialChild(
            child: Icon(Icons.people),
            backgroundColor: Colors.white,
            onTap: () {
              _onAddItemPressed();
            },
            label: '이름으로 검색',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16.0),
            labelBackgroundColor: Colors.white),
      ],
    );
  }
}
