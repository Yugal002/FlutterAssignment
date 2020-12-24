import 'package:flutter/material.dart';

enum DialogAction { yes, abort, cancel }

class CustomDialog {
  static Future<DialogAction> yesAbortDialog(BuildContext context,
      String title,
      String body,
      String positive,
      String negative,
      {String cancel = null}

  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.purple, width: 1),
            ),
            title: Container(
              //color: LightColor.primaryColor,
              child: Row(
                children: <Widget>[
                  Center(
                    child: Text(title,
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.bold, color: Colors.purple,),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,// LightColor.primaryColor,
            elevation: 6,
            content: Text(body,
              style: TextStyle(
                  color: Colors.black54),),
            actions: <Widget>[
              Opacity(
                opacity: negative.isEmpty ? 0.0 : 1.0,
                child: FlatButton(
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: Colors.white,
                      )),
                  onPressed: () =>
                      Navigator.of(context).pop(DialogAction.abort),
                  child: Text(negative, // const
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: <Widget>[
                  FlatButton(
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.white)),
                    onPressed: () =>
                        Navigator.of(context).pop(DialogAction.yes),
                    child: Text(positive, // const
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              cancel != null ? SizedBox(
                width: 10,
              ): Container(),
              cancel != null ? Column(
                children: <Widget>[
                  FlatButton(
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.white)),
                    onPressed: () =>
                        Navigator.of(context).pop(DialogAction.cancel),
                    child: Text(cancel, // const
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ): Container()
            ],
          ),
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}

/*class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 80,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 66),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


}*/
