import 'package:flutter/material.dart';
import 'package:labfive/models/Cats.dart';
import 'package:labfive/API/CatAPI.dart';


class SelectedBreed extends StatefulWidget {
  SelectedBreed({Key key, this.breed}) : super(key: key);
  final Breed breed;
  @override
  _SelectedBreedState createState() => _SelectedBreedState();
}

class _SelectedBreedState extends State<SelectedBreed> {
  
  CatBreed cat;
  bool isloading = true;
  @override
  void initState() {
    getCat().then((value) => setState((){isloading =false;}));
    super.initState();
  }


  Future<Breed> findBreed(String breed)async{
    List<dynamic> list = await CatAPI().getCatList(breed);
    Breed tmp = Breed.fromJson(list[0].map);
    return tmp;
  }  


  Future<bool> getCat()async{
    print(widget.breed.id);
    List<dynamic> list = await CatAPI().getCatList(widget.breed.id);
    cat = CatBreed.fromJson(list[0] as Map<String, dynamic>);
    print(cat.id);
    print(cat.breeds[0].name);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return isloading? Center(child:Container(child:CircularProgressIndicator(), width: 64, height: 64,)) :
    Scaffold(
      
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              children: <Widget>[
                Container( width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height/3 ,child:Image.network(cat.url),),
                SizedBox(height: 30,),
                Text(cat.breeds[0].name, style: TextStyle(color: Colors.black, fontSize: 18),),
                SizedBox(height: 30),
                
                Text(cat.breeds[0].origin),
                SizedBox(height: 30,),
                Text(cat.breeds[0].description)
              ],
            ),
          )
        ),
      )
    );
  }
}