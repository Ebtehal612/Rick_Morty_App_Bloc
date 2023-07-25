import 'location.dart';
import 'origin.dart';

class Character {
  num? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Origin? origin;
  Location? location;
  String? image;
  List<String>? episode;
  String? url;
  DateTime? created;

  Character({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: num.tryParse(json['id'].toString()),
        name: json['name']?.toString(),
        status: json['status']?.toString(),
        species: json['species']?.toString(),
        type: json['type']?.toString(),
        gender: json['gender']?.toString(),
        origin: json['origin'] == null
            ? null
            : Origin.fromJson(Map<String, dynamic>.from(json['origin'])),
        location: json['location'] == null
            ? null
            : Location.fromJson(Map<String, dynamic>.from(json['location'])),
        image: json['image']?.toString(),
        episode: List<String>.from(json['episode'] ?? []),
        url: json['url']?.toString(),
        created: json['created'] == null
            ? null
            : DateTime.tryParse(json['created'].toString()),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (status != null) 'status': status,
        if (species != null) 'species': species,
        if (type != null) 'type': type,
        if (gender != null) 'gender': gender,
        if (origin != null) 'origin': origin?.toJson(),
        if (location != null) 'location': location?.toJson(),
        if (image != null) 'image': image,
        if (episode != null) 'episode': episode,
        if (url != null) 'url': url,
        if (created != null) 'created': created?.toIso8601String(),
      };
}
