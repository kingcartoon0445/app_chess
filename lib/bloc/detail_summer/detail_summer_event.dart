abstract class DetailSummerEvent {
  const DetailSummerEvent();
}

class FetchDetailSummer extends DetailSummerEvent {
  String user;
  String date_from;
  String date_to;
  FetchDetailSummer(
      {required this.user, required this.date_from, required this.date_to});
}
