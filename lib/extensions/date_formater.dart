import 'package:intl/intl.dart';

String dateFormatter(DateTime date) {
  final formatter = DateFormat('d MMM, yyyy, h:mm a');
  return formatter.format(date);
}
