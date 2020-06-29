import 'package:app/controller/controller.dart';
import 'package:app/util/draweselection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  SearchBar({
    Key key,
    @required this.onCancelSearch,
    this.drawerSelection,
  }) : super(key: key);

  final VoidCallback onCancelSearch;
  final DrawerSelection drawerSelection;

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller = TextEditingController();
  void clearSearchQuery() {
    _controller.clear();

    Control().onSearchChange('');
  }

  FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _controller.addListener(() {
      setState(() {});
    });
    _focusNode.addListener(() {
      setState(() {});
    });
    Control();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final search = Provider.of<Control>(context);
    return SafeArea(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: Container(
            height: 44.0,
            decoration: BoxDecoration(
                color: Colors.white, boxShadow: [BoxShadow(blurRadius: 0.8)]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _focusNode.hasFocus
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: widget.onCancelSearch,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.black,
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.search,
                        ),
                        onPressed: () {},
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.black,
                      ),
                Expanded(
                  child:
                   TextField(
                    focusNode: _focusNode,
                    style: TextStyle(color: Colors.black),
                    textInputAction: TextInputAction.search,
                    controller: _controller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(
                          fontSize: 14.5,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black26
                                    : Colors.black26),
                        suffixIcon: _controller.text.length > 0
                            ? (InkWell(
                                child: Icon(
                                  Icons.close,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.black,
                                ),
                                onTap: clearSearchQuery,
                              ))
                            : Container(
                                width: 50,
                              )),
                    onChanged: search.onSearchChange,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
