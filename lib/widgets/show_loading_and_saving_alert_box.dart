import 'package:flutter/material.dart';

showLoadingAndSavingAlertBox(context){
  showDialog(context: context, builder: (BuildContext context){
    return Container(
      child: AlertDialog(
        content: Column(
          children: [
            Text('Saving' ,),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 30.0,
              width: 30.0,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  });
}