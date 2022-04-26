import 'package:intl/intl.dart';

extension StringExtension on String {
  String toDate() {
    DateTime date = DateTime.parse(this);
    return DateFormat("dd MMMM yyyy").format(date);
  }
}
