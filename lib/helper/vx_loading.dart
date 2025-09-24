abstract class VXLoading {
  void show({String status = '加载中...'}) {}
  void dismiss() {}
  void showSuccess(String message) {}
  void showError(String message) {}
  void showInfo(String message) {}
}
