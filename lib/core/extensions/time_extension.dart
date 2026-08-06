extension TimeExtension on int {
  String formatTime() {
    final int min = this ~/ 60;
    final int sec = this % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }
}
