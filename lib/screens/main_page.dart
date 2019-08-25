import 'package:flutter/material.dart';
import 'package:torch/torch.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

const int INTERVAL = 5000;
Stopwatch stopwatch = new Stopwatch();

class Model {
  int modelId;
  String modelName;

  Model(int modelId, String modelName) {
    this.modelId = modelId;
    this.modelName = modelName;
  }

  Model.origin() {
    modelId = null;
    modelName = '';
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  initState() {
    super.initState();
    () async {
      modelList = await getModelList(userInfoLoginId);
    }();
    print(modelList);
    if (modelItems.isEmpty) {
      for (var listItem in modelList) {
        print(listItem);
        modelItems.add(Model(listItem['id'], listItem['model_name']));
      }
    }
  }

  AsciiCodec ascii = AsciiCodec();
  var serverPath = '192.168.35.52';
  var port = '3000';

  var modelList = [];
  var userInfoLoginId = 'sky7th';
  List<Model> modelItems = [];

  List<Card> _buildGridCards(BuildContext context) {
    if (modelItems == null || modelItems.isEmpty) {
      return const <Card>[];
    }
    final ThemeData theme = Theme.of(context);

    return modelItems.map((modelItem) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.3,
              child: RaisedButton(
                onPressed: () async {
                  print('press before');
                  var key = await getModelKey(modelItem.modelId);
                  print(key);
                  setState(() {
                    flashOnByKey(key);
                  });
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 15.0),
                child: Center(
                  child: Text(
                    modelItem.modelName,
                    style: theme.textTheme.title,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Light-Key',
          ),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: _buildGridCards(context),
        ),
        resizeToAvoidBottomInset: false);
  }

  flashLightOn() {
    Torch.turnOn();
  }

  flashLightOff() {
    Torch.turnOff();
  }

  List binaryEncode(decimal) {
    var binaryReverse = [0, 0, 0, 0, 0, 0, 0, 0];

    for (int i = 0; i < 8; i++) {
      binaryReverse[i] = decimal % 2; // 2로 나누었을 때 나머지를 배열에 저장
      decimal = decimal ~/ 2; // 2로 나눈 몫을 저장

      if (decimal == 0) // 몫이 0이 되면 반복을 끝냄
        break;
    }
    print(binaryReverse);

    return binaryReverse;
  }

  void flashOnByKey(key) async {
    if (key != null) {
      var byteKey = ascii.encode(key);
      for (int i = 0; i < key.length; i++) {
        sendValue(binaryEncode(byteKey[i]));
      }
    }
  }

  void sendValue(List binaryList) {
    // start bit 보내기
    flashLightOn();
    stopwatch..reset();
    stopwatch..start();
    // 실제 값 보내기
    for (int i = 0; i < 8; i++) {
      int b = binaryList[i];
      // 비트 사이 시간 간격
      while (stopwatch.elapsedMicroseconds < INTERVAL) {}
      if (b == 1) {
        flashLightOn();
      } else {
        flashLightOff();
      }
      stopwatch..reset();
    }
    while (stopwatch.elapsedMicroseconds < INTERVAL) {} //Busy wait on last bit
    // end bit 보내기
    flashLightOff();
    stopwatch..reset();
    while (stopwatch.elapsedMicroseconds < INTERVAL) {} //Delay on stop bit
  }

  Future getModelList(userInfoLoginId) async {
    try {
      String urlPath =
          'http://${serverPath}:${port}/getModelList/${userInfoLoginId}';

      print(urlPath);
      Response response = await Dio().get(urlPath);
      return response.data['data'];
    } catch (e) {
      print(e);
    }
  }

  Future getModelKey(modelId) async {
    try {
      String urlPath = 'http://${serverPath}:${port}/getModelKey/${modelId}';

      print(urlPath);
      Response response = await Dio().get(urlPath);
      return response.data['data']['key_value'];
    } catch (e) {
      print(e);
    }
  }
}
