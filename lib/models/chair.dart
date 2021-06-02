class Chair {
  String chairId;
  String chairNickname;
  String userId;
  List<String> chairIds = [];

  Chair({this.chairIds});

  Chair.fromJson(Map<String, dynamic> json) {
    json['chairIds'].forEach((element) {
      this.chairIds.add(element);
    });
  }
}
