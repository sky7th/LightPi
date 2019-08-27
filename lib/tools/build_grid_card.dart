import 'package:dio/dio.dart';
import 'dart:io';

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

class MyConnect {
  int connectId;
  String modelName;

  MyConnect(int connectId, String modelName) {
    this.connectId = connectId;
    this.modelName = modelName;
  }

  MyConnect.origin() {
    connectId = null;
    modelName = '';
  }
}

var serverPath = '192.168.35.9';
var port = '3001';

int userInfoId = 1;
var userInfoLoginId = 'sky7th';

Future getModelList(userInfoLoginId) async {
  try {
    String urlPath =
        'http://${serverPath}:${port}/model/modelList/${userInfoLoginId}';

    print(urlPath);
    Response response = await Dio().get(urlPath);
    return response.data['data'];
  } catch (e) {
    print(e);
  }
}

Future getConnectApplyList(userInfoLoginId) async {
  try {
    String urlPath = 'http://${serverPath}:${port}/connect/${userInfoLoginId}';

    print(urlPath);
    Response response = await Dio().get(urlPath);
    return response.data['data'];
  } catch (e) {
    print(e);
  }
}

Future getModelKey(modelId) async {
  try {
    String urlPath = 'http://${serverPath}:${port}/model/modelKey/${modelId}';

    print(urlPath);
    Response response = await Dio().get(urlPath);
    return response.data['data']['model_key_value'];
  } catch (e) {
    print(e);
  }
}

Future getModelByModelName(modelName, userLoginId) async {
  try {
    String urlPath =
        'http://${serverPath}:${port}/model/modelName/${modelName}/${userLoginId}';

    print(urlPath);
    Response response = await Dio().get(urlPath);
    return response.data['data'];
  } catch (e) {
    print(e);
  }
}

Future getModelByModelCode(modelCode, userLoginId) async {
  try {
    String urlPath =
        'http://${serverPath}:${port}/model/modelCode/${modelCode}/${userLoginId}';

    print(urlPath);
    Response response = await Dio().get(urlPath);
    return response.data['data'];
  } catch (e) {
    print(e);
  }
}

Future insertConnect(userInfoId, modelInfoId) async {
  try {
    String urlPath = 'http://${serverPath}:${port}/connect/add';
    var postData = {"userInfoId": userInfoId, "modelInfoId": modelInfoId};
    print(urlPath);
    print(postData);
    Response response = await Dio().post(urlPath,
        data: postData,
        options: Options(
            contentType:
                ContentType.parse("application/x-www-form-urlencoded")));
    return response.data['data'];
  } catch (e) {
    print(e);
  }
}

Future deleteConnect(int connectInfoId) async {
  try {
    String urlPath = 'http://${serverPath}:${port}/connect/delete';
    var postData = {"connectInfoId": connectInfoId};
    print(urlPath);
    print(postData);
    Response response = await Dio().post(urlPath,
        data: postData,
        options: Options(
            contentType:
                ContentType.parse("application/x-www-form-urlencoded")));
    return response.data['data'];
  } catch (e) {
    print(e);
  }
}
