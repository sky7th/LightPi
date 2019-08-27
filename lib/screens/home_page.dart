//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:async_loader/async_loader.dart';
import 'package:light_key/tools/build_grid_card.dart';
import 'package:light_key/tools/encode_to_flash.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();

  Future<List<Card>> _buildGridCards(BuildContext context) async {
    var modelList = [];
    List<Model> modelItems = [];

    modelList = await getModelList(userInfoLoginId);
    if (modelItems.isEmpty) {
      for (var listItem in modelList) {
        modelItems
            .add(Model(listItem['model_info_id'], listItem['model_name']));
      }
    }

    if (modelItems == null || modelItems.isEmpty) {
      return const <Card>[];
    }
    final ThemeData theme = Theme.of(context);

    return new Future.delayed(
        new Duration(milliseconds: 500),
        () => modelItems.map((modelItem) {
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
                            flashOnByKey('+${key}-');
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
            }).toList());
  }

  @override
  Widget build(BuildContext context) {
    var _asyncCardsLoader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await _buildGridCards(context),
      renderLoad: () => CircularProgressIndicator(),
      renderError: ([error]) => Text('로딩 중에 문제가 생겼습니다.'),
      renderSuccess: ({data}) => GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: data,
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Light-Key',
          ),
        ),
        body: Center(
          child: _asyncCardsLoader,
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () => _asyncLoaderState.currentState
              .reloadState()
              .whenComplete(() => print('finished reload')),
          tooltip: 'Reload',
          child: Icon(Icons.refresh, color: Colors.black),
          backgroundColor: Colors.white,
        ),
        resizeToAvoidBottomInset: false);
  }
}
