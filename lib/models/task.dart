class Task{
  String _title;
  DateTime _startTime;
  DateTime _endTime;

  Task(this._title,this._startTime,this._endTime);

  set setTitle(String title){
    _title = title;
  }
  String get getTitle => _title;

  set setStartTime(DateTime startTime){
    _startTime = startTime;
  }
  DateTime get getStartTime => _startTime;

  set setEndTime(DateTime endTime){
    _endTime = endTime;
  }
  DateTime get getEndTime => _endTime;
}