class TimerEntry {
  String title;
  String? description;
  String groupName;
  late DateTime dateTime;
  int seconds;
  bool active = false;
  bool done = false;

  TimerEntry([this.title = "Teste", this.groupName = "g1", this.seconds = 0]) {
    dateTime = DateTime.now();
  }
}
