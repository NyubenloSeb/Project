class Home {
  final String? id;
  final String name;
  final String location;
  final String description;
  final List<String> images;
  final double rating;
  final String hostName;
  final String propertyDescription;
  final int totalReviews;
  final String perks;

  Home({
    this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.images,
    required this.rating,
    required this.hostName,
    required this.propertyDescription,
    required this.totalReviews,
    required this.perks,
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
      hostName: json['hostName'] ?? '',
      propertyDescription: json['propertyDescription'] ?? '',
      totalReviews: json['totalReviews'] ?? '',
      perks: json['perks'] ?? '',
    );
  }
}
