import 'package:flutter/material.dart';
import 'API/CatAPI.dart';

class Favourites extends StatefulWidget {
  Favourites({Key key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}





class _FavouritesState extends State<Favourites> {
  List<String> tmp = new List();

  @override
  void initState(){ 
    super.initState();
    getFav();
  }



  Future getFav()async{
  List<dynamic> list = await CatAPI().getFavour();
  List<String> strings = new List();
  for(var e in list){
    print(e['image']['url']);
    strings.add(e['image']['url']);
  }
  setState(() {
    tmp = strings;
  });
  return null;
} 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        child: ListView.builder(
          itemCount: tmp.length,
          physics: ScrollPhysics(),
          itemBuilder: (c, i)=>Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/1.7,
            child: Image.network(tmp[i], fit: BoxFit.fill,)
          )
          ),
        onRefresh: getFav,
      )
    );
  }
}