class Task {
  String _title;
  DateTime _startTime;
  DateTime _endTime;
  String _category;
  bool priority = false;
  bool reminder = false;

  String _id;

  Task(this._id, this._title, this._startTime, this._endTime, this._category);

  set setId(String id) {
    _id = id;
  }

  String get getId => _id;

  set setTitle(String title) {
    _title = title;
  }

  String get getTitle => _title;

  set setStartTime(DateTime startTime) {
    _startTime = startTime;
  }

  DateTime get getStartTime => _startTime;

  set setEndTime(DateTime endTime) {
    _endTime = endTime;
  }

  DateTime get getEndTime => _endTime;

  set setCategory(String category) {
    _category = category;
  }

  DateTime get getCategory => _endTime;
}
