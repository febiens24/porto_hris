class StateModel {
  int? id;
  String? name;
  String? emoji;
  String? emojiU;
  List<Provinsi>? states;

  StateModel({this.id, this.name, this.emoji, this.emojiU, this.states});

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emoji = json['emoji'];
    emojiU = json['emojiU'];
    if (json['states'] != null) {
      states = <Provinsi>[];
      json['states'].forEach((v) {
        states!.add(Provinsi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['emoji'] = emoji;
    data['emojiU'] = emojiU;
    if (states != null) {
      data['states'] = states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provinsi {
  int? id;
  String? name;
  List<City>? city;

  Provinsi({this.id, this.name, this.city});

  Provinsi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['cities'] != null) {
      city = <City>[];
      json['cities'].forEach((v) {
        city!.add(City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (city != null) {
      data['cities'] = city!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
