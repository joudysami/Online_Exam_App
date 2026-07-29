class ExamEntity {
  final String id;
  final String title;
  final String duration;
  final int numberOfQuestions;
  final String imagePath;
  final String category;
  ExamEntity({
    required this.id,
    required this.title,
    required this.duration,
    required this.numberOfQuestions,
    required this.imagePath,
    required this.category,
  });
}
