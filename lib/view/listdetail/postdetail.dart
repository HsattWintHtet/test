import 'package:app/model/post.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class PostDetail extends StatefulWidget {
  final Data data;
  const PostDetail({Key key, this.data}) : super(key: key);
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.network(widget.data.source ?? "");
   chewieController = ChewieController(
     videoPlayerController: videoPlayerController,
     aspectRatio: 3/2,
     autoPlay: false,
     autoInitialize: true,
     looping: true
   );
    

  }
  @override
  void dispose() {
    super.dispose();
 
      videoPlayerController.dispose();
    chewieController.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Daily Bible Chin"),
          actions: <Widget>[
            IconButton(
              icon: Theme.of(context).brightness == Brightness.light
                  ? Icon(Icons.brightness_2)
                  : Icon(Icons.wb_sunny),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey[800],
                    boxShadow: [BoxShadow(blurRadius: 1.0)]),
                child: Column(
                  children: <Widget>[
                    widget.data.fullpicture != null ? Container(
                          child: Image.network(
                        widget.data.fullpicture ?? "",
                        fit: BoxFit.cover,
                      )) : Container(),
                   
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: 
                        
                          Wrap(
                            children: <Widget>[
                             widget.data.name != null ? Align(
                               alignment: Alignment.centerLeft,
                                                            child: Text(
                                  widget.data.name ?? "",
                                  
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.normal),
                                ),
                             ) : Container(),
                            ],
                          ),
                   
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.insert_invitation,color:Theme.of(context).brightness == Brightness.light ? Colors.black38:Colors.white60,),
                            SizedBox(
                              width: 10,
                            ),
                            
                            Text(DateFormat.yMMMMd("en_US").add_jm().format(DateTime.parse(widget.data.time)) ?? "",style: TextStyle(color:Theme.of(context).brightness == Brightness.light ? Colors.black38:Colors.white60),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Wrap(
                        children: <Widget>[Align( alignment: Alignment.centerLeft, child: Text(widget.data.message ?? ""))],
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                     widget.data.source == null ? Container() :
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Chewie(
                          controller: chewieController,
                        ),
                      ),
                    ) 
                    
                  ],
                )),
          ),
        ));
  }
}
