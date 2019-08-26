import 'package:dio/dio.dart';

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

var serverPath = '192.168.1.46';
var port = '3001';

var userInfoLoginId = 'sky7th';

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
