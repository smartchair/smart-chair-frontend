class Chair {
  String chairId;
  String chairNickname;

  Chair();

  Chair.toAdd({this.chairId, this.chairNickname});

  String addChairToJson() {
    return '{"chairId": "${this.chairId}", "chairNickname": "${this.chairNickname}"}';
  }
}
