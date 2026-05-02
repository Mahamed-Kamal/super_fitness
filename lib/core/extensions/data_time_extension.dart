extension DataExtension on DateTime {
  String formatDate() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays == 0) {
      return 'Today $hour:${minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Yesterday $hour:${minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return '${weekdays[weekday - 1]} $hour:${minute.toString().padLeft(2, '0')}';
    } else {
      return '$day/$month/$year';
    }
  }
}
