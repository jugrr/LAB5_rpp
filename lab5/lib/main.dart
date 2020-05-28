import 'package:flutter/material.dart';
import 'package:labfive/SplashScreen.dart';
import 'API/CatAPI.dart';
import 'models/Cats.dart';
import 'images.dart';
import 'breeds.dart';
import 'Favourites.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.br}) : super(key: key);

  final BreedList br;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CatList> cr = new List<CatList>();
  int _index = 0;
  ImagesList images;
  bool onstart = true;
  bool onstart1 = true;
  bool onstart2 = true;
  BreedList br;


 
  @override
  void initState() {
    setCatList();
    futureImages();
    getBreeds();
    super.initState();
  }

void setCatList() async{
  for(var i in widget.br.breeds){
    List<dynamic> tmp = await CatAPI().getCatList(i.id);
    cr.add(CatList.fromJson(tmp));
  }
}

Widget futureImages(){
  return FutureBuilder(
    future: onstart? getImages(): null,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      if(snapshot.hasData){
        onstart = false;
        return ShowImagesList(images: images.images);
      }
      if(!onstart)
        return ShowImagesList();
      return Center(child: CircularProgressIndicator(),);
    }
   
  );
}

Widget futureFavourites(){
  return FutureBuilder(
    future: onstart2? getFavourite(): null,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      if(!snapshot.hasData){
        onstart2 = false;
        return Favourites();
      }
      if(!onstart2)
        return Favourites();
      return Center(child: CircularProgressIndicator(),);
    }
   
  );
}


Widget futureBreeds(){
  return FutureBuilder(
    future: onstart1? getBreeds(): null,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      if(snapshot.hasData){
        onstart1 = false;
        return Breeds(br: br);
      }
      if(!onstart1)
        return Breeds();
      return Center(child: CircularProgressIndicator(),);
    }
   
  );
}


  Future getFavourite()async{
    List<dynamic> list = await CatAPI().getFavour();
    for(var e in list){
      print(e.toString());
    }
    return true;
  }
  Future getBreeds()async{
    List<dynamic> list = await CatAPI().getCatBreeds();
    br = BreedList.fromJson(list);
    return br;
  }

  Future getImages()async{
    List<dynamic> list = await CatAPI().getImages();
    images = ImagesList.fromJson(list);
    return images;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cats'),
      ),
      body: IndexedStack(
        index: _index,
        children: <Widget>[
          futureImages(),
          futureFavourites(),
          futureBreeds(),
        ],
      ), 
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _index,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            title: Text('Images'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favourites'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('Breeds')
          )
        ],
        onTap: (value) => setState(()=>_index=value),
      ),
    );
  }
}