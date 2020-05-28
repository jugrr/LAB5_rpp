import 'package:flutter/material.dart';
import 'package:labfive/models/Cats.dart';
import 'package:labfive/API/CatAPI.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowImagesList extends StatefulWidget {
  ShowImagesList({Key key, this.images}) : super(key: key);
  final List<Images> images;
  @override
  _ShowImagesListState createState() => _ShowImagesListState();
}

class _ShowImagesListState extends State<ShowImagesList> {
  ScrollController _controller = new ScrollController();
  List<Images> images = new List();
  List<Color> tup = new List();
  List<Color> tdown = new List();
  List<Color> fav = new List();


  Future fetchMore()async{
    List<dynamic> lists = await CatAPI().getImages();
    ImagesList tmp = ImagesList.fromJson(lists);
    
    return tmp;
    }

  bool onNotification(ScrollNotification notification){
    if (notification is ScrollUpdateNotification) {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
            fetchMore().then((val) {
              setState(() {
                for(var e in val.images){   
                  images.add(e);
              }});
            });
      }
    }
    return true;
  }



  @override
  void initState() {
    images = widget.images;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: ListView.builder(
         itemCount: images.length,
         controller: _controller,
         itemBuilder: (context, index){
           for(int i =0; i < images.length;i++){
             tup.add(Colors.black);
             tdown.add(Colors.black);
             fav.add(Colors.black);
           }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical:10),
            child:Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8.0,
                    spreadRadius: 4.0, 
                    offset: Offset(3.0, 6.0),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.7,
              
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: CachedNetworkImage(
                        imageUrl: images[index].url,
                        placeholder: (context, url) => Container(width:64, height:64, child: CircularProgressIndicator(), alignment: Alignment.center,),
                        errorWidget: (context, url, error) => Container(child: Icon(Icons.error_outline)),

                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(left:25),
                            child: Align(
                            alignment: Alignment.bottomLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: ()async{
                                          
                                          setState(() {
                                            tup[index] = Colors.green;
                                            tdown[index] = Colors.black;
                                          });
                                          await CatAPI().vote(images[index].id, 1);
                                        },
                                        child: Icon(Icons.thumb_up, size: 25, color: tup[index]),
                                      ),
                                      Padding(padding: EdgeInsets.symmetric(horizontal:15),),
                                      GestureDetector(
                                        onTap: ()async{
                                          setState(() {
                                            tdown[index] = Colors.red;
                                            tup[index] = Colors.black;
                                          });
                                          await CatAPI().vote(images[index].id, 0);
                                        },
                                        child: Icon(Icons.thumb_down, size: 25, color: tdown[index]),
                                      ),
                                    ]
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25),
                                    child: GestureDetector(
                                      onTap: ()async{
                                          setState(() {
                                            fav[index] = Colors.yellow[800];
                                          });
                                          await CatAPI().addFav(images[index].id);
                                        },
                                        child: Icon(Icons.star, size: 25, color: fav[index]),
                                      ),
                                  ),
                                  
                                  
                                ],
                              ),
                          ),
                        ),
                      ),
                  ),
                ]
              )
          ));  
         }
      ) 
    );
  }
}