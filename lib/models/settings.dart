class Setting {
  final String title;
  final String status;

  Setting({this.status, this.title});

  Setting.fromMap(Map map)
      : this.title = map['title'],
        this.status = map['status'];

  Map toMap() {
    return {
      'title': this.title,
      'status': this.status
    };
  }
}
