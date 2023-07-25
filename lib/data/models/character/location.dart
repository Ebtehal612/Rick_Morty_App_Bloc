class Location {
  String? name;
  String? url;

  Location({this.name, this.url});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name']?.toString(),
        url: json['url']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (url != null) 'url': url,
      };
}
