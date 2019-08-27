import 'package:dio/dio.dart';
import 'dart:io';

class Model {
  int modelId;
  String modelName;
  String modelCode;

  Model(int modelId, String modelName, String modelCode) {
    this.modelId = modelId;
    this.modelName = modelName;
    this.modelCode = modelCode;
  }

  Model.origin() {
    modelId = null;
    modelName = '';
    modelCode = '';
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

class User {
  int connectId;
  String userLoginId;
  String userName;

  User(int connectId, String userLoginId, String userName) {
    this.connectId = connectId;
    this.userLoginId = userLoginId;
    this.userName = userName;
  }

  User.origin() {
    connectId = null;
    userLoginId = '';
    userName = '';
  }
}

var serverPath = '192.168.35.9';
var port = '3001';

int userInfoId = 1;
var userInfoLoginId = 'sky7th';

Future getModelList(userInfoId) async {
  try {
    String urlPath =
        'http://${serverPath}:${port}/model/modelList/${userInfoId}';

    print(urlPath);
    Response response = await Dio().get(urlPath);
    return response.data['data'];
  } catch (e) {
    print(e);
  }
}

Future getConnectApplyList(userInfoId) async {
  try {
    String urlPath = 'http://${serverPath}:${port}/connect/${userInfoId}';

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

Future getModelByModelName(modelName, userInfoId) async {
  try {
    String urlPath =
        'http://${serverPath}:${port}/model/modelName/${modelName}/${userInfoId}';

    print(urlPath);
    Response response = await Dio().get(urlPath);
    return response.data['data'];
  } catch (e) {
    print(e);
  }
}

Future getModelByModelCode(modelCode, userInfoId) async {
  try {
    String urlPath =
        'http://${serverPath}:${port}/model/modelCode/${modelCode}/${userInfoId}';

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

Future getModelByMasterUser(masterUserInfoId) async {
  try {
    String urlPath =
        'http://${serverPath}:${port}/model/masterModelList/${masterUserInfoId}';

    print(urlPath);
    Response response = await Dio().get(urlPath);
    return response.data['data'];
  } catch (e) {
    print(e);
  }
}

Future getApplyModelListByModelId(modelId) async {
  try {
    String urlPath =
        'http://${serverPath}:${port}/model/applyModelList/${modelId}';

    print(urlPath);
    Response response = await Dio().get(urlPath);
    return response.data['data'];
  } catch (e) {
    print(e);
  }
}

Future getConnectModelListByModelId(modelId) async {
  try {
    String urlPath =
        'http://${serverPath}:${port}/model/connectModelList/${modelId}';

    print(urlPath);
    Response response = await Dio().get(urlPath);
    return response.data['data'];
  } catch (e) {
    print(e);
  }
}

Future updateConnect(connectInfoId) async {
  try {
    String urlPath = 'http://${serverPath}:${port}/connect/edit';
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
