class FeedItem {
  final String id;
  final String title;
  final String image;
  final String link;
  final bool read;
  final String description;

  FeedItem({
    this.id,
    this.image,
    this.title,
    this.read,
    this.link,
    this.description,
  });

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
        id: json['id'],
        title: json['title'] ?? "",
        link: json['link'] ?? "",
        //read: false,
        image: json['image'] ?? "",
        description: json['metaDescription'] ?? "");
  }
}
