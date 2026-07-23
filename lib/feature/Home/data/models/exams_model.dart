import 'package:exam_app/core/constant/app_images.dart';

class ExamModel {
  final String title;
  final String duration;
  final int numberOfQuestions;
  final double fromScore;
  final double toScore;
  final String imagePath;
  final String category;

  const ExamModel({
    required this.title,
    required this.duration,
    required this.numberOfQuestions,
    required this.fromScore,
    required this.toScore,
    required this.imagePath,
    required this.category,
  });
}

final Map<String, List<ExamModel>> mockExamsBySubject = {
  'Language': [
    const ExamModel(
      title: 'High level',
      duration: '30 Minutes',
      numberOfQuestions: 20,
      fromScore: 1.00,
      toScore: 6.00,
      imagePath: AppImages.language,
      category: 'English',
    ),
    const ExamModel(
      title: 'High level',
      duration: '30 Minutes',
      numberOfQuestions: 20,
      fromScore: 1.00,
      toScore: 6.00,
      imagePath: AppImages.language,
      category: 'English',
    ),
    const ExamModel(
      title: 'High level',
      duration: '30 Minutes',
      numberOfQuestions: 20,
      fromScore: 1.00,
      toScore: 6.00,
      imagePath: AppImages.language,
      category: 'English',
    ),
    const ExamModel(
      title: 'High level',
      duration: '30 Minutes',
      numberOfQuestions: 20,
      fromScore: 1.00,
      toScore: 6.00,
      imagePath: AppImages.language,
      category: 'Spanish',
    ),
    const ExamModel(
      title: 'High level',
      duration: '30 Minutes',
      numberOfQuestions: 20,
      fromScore: 1.00,
      toScore: 6.00,
      imagePath: AppImages.language,
      category: 'Spanish',
    ),
  ],
  'Math': [
    const ExamModel(
      title: 'Calculus I',
      duration: '45 Minutes',
      numberOfQuestions: 15,
      fromScore: 0.00,
      toScore: 10.00,
      imagePath: AppImages.math,
      category: 'Calculus',
    ),
    const ExamModel(
      title: 'Algebra Basics',
      duration: '30 Minutes',
      numberOfQuestions: 10,
      fromScore: 1.00,
      toScore: 5.00,
      imagePath: AppImages.math,
      category: 'Algebra',
    ),
  ],
  'Art': [
    const ExamModel(
      title: 'Renaissance Art',
      duration: '20 Minutes',
      numberOfQuestions: 12,
      fromScore: 1.00,
      toScore: 4.00,
      imagePath: AppImages.art,
      category: 'History of Art',
    ),
  ],
  'Science': [
    const ExamModel(
      title: 'Basic Physics',
      duration: '40 Minutes',
      numberOfQuestions: 25,
      fromScore: 2.00,
      toScore: 8.00,
      imagePath: AppImages.science,
      category: 'Physics',
    ),
  ],
};
