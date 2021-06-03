import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/http/chair_controller.dart';
import 'package:smart_chair_frontend/models/chair.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'dart:async';

part 'chair_store.g.dart';

class ChairStore = _ChairStore with _$ChairStore;

abstract class _ChairStore with Store {
  @observable
  String result;

  @observable
  String error;

  @observable
  bool loading = false;

  ObservableList listChairs = ObservableList();

  @action
  void setChairs(List<String> chairs) {
    listChairs.clear();
    listChairs.addAll(chairs);
    loading = false;
  }

  @action
  Future<void> getChair(String email) async {
    loading = true;
    try {
      List<String> newList = [];
      User user = User();
      user.email = email;
      var chairs = await getChairs(user);
      chairs.forEach((item) {
        newList.add(item['chairNickname'].toString());
      });
      setChairs(newList);
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<void> addChair(Chair chair) async {
    loading = true;
    error = null;

    try {
      var result = await addChairs(chair);

      result.forEach(
        (element) {
          listChairs.add(element['chairNickname']);
        },
      );
      loading = false;
    } catch (e) {
      error = e;
    }
  }
}
