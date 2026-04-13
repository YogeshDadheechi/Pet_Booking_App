class PetService {
  final String id;
  final String name;
  final String description;
  final String iconEmoji;
  final double price;
  final String duration;
  final double rating;
  final int reviewCount;
  final String fullDescription;
  final List<String> includes;

  const PetService({
    required this.id,
    required this.name,
    required this.description,
    required this.iconEmoji,
    required this.price,
    required this.duration,
    required this.rating,
    required this.reviewCount,
    required this.fullDescription,
    required this.includes,
  });

  factory PetService.fromJson(Map<String, dynamic> json) {
    return PetService(
      id: json['id'].toString(),
      name: json['title'] ?? '',
      description: json['body'] != null
          ? json['body'].toString().length > 60
          ? json['body'].toString().substring(0, 60)
          : json['body'].toString()
          : '',      iconEmoji: _getEmoji(json['id']),
      price: _getPrice(json['id']),
      duration: _getDuration(json['id']),
      rating: _getRating(json['id']),
      reviewCount: (json['userId'] ?? 1) * 42,
      fullDescription: json['body'] ?? '',
      includes: _getIncludes(json['id']),
    );
  }

  static String _getEmoji(dynamic id) {
    const emojis = ['✂️', '🦮', '🛁', '🏠'];
    return emojis[(int.parse(id.toString()) - 1) % emojis.length];
  }

  static double _getPrice(dynamic id) {
    const prices = [499.0, 299.0, 399.0, 799.0];
    return prices[(int.parse(id.toString()) - 1) % prices.length];
  }

  static String _getDuration(dynamic id) {
    const durations = ['60 min', '45 min', '30 min', '24 hrs'];
    return durations[(int.parse(id.toString()) - 1) % durations.length];
  }

  static double _getRating(dynamic id) {
    const ratings = [4.8, 4.6, 4.7, 4.5];
    return ratings[(int.parse(id.toString()) - 1) % ratings.length];
  }

  static List<String> _getIncludes(dynamic id) {
    const includesList = [
      ['Bath & dry', 'Haircut & styling', 'Nail trimming', 'Ear cleaning'],
      ['30-min walk', 'GPS tracked', 'Post-walk report', 'Treats included'],
      ['Full body clean', 'Paw care', 'Deodorizing spray', 'Brushing'],
      ['Safe stay', 'Meals included', 'Playtime', '24/7 monitoring'],
    ];
    return includesList[(int.parse(id.toString()) - 1) % includesList.length];
  }
}
