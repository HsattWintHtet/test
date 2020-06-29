
class Data {
  final String name;
  final String message;
  final String picture;
  final String fullpicture;
  final String time;
  final String source;

  Data({
    this.name,
    this.message,
    this.picture,
    this.fullpicture,
    this.time,
    this.source,
  });

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    return new Data(
        name: json['name'],
        message: json['message'],
        picture: json['picture'],
        fullpicture: json['full_picture'],
        time: json['created_time'],
        source: json['source']);
  }
}
