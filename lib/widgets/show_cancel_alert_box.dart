import 'package:flutter/material.dart';

showCancelAlertBox(parentContext){
  showDialog(context: parentContext, builder: (BuildContext context){
    return AlertDialog(
      content: Text('Discard your changes?'),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
          Navigator.pop(parentContext);
        }, child: Text('Okay'),),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel'),),
      ],
    );
  });
}