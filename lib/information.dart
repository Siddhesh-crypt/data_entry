class info{
  String? key;
  InfoData? infoData;

  info({this.key, this.infoData});
}

class InfoData {
  String? id;
  String? name;
  String? address;
  String? age;

  InfoData({this.id, this.name, this.address, this.age});

  InfoData.fromJson(Map<dynamic, dynamic> json){
    id = json["id"];
    name = json["name"];
    address = json["address"];
    age = json["age"];
  }
}

