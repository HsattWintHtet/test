import 'package:app/view/listdetail/seconddetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../controller/controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class SecondTab2 extends StatefulWidget {
  @override
  _SecondTab2State createState() => _SecondTab2State();
}

class _SecondTab2State extends State<SecondTab2> {
  @override
  void initState() {
    super.initState();
    setState(() {
      Control().createSecondBMList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var secondbm = Provider.of<Control>(context);
    return ListView.builder(
      itemCount: secondbm.secondBMList.length,
      itemBuilder: (context, index) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: "DELETE",
              color: Colors.red,
              icon: Icons.delete,
              onTap: () async {
                 await Control().secondSlideDelete(secondbm.secondBMList[index].id);
                  // setState((){
                  //   Control().secondBMList.remove(Control().secondBMList[index]);
                  // });
              },
            )
          ],
          child: Column(
            children: <Widget>[
              Container(
                height: 45.0,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SecondDetail(
                                  id: secondbm.secondBMList[index].id,
                                  title: secondbm.secondBMList[index].title,
                                  bookmark:
                                      secondbm.secondBMList[index].bookmark,
                                )));
                  },
                  child: ListTile(
                    title: Text(
                      "${secondbm.secondBMList[index].id}.${secondbm.secondBMList[index].title}",
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
          ),
        );
      },
    );
  }
}
