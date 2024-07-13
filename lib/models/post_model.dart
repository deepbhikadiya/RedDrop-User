class PostModel {
  String? title;
  String? location;
  DateTime? createdAt;
  List<String>? imageUrls;

  PostModel(
  {this.title,
  this.createdAt,
  this.location,
  this.imageUrls,});
}
