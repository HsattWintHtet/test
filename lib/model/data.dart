class Data {
  int _id;
  String _title;
  int _bookmark;
  // bool _isFavorite;


  Data(this._id, this._title, this._bookmark);

  Data.fromMap(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._bookmark = obj['bookmark'];
  }

  int get id => _id;
  String get title => _title;
  int get bookmark => _bookmark;
  // bool get isFavorite=>_isFavorite;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['bookmark'] = _bookmark;
    map["title"] = _title;
    return map;
  }
}
