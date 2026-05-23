import 'package:intl/intl.dart';

class DateHelpers {
  static String formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy', 'id_ID').format(date);
  }

  static String formatShort(DateTime date) {
    return DateFormat('d MMM yyyy', 'id_ID').format(date);
  }

  static int daysBetween(DateTime from, DateTime to) {
    final fromDate = DateTime(from.year, from.month, from.day);
    final toDate = DateTime(to.year, to.month, to.day);
    return toDate.difference(fromDate).inDays;
  }

  static int daysSince(DateTime date) {
    return daysBetween(date, DateTime.now());
  }

  static String daysLabel(int days) {
    if (days == 0) return 'hari ini';
    if (days == 1) return '1 hari';
    return '$days hari';
  }

  // Hitung milestone berikutnya dari anniversary
  static Map<String, dynamic>? nextMilestone(DateTime anniversary) {
    final milestones = [
      30, 50, 100, 150, 200, 250, 300, 365,
      500, 730, 1000, 1095, 1460, 1825,
    ];
    final labels = {
      30: '30 hari',
      50: '50 hari',
      100: '100 hari',
      150: '150 hari',
      200: '200 hari',
      250: '250 hari',
      300: '300 hari',
      365: '1 tahun',
      500: '500 hari',
      730: '2 tahun',
      1000: '1000 hari',
      1095: '3 tahun',
      1460: '4 tahun',
      1825: '5 tahun',
    };

    final today = DateTime.now();
    final days = daysBetween(anniversary, today);

    for (final milestone in milestones) {
      if (days < milestone) {
        final milestoneDate = anniversary.add(Duration(days: milestone));
        return {
          'day': milestone,
          'date': milestoneDate,
          'label': labels[milestone] ?? '$milestone hari',
          'daysLeft': milestone - days,
        };
      }
    }
    return null;
  }
}
