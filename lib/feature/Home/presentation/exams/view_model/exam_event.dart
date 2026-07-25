sealed class ExamEvent {}

class GetAllExams extends ExamEvent{
  final String subjectId;
  final String subjectName;
  GetAllExams(this.subjectId, this.subjectName);
}