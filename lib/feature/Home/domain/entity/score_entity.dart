import 'package:equatable/equatable.dart';

class ScoreEntity extends Equatable {
  final int correct;
  final int incorrect;
  final int total;

  const ScoreEntity({
    required this.correct,
    required this.incorrect,
    required this.total,
  });

  @override
  List<Object?> get props => [correct, incorrect, total];
}
