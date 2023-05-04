import 'package:intl/intl.dart';

class NowTime {
  var nowTime = DateTime.now();
  List<String> nowTimeInfo = [];
  Map<String, String> daysInfo = {
    "Sunday": "일요일",
    "Monday": "월요일",
    "Tuesday": "화요일",
    "Wednesday": "수요일",
    "Thursday": "목요일",
    "Friday": "금요일",
    "Saturday": "토요일"
  };

  List<String> timeCutting() {
    var nowTime = DateTime.now();
    var formatNowTime =
        DateFormat('hh mm ss MM dd EEEE').format(nowTime).toString();
    List<String> nowTimeInfo = formatNowTime.split(" ");
    nowTimeInfo[5] = daysInfo[nowTimeInfo[5]]!;
    nowTimeInfo.add((int.parse(nowTimeInfo[0]) * 60 + int.parse(nowTimeInfo[1]))
        .toString());
    return nowTimeInfo;
  }
}
