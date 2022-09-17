class TimerEntry {
  String description;
  String groupName;
  int seconds;
  bool active = false;

  TimerEntry(
      [this.description = "Teste", this.groupName = "g1", this.seconds = 0]);
}
