class Home {
  final String? id;
  final String name;
  final String location;
  final String description;
  final List<String> images;
  final double rating;

  Home({
    this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.images,
    required this.rating,
  });

  //fromJson: create dart object from json recieved via the api

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      id: json['_id'],
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images']),
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}
