import 'package:app/controller/controller.dart';
import 'package:app/model/tabdata.dart';
import 'package:app/util/draweselection.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'searchbar.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final DrawerSelection drawerSelection;
  const DefaultAppBar({Key key, this.title, this.drawerSelection})
      : super(key: key);

  @override
  Size get preferredSize => drawerSelection == DrawerSelection.first ||
          drawerSelection == DrawerSelection.second
      ? Size.fromHeight(130.0)
      : Size.fromHeight(56);

  @override
  _DefaultAppBarState createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  bool isInSearchMode = false;

  @override
  void initState() {
    super.initState();
  }

  onScarchChange() {
    setState(() {
      isInSearchMode = true;
    });
  }

  cancelSearch() {
    setState(() {
      isInSearchMode = false;
    });
    Control().onSearchChange('');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AppBar(
        title: Text(
          "${widget.title}",
        ),
        actions: <Widget>[
          (widget.drawerSelection == DrawerSelection.first ||
                      widget.drawerSelection == DrawerSelection.second ) &&
                Control().isBookMark == false
              ? IconButton(
                  onPressed: onScarchChange,
                  icon: Icon(Icons.search),
                )
              : Container(),
          IconButton(
            onPressed: () {
              DynamicTheme.of(context).setBrightness(
                  Theme.of(context).brightness == Brightness.light
                      ? Brightness.dark
                      : Brightness.light);
            },
            icon: Theme.of(context).brightness == Brightness.light
                ? Icon(Icons.brightness_2)
                : Icon(Icons.wb_sunny),
          )
        ],
        bottom: widget.drawerSelection == DrawerSelection.first ||
                widget.drawerSelection == DrawerSelection.second
            ? new TabBar(
                controller: Control().controller,
                onTap: (value) {
                  setState(() {
                    if (value == 1) {
                        Control().isBookMark = true;
                    }
                     else {
                      Control().isBookMark = false;
                    }
                  });
                },
                indicatorColor: Colors.transparent,
                labelColor: Colors.blue,
                labelPadding: EdgeInsets.only(left: 60, right: 60),
                labelStyle: TextStyle(fontSize: 14),
                unselectedLabelColor: Colors.grey[600],
                unselectedLabelStyle: TextStyle(fontSize: 12),
                tabs: tabs.map((a) {
                  return Tab(
                    text: a.title,
                    icon: Icon(a.icon),
                  );
                }).toList(),
              )
            : null,
      ),
      isInSearchMode
          ? SearchBar(
              onCancelSearch: cancelSearch,
            )
          : Container()
    ]);
  }
}
