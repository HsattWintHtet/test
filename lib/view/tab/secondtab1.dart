import 'package:app/controller/controller.dart';
import 'package:app/model/data.dart';
import 'package:app/view/listdetail/seconddetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SecondTab1 extends StatefulWidget {
  @required
  final List<Data> datas;

  const SecondTab1({Key key, this.datas}) : super(key: key);

  @override
  _SecondTab1State createState() => _SecondTab1State();
}

class _SecondTab1State extends State<SecondTab1> {
  @override
  Widget build(BuildContext context) {
    final second = Provider.of<Control>(context);
    return ListView.builder(
      itemCount: second.secondList.length,
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
                          builder: (context) => SecondDetail(
                              id: second.secondList[index].id,
                              title: second.secondList[index].title,
                              bookmark: second.secondList[index].bookmark)));
                },
                child: ListTile(
                  title: Text(
                    "${second.secondList[index].id}.${second.secondList[index].title}",
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
