import 'package:intl/intl.dart';

class DateHelper {

  static Map<String, String> extractDateData(String dateString) {
    // 1. تنسيق الإدخال (يجب أن يطابق النص القادم من الـ JSON تماماً)
    // Example: "Saturday, October 10, 2026 2:00 PM"
    DateFormat inputFormat = DateFormat("EEEE, MMMM d, y h:mm a");

    try {
      // 2. تحويل النص إلى كائن DateTime
      DateTime date = inputFormat.parse(dateString);

      // 3. استخراج البيانات (اليوم، التاريخ، الشهر)
      String dayName = DateFormat('E').format(date);    // Sat
      String dayDate = DateFormat('d').format(date);    // 10
      String monthName = DateFormat('MMM').format(date); // Oct

      // 4. استخراج الوقت (جديد)
      // 'h:mm a' -> تعطي الوقت بصيغة 12 ساعة (مثال: 2:00 PM)
      String time = DateFormat('h:mm a').format(date);

      return {
        "dayName": dayName,
        "dayDate": dayDate,
        "monthName": monthName,
        "time": time, // تمت إضافة الوقت هنا
      };

    } catch (e) {
      print("Error parsing date: $e");
      return {
        "dayName": "",
        "dayDate": "",
        "monthName": "",
        "time": "",
      };
    }
  }
}