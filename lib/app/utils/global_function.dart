import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatDateToIndonesia(DateTime time) {
  initializeDateFormatting();
  final DateFormat formatter = DateFormat('EEEE , dd MMMM yyyy', 'id');
  return formatter.format(time);
}

String formatDateToIndonesiaLengkap(DateTime time) {
  initializeDateFormatting();
  final DateFormat formatter = DateFormat('HH:mm | EEEE , dd MMMM yyyy ', 'id');
  return formatter.format(time);
}

bool isToday(DateTime time) {
  
  // is the time is today
  return (time.day == DateTime.now().day &&
      time.month == DateTime.now().month &&
      time.year == DateTime.now().year);
}
