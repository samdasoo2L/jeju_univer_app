class BusTimeLine {
  List<int> aTimeLine = [
    485,
    505,
    525,
    570,
    605,
    625,
    645,
    680,
    760,
    785,
    805,
    825,
    870,
    905,
    925,
    945,
    990,
    1020,
    1040,
    1060,
    1080,
    1100,
    1120,
    1200
  ];

  List<int> bTimeLine = [
    490,
    510,
    530,
    580,
    610,
    630,
    650,
    690,
    770,
    790,
    810,
    830,
    880,
    910,
    930,
    950,
    1000,
    1030,
    1050,
    1070,
    1090,
    1110,
    1130,
    1200
  ];
}

class BusStopLocation {
  List<String> aBusStopLocation = [
    "정문",
    "약학대학",
    "해대 1호관",
    "본관",
    "학생회관",
    "인문대 서쪽",
    "학생생활관",
    "인문대 동쪽",
    "중앙도서관",
    "의과대학",
    "공대 4호관",
    "교양동"
  ];
  Map<String, bool> aLocationBool = {
    "정문": false,
    "약학대학": false,
    "해대 1호관": false,
    "본관": false,
    "학생회관": false,
    "인문대 서쪽": false,
    "학생생활관": false,
    "인문대 동쪽": false,
    "중앙도서관": false,
    "의과대학": false,
    "공대 4호관": false,
    "교양동": false
  };
  List<String> bBusStopLocation = [
    "정문",
    "약학대학",
    "해대 1호관",
    "교양동",
    "공대 4호관",
    "의과대학",
    "중앙도서관",
    "인문대 동쪽",
    "학생생활관",
    "인문대 서쪽",
    "학생회관",
    "본관"
  ];
  Map<String, bool> bLocationBool = {
    "정문": false,
    "약학대학": false,
    "해대 1호관": false,
    "교양동": false,
    "공대 4호관": false,
    "의과대학": false,
    "중앙도서관": false,
    "인문대 동쪽": false,
    "학생생활관": false,
    "인문대 서쪽": false,
    "학생회관": false,
    "본관": false
  };
}
