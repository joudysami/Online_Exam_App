class ExamDetailsArgs {
  final String subjectId;
  final String subjectName;
  final String subjectIcon;
  final String ?duration;
  final String? numberOfQuestions;

  const ExamDetailsArgs({
    required this.subjectId,
    required this.subjectName,
    required this.subjectIcon,
     this.duration,
     this.numberOfQuestions,
  });
}
