class News {
  String? id;
  String? name;
  String? description;
  String? url;
  String? category;
  String? language;
  String? country;

  News(
      {this.id,
      this.name,
      this.description,
      this.url,
      this.category,
      this.language,
      this.country});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['source']['id'] ?? '',
      name: json['source']['name'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      category: json['category'] ?? '',
      language: json['language'] ?? '',
      country: json['country'] ?? '',
    );
  }
}
