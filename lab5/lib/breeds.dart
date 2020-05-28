import 'package:flutter/material.dart';
import 'package:labfive/API/CatAPI.dart';
import 'package:labfive/models/Cats.dart';
import 'SelectedBreed.dart';

class Breeds extends StatefulWidget {
  Breeds({Key key, this.br}) : super(key: key);
  BreedList br;
  @override
  _BreedsState createState() => _BreedsState();
}

class _BreedsState extends State<Breeds> {
  TextEditingController _controller = TextEditingController();
  List<Breed> breeds;
  @override
  void initState() {
    breeds = widget.br.breeds;
    super.initState();
  }
  

  Future<dynamic> findBreed(String breed)async{
    List<dynamic> list = await CatAPI().getCatByBreed(breed);
    if(list[0] != null){
      Breed tmp = Breed.fromJson(list[0] as Map<String, dynamic>);
      return tmp;
    }
    return;
  }  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal:15),
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: TextField(
              textAlign: TextAlign.center,
              cursorColor: Colors.white,
              controller: _controller,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          Breed a = await findBreed(_controller.text);
          if(a != null){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectedBreed(breed: a)));
          }
        },
        child: Icon(Icons.search),
      ),
      body:ListView.separated(
        itemCount: breeds.length,
        separatorBuilder: (context, index) => Divider(color: Colors.black,),
        itemBuilder: (context, index){
          return ListTile(
            onTap: ()=>
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectedBreed(breed: breeds[index]))
            ),
            title: Text(breeds[index].name, style: TextStyle(color: Colors.black, fontSize: 18),),
            isThreeLine: true,
            subtitle: Text(breeds[index].temperament, style: TextStyle(color:Colors.black, fontSize:14)),
          );
        }
      ),
    );
  }
}



