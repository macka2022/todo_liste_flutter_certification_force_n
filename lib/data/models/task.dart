class Task {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String priority;

  Task({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.priority,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      date: DateTime.parse(json["date"]),
      priority: json["priority"] ?? "Moyenne",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
      "date": date.toIso8601String(),
      "priority": priority,
    };
  }
}
