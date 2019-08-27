import 'package:flutter/material.dart';
import 'package:light_key/tools/build_grid_card.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<MyConnect> items = [];

  _getConnectList() async {
    items = [];
    var myConnectList = await getConnectApplyList(userInfoLoginId);

    if (myConnectList == null) {
    } else {
      for (var listItem in myConnectList) {
        items.add(
            MyConnect(listItem['connect_info_id'], listItem['model_name']));
        print(listItem);
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
          title: Text('Light-Key'),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  '${items[index].modelName}',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    _onDeleteItem(index);
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
      marginBottom: 50,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.people_outline),
          backgroundColor: Colors.white,
          onTap: () {},
          label: '나의 모델 관리',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16.0),
          labelBackgroundColor: Colors.white,
        ),
        SpeedDialChild(
            child: Icon(Icons.people),
            backgroundColor: Colors.white,
            onTap: () {
              _getConnectList();
            },
            label: '나의 연결 신청 상태',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16.0),
            labelBackgroundColor: Colors.white),
      ],
    );
  }
}
