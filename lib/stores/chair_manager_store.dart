import 'package:mobx/mobx.dart';

part 'chair_manager_store.g.dart';

class ChairManagerStore = _ChairManagerStore with _$ChairManagerStore;

abstract class _ChairManagerStore with Store {
  @observable
  String selectedChair;

  @action
  void setChangedChair(String value) => selectedChair = value;
}
