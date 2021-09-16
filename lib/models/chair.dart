class Chair {
  String? chairId;
  String? chairNickname;

  int? temp;
  bool? presence;
  int? noise;
  int? lum;
  int? hum;
  DateTime? time;

  Chair();

  Chair.toAdd({this.chairId, this.chairNickname});

  String addChairToJson() {
    return '{"chairId": "${this.chairId}", "chairNickname": "${this.chairNickname}"}';
  }
}
