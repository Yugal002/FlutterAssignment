import 'dart:async';
import 'dart:convert';
import 'package:flutter_assignment/model/wiki_data.dart';
import 'package:flutter_assignment/utils/constants.dart';
import 'package:http/http.dart' as http;

enum WikiAction {
  Fetch,
}

class WikiBloc {
  List<Pages> pagesList = [];
  int counter;
  final _stateStreamController =
      StreamController<List<Pages>>();
  StreamSink<List<Pages>> get _dataSink => _stateStreamController.sink;
  Stream<List<Pages>> get dataStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<WikiAction>();
  StreamSink<WikiAction> get eventSink => _eventStreamController.sink;
  Stream<WikiAction> get _eventStream => _eventStreamController.stream;

  DataBloc() {
    _eventStream.listen((event) async {
      if (event == WikiAction.Fetch) {
        try {
          var userData = await getData();
          _dataSink.add(userData);
        } on Exception catch (e) {
          _dataSink.addError('Something went wrong');
        }
      }
    });
  }

  Future<List<Pages>> getData() async {
    var client = http.Client();
    try {
      var response = await client.get(Constants.BASE_URL);

      if (response.statusCode == 200) {

        var jsonBody = response.body;
        var jsonMap = json.decode(jsonBody);
        print('jsonMap : $jsonMap');

        print('11111111111111111111111111111111111');

        var list = jsonMap['query']['pages'] as List;
        print(list.runtimeType); //returns List<dynamic>
        pagesList =
            list.map((i) => Pages.fromJson(i)).toList();

       /* var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        for (Map i in jsonMap) {
          urlList.add(WikiData.fromJson(i));
        }*/
      }
    } catch (Exception) {
      return pagesList;
    }

    print(pagesList.length);

    return pagesList;
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
