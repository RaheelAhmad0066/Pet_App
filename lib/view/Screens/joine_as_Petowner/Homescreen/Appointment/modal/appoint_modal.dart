class Booking {
  final String date;
  final String time;
  final List<String> services;
  final String text;

  Booking({
    required this.date,
    required this.time,
    required this.services,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'time': time,
      'services': services,
      'text': text,
    };
  }
}
