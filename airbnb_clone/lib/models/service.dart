class Service {
  final String? id;
  final String name;
  final String location;
  final String servicedescription;
  final List<String> images;
  final double rating;
  final String serviceName;
  final double totalReviews;
  final double price;

  Service({
    this.id,
    required this.name,
    required this.location,
    required this.servicedescription,
    required this.images,
    required this.rating,
    required this.serviceName,
    required this.totalReviews,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'],
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      servicedescription: json['description'] ?? '',
      images: List<String>.from(json['images']),
      rating: (json['rating'] ?? 0).toDouble(),
      serviceName: json['hostName'] ?? '',
      totalReviews: (json['totalReviews'] ?? 0).toDouble(),
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}
