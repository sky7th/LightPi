import 'package:flutter/material.dart';
import 'package:async_loader/async_loader.dart';
import 'package:light_key/tools/build_grid_card.dart';
import 'package:loader_search_bar/loader_search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class Item {
  String title;

  Item(this.title);
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _textEditingController =
      new TextEditingController();

  List<Item> items = [
    Item('핀컴 동방'),
  ];

  _onAddItemPressed() {
    _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
      return Container(
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 50.0, 32.0, 32.0),
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Please enter a task',
            ),
            onSubmitted: _onSubmit,
          ),
        ),
      );
    });
  }

  _onSubmit(String s) {
    if (s.isNotEmpty) {
      items.add(Item(s));
      _textEditingController.clear();
      setState(() {});
    }
  }

  _onDeleteItem(item) {
    items.removeAt(item);
    setState(() {});
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
                '${items[index].title}',
              ),
              trailing: new IconButton(
                icon: new Icon(Icons.add),
                onPressed: () {
                  _onDeleteItem(index);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _onAddItemPressed();
        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
