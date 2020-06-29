import 'package:app/view/listdetail/firstdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../controller/controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class FirstTab2 extends StatefulWidget {
  @override
  _FirstTab2State createState() => _FirstTab2State();
}

class _FirstTab2State extends State<FirstTab2> {
  @override
  void initState() {
    super.initState();
    setState(() {
      Control().createFirstBMList();
    });
  }
  @override
  Widget build(BuildContext context) {
    var firstbm = Provider.of<Control>(context);
    return ListView.builder(
      itemCount: firstbm.firstBMList.length,
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
                await Control().firstSlideDelete(firstbm.firstBMList[index].id);
                // setState((){
                  //  Control().firstBMList.remove(Control().firstBMList[index]);
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
                            builder: (context) => FirstDetail(
                                  id: firstbm.firstBMList[index].id,
                                  title: firstbm.firstBMList[index].title,
                                  bookmark: firstbm.firstBMList[index].bookmark,
                                )));
                  },
                  child: ListTile(
                    title: Text(
                      "${firstbm.firstBMList[index].id}.${firstbm.firstBMList[index].title}",
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
