import 'package:equatable/equatable.dart';

class ExamEntity extends Equatable {
  final String id;
  final String title;
  final String duration;
  final int numberOfQuestions;
  final String imagePath;
  final String category;
 const ExamEntity({
    required this.id,
    required this.title,
    required this.duration,
    required this.numberOfQuestions,
    required this.imagePath,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, duration, numberOfQuestions, imagePath, category];
}
