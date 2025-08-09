


String getDayOfWeek(int day) {
  List<String> days = [
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
  ];
  return days[day - 1]; // Dart's weekday starts from 1 (Monday) to 7 (Sunday)
}