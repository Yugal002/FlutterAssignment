import 'package:flutter/material.dart';
import 'package:flutter_assignment/model/wiki_data.dart';
import 'package:flutter_assignment/pages/home_test_page.dart';

class DetailsPage extends StatefulWidget {
   String textTitle='';
   String textSummary='';
   String thumbSource='';

  DetailsPage({Key key, this.textTitle, this.textSummary, this.thumbSource}) : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           children: [
             SizedBox(height: 30,),
             Text('Details', style: TextStyle(fontSize: 20, color: Colors.purple),),
             SizedBox(height: 30,),
             Text('Title: ' + widget.textTitle),
             SizedBox(height: 10,),
             Text('Description: ' + widget.textSummary),

             Text('Description: ' + widget.thumbSource),
           ],
         ),
       ),
    );
  }
}
