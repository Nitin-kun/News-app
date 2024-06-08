class Category {
  List<String> links;

  Category({required this.links});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      links: List<String>.from(json['links']),
    );
  }
}
