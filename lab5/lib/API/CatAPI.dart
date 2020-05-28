import 'Network.dart';


class CatAPI{

  final String catAPI = "https://api.thecatapi.com/v1/breeds";
  final String catAPIbreed = "https://api.thecatapi.com/v1/images/search?breed_id=";
  final String catImages = "https://api.thecatapi.com/v1/images/search?limit=15";
  final String catBreed = "https://api.thecatapi.com/v1/breeds/search?q=";
  final String catFavourites = "https://api.thecatapi.com/v1/favourites";
  final String getfav = "https://api.thecatapi.com/v1/favourites?limit=10&order=DESC";
  final String catVote = "https://api.thecatapi.com/v1/votes";


  Future<dynamic> getCatBreeds() async {
    var catData = await Network().fetchData(catAPI);
    return catData;
  }

  Future<dynamic> getCatList(String breedname)async{
    var catData = await Network().fetchData('$catAPIbreed$breedname');
    return catData;
  }
  Future<dynamic> getCatByBreed(String breedname)async{
    var catData = await Network().fetchData('$catBreed$breedname');
    return catData;
  }

  Future<dynamic> getImages()async{
    var images = await Network().fetchData(catImages);
    return images;
  }

  Future<dynamic> getFavour()async{
    var fav = await Network().fetchData(getfav);
    print(fav.toString());
    return fav;
  }

  Future<dynamic> addFav(String id)async{
    await Network().postData(catFavourites, id);
  }

  Future<dynamic> vote(String id, int vote)async{
    await Network().postVote(catVote, id, vote);
  }
}