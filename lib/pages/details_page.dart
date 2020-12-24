import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/model/wiki_data.dart';
import 'package:flutter_assignment/pages/home_test_page.dart';
import 'package:flutter_assignment/widgets/custom_dialog.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Details', style: TextStyle(color: Colors.black),), elevation: 0, backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30.0,
            color: Colors.black,
          ),
          onPressed: () async{
            var action = await CustomDialog.yesAbortDialog(
                context, 'Reusable Dialog', 'Back to home page?.', 'Yes', 'No');
            if (action == DialogAction.yes) {
              Navigator.of(context).pop();
            } else {}
          },
        ),
      ),
      body:
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           children: [
             SizedBox(height: 10,),
             Card(
               elevation: 3,
               child: Container(
                 width: MediaQuery.of(context).size.width,
                 height: 200,
                 child: widget.thumbSource != '' ? Image.network(widget.thumbSource.toString(), fit: BoxFit.cover,)
                     : Center(child: Text('Image not available')),
               ),
             ),
             
             SizedBox(height: 30,),
             Text(widget.textTitle,  style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 18)),
             SizedBox(height: 10,),
             Text(widget.textSummary, style: TextStyle(color: Colors.black)),

           ],
         ),
       ),
    );
  }
}
