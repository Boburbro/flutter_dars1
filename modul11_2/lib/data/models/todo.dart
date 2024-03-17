class Todo {
  final String id;
  final String title;
  final String userId;
  final bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.userId,
    this.isDone = false,
  });
}
