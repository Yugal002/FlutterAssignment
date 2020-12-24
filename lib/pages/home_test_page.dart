import 'dart:async';
import 'dart:convert';

import 'package:flutter_assignment/model/wiki_data.dart';
import 'package:flutter_assignment/pages/details_page.dart';
import 'package:flutter_assignment/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class HomeTestPage extends StatefulWidget {
  const HomeTestPage({ Key key }) : super(key: key);

  @override
  _PagesHomeState createState() => new _PagesHomeState();
}

class _PagesHomeState extends State<HomeTestPage> {
  final _searchFetcher = new _Fetcher();
  String _searchingQuery = '';
  List<_EntryWithSummary> _fetchedSearchingEntries = []; // NOTE use `null` to represent loading

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 60.0,
            flexibleSpace: new FlexibleSpaceBar(
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new Container(
                    child: new Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: new Text('Wiki Search', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                      ) // _AnimatedTitleText()
                    ),
                  )
                ],
              )
            )
          ),

          new SliverList(
            delegate: new SliverChildListDelegate([_searchBar()])
          ),
          _buildContent(context),
        ]
      )
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_fetchedSearchingEntries == null) { // NOTE which means loading
      return new SliverFillRemaining(
        child: new Center(
          child: new CircularProgressIndicator()
        )
      );
    }

    return new SliverList(
      delegate: new SliverChildListDelegate(_buildEntriesList(context))
    );
  }

  Widget _searchBar(){
    return new Container(
      margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: new Card(
        child: new Container(
          margin: const EdgeInsets.only(right: 8.0),
          child: new TextField(
            onChanged: _handleSearchTextChanged,
            decoration: const InputDecoration(
              icon: const Icon(Icons.search),
              hintText: 'Search here..',
              border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            ),
          )
        )
      )
    );
  }

  void _handleSearchTextChanged(String str) {
    if (str == _searchingQuery) { return; }
    if (str == '') { return; }

    setState((){
      _searchingQuery = str;
      _fetchedSearchingEntries = null;
    });

    _searchFetcher.search(str).then((List<_EntryWithSummary> fetchedSearchingEntries){
      setState((){
        _fetchedSearchingEntries = fetchedSearchingEntries;
      });
    });
  }

  List<Widget> _buildEntriesList (BuildContext context) {
    List<Widget> list = [];

    if ( _fetchedSearchingEntries.isNotEmpty ) {
      for ( _EntryWithSummary e in _fetchedSearchingEntries ) {
        list
          ..add(
            new ListTile(
              isThreeLine: true,
              dense: true,
              title: new Text(e.title,),
              subtitle: new RichText(
                text: new TextSpan(text: e.summary, style: Theme.of(context).textTheme.caption,),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: (){
              //  Navigator.pushNamed(context, "/entries/${e.title}");

              // pagesList

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(textTitle: e.title, textSummary: e.summary, thumbSource: e.thumbSource.toString()),
                    ));

              }
            ),
          )
          ..add( const Divider() );
      }

      list.removeLast(); // remove last divider
    }

    return [
      new Container(
        margin: const EdgeInsets.all(8.0),
        child: new Card(
          child: new Column(
            children: list
          ),
        )
      )
    ];
  }
}

class _Fetcher {
  List<Pages> pagesList = [];

  http.Client client = new http.Client();

  Future<List<_EntryWithSummary>> search(String str) async {
    client.close();

    client = new http.Client();

    Map data = {'gpssearch': str};
   // var jsonResponse = null;
    var response = await http.post(Constants.BASE_URL, body: data);

   // var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonMap = json.decode(jsonBody);
      print('jsonMap : $jsonMap');
      var list = jsonMap['query']['pages'] as List;
      print(list.runtimeType); //returns List<dynamic>
      pagesList =
          list.map((i) => Pages.fromJson(i)).toList();
    }

    client.close();

    List<_EntryWithSummary> entries = [];
      for (var i = 0; i < pagesList.length; i ++ ) {
      entries.add(new _EntryWithSummary(
          title: pagesList[i].title,
          summary: pagesList[i].terms != null ? pagesList[i].terms.description.toString() : '',
          thumbSource: pagesList[i].thumbnail != null ? pagesList[i].thumbnail.source.toString() : '',

        )
      );
    }

    return entries;
  }
}

class _EntryWithSummary {
  final String title;
  final String summary;
  final String thumbSource;
  _EntryWithSummary({this.title, this.summary, this.thumbSource});
}

