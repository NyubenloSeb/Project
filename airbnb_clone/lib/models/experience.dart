class Experience {
  final String? id;
  final String name;
  final String location;
  final String photo;
  final String description;
  final List<String> images;
  final double rating;
  final String hostName;
  final String experienceDescription;
  final double totalReviews;
  final List<String> perks;
  final double price;

  Experience({
    this.id,
    required this.name,
    required this.location,
    required this.photo,
    required this.description,
    required this.images,
    required this.rating,
    required this.hostName,
    required this.experienceDescription,
    required this.totalReviews,
    required this.perks,
    required this.price,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['_id'],
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      photo: json['photo'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images']),
      rating: (json['rating'] ?? 0).toDouble(),
      hostName: json['hostName'] ?? '',
      experienceDescription: json['experienceDescription'] ?? '',
      totalReviews: (json['totalReviews'] ?? 0).toDouble(),
      perks: List<String>.from(json['perks']),
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}
