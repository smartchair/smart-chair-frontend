import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/http/chair_controller.dart';
import 'package:smart_chair_frontend/http/teste_mock_post_chair_info_controller.dart';
import 'package:smart_chair_frontend/models/chair.dart';
import 'dart:async';

import 'package:smart_chair_frontend/stores/user_manager_store.dart';

part 'chair_store.g.dart';

class ChairStore = _ChairStore with _$ChairStore;

abstract class _ChairStore with Store {
  _ChairStore({this.chair}) {
    if (chair == null) {
      chair = Chair();
    }

    chairNickname = chair!.chairNickname ?? '';
    chairId = chair!.chairId ?? '';
  }

  Chair? chair;

  @observable
  String? result;

  @observable
  String? error;

  @observable
  bool loading = false;

  @observable
  String? chairNickname = '';

  @observable
  String? chairId;

  @observable
  bool btnClicked = false;

  @observable
  String? selectedChair = '';

  @computed
  bool get nameValid => chairNickname != null && chairNickname != '';
  String? get nameError {
    if (chairNickname!.isNotEmpty || nameValid) {
      return null;
    } else {
      return 'Nome obrigatório';
    }
  }

  @computed
  Function? get deviceNamePressed => nameValid && !loading ? addChair : null;

  @action
  void setError(String? value) => error = value;

  @action
  void setChairNickname(String? value) => chairNickname = value;

  @action
  void setChairId(String? value) => chairId = value;

  @action
  void setChangedChair(String? value) => selectedChair = value;

  @action
  Future<void> getChair() async {
    loading = true;
    error = null;

    try {
      print(
          'inside chair store email ${GetIt.I<UserManagerStore>().user!.email} ');
      GetIt.I<UserManagerStore>().user!.chairs =
          await getChairs(GetIt.I<UserManagerStore>().user!.email);

      print('user manager chair ${userManagerStore!.user!.chairs}');

      if (GetIt.I<UserManagerStore>().user!.chairs!.isNotEmpty) {
        selectedChair = GetIt.I<UserManagerStore>().user!.chairs!.keys.first;
      } else {
        selectedChair = '';
      }
    } catch (e) {
      //error = e as String?;
    }

    loading = false;
  }

  @action
  Future<void> addChair() async {
    btnClicked = true;
    loading = true;
    error = null;

    try {
      var result = await addChairs(chairId, chairNickname);

      GetIt.I<UserManagerStore>().user!.chairs!.addAll(result);
      selectedChair = GetIt.I<UserManagerStore>().user!.chairs!.keys.first;
      await addMockNewChair(chairId);
    } catch (e) {
      error = e as String?;
    }

    loading = false;
  }

  @action
  Future<void> removeChair() async {
    loading = true;
    try {
      await removeChairs(chairId);
      GetIt.I<UserManagerStore>()
          .user!
          .chairs!
          .removeWhere((key, value) => key == chairId);
      selectedChair = '';
      getChair();
    } catch (e) {
      error = e as String?;
    }
    loading = false;
  }

  @action
  void resetChair(String? value) {
    setChairId(value);
    setChairId(value);
    setChairNickname(value);
    setError(value);
    setChangedChair(value);
  }
}
