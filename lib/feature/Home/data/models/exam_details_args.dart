class ExamDetailsArgs {
  final String? examId;
  final String subjectId;
  final String subjectName;
  final String subjectIcon;
  final String ?duration;
  final String? numberOfQuestions;

  const ExamDetailsArgs({
    this.examId,
    required this.subjectId,
    required this.subjectName,
    required this.subjectIcon,
     this.duration,
     this.numberOfQuestions,
  });
}
