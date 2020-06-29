import 'package:app/controller/controller.dart';
import 'package:app/view/listdetail/firstdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FirstTab1 extends StatefulWidget {
  @override
  _FirstTab1State createState() => _FirstTab1State();
}

class _FirstTab1State extends State<FirstTab1> {
  @override
  Widget build(BuildContext context) {
    final first = Provider.of<Control>(context);
    return ListView.builder(
      itemCount: first.firstList.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Container(
              height: 45.0,
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FirstDetail(
                            // index : index,
                                id: first.firstList[index].id,
                                title: first.firstList[index].title,
                                bookmark: first.firstList[index].bookmark,
                              )));
                },
                child: ListTile(
                  title: Text(
                    "${first.firstList[index].id}.${first.firstList[index].title}",
                    style: TextStyle(fontSize: 15),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.0,
              child: Container(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black54
                    : Colors.white,
              ),
            )
          ],
        );
      },
    );
  }
}
