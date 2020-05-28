

/*
    "adaptability": 5,
    "affection_level": 5,
    "alt_names": "",
    "cfa_url": "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
    "child_friendly": 3,
    "country_code": "EG",
    "country_codes": "EG",
    "description": "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
    "dog_friendly": 4,
    "energy_level": 5,
    "experimental": 0,
    "grooming": 1,
    "hairless": 0,
    "health_issues": 2,
    "hypoallergenic": 0,
    "id": "abys",
    "indoor": 0,
    "intelligence": 5,
    "lap": 1,
    "life_span": "14 - 15",
    "name": "Abyssinian",
    "natural": 1,
    "origin": "Egypt",
    "rare": 0,
    "rex": 0,
    "shedding_level": 2,
    "short_legs": 0,
    "social_needs": 5,
    "stranger_friendly": 5,
    "suppressed_tail": 0,
    "temperament": "Active, Energetic, Independent, Intelligent, Gentle",
    "vcahospitals_url": "https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
    "vetstreet_url": "http://www.vetstreet.com/cats/abyssinian",
    "vocalisation": 1,
    "weight": {
      "imperial": "7  -  10",
      "metric": "3 - 5"
    },
    "wikipedia_url": "https://en.wikipedia.org/wiki/Abyssinian_(cat)"
  },*/


class Breed{
  String id;
  String name;
  String temperament;


  Breed({this.id,this.name,this.temperament});

  factory Breed.fromJson(Map<String, dynamic> json){
    return Breed(
      id: json['id'],
      name: json['name'],
      temperament:json['temperament']
    );
  }
}

class BreedList{
  List<Breed> breeds;

  BreedList({this.breeds});

  factory BreedList.fromJson(List<dynamic> tmp){
    List<Breed> breeds = List<Breed>();
    for(var f in tmp?.map((i)=>Breed.fromJson(i))){
      breeds.add(f);
    }
    return BreedList(
      breeds: breeds
    );
  }

}

class Cat{
  String name;
  String description;
  String origin;

  Cat({this.description,this.origin,this.name});

  factory Cat.fromJson(Map<String, dynamic> json){
    return Cat(
      name: json['name'],
      description: json['description'],
      origin: json['origin']
    );
  }
}

class CatBreed{
  List<Cat> breeds;
  String id;
  String url;
  int width;
  int height;
  
  CatBreed({this.breeds,this.height,this.id,this.url,this.width});

  factory CatBreed.fromJson(Map<String, dynamic> json){
    List<Cat> breeds = List<Cat>();
    print('aaaaa');
    print('bb');
    for(var a in json["breeds"]?.map((f) => Cat.fromJson(f as Map<String, dynamic>))) {
      breeds.add(a);
    }

    return CatBreed(
      breeds: breeds,
      id: json['id'],
      url: json['url'],
      width: json['width'],
      height: json['height']
    );
  }
}


class CatList{
  List<CatBreed> breeds;

  CatList({this.breeds});

  factory CatList.fromJson(List<dynamic> json){
    List<CatBreed> breed = List<CatBreed>();
    for(var tmp in json.map((f)=>CatBreed.fromJson(f as Map<String, dynamic>)).toList()){
      print('aaa');
      print(tmp.breeds[0].name);
      breed.add(tmp);
    }
    return CatList(
      breeds: breed
    );
  }

}


class Images{
  String url;
  String id;
  Images({this.url, this.id});
  factory Images.fromJson(Map<String, dynamic> json){
    return Images(
      url: json['url'],
      id: json['id']
    );
  }
}

class ImagesList{
  List<Images> images;
  ImagesList({this.images});
  factory ImagesList.fromJson(List<dynamic> json){
    List<Images> images = new List();
    print(json[0].toString());
    for(var e in json.map((e) => Images.fromJson(e as Map<String, dynamic>))){
      images.add(e);
    }
    
    return ImagesList(images: images);
  }

}
