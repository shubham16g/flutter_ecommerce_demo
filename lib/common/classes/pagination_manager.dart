class PaginationManager<T> {
  int page = 1;
  int lastPage = 2;
  bool loading = false;
  List<T?> list = [];

  Future<void> startFetching({
    required Future<PaginationResponse<T>> Function(int page) fetcher,
    required Function(List<T?> list) successCallback,
    required Function(int errorCode, String errorMessage) errorCallback,
  }) async {
    if (loading || page > lastPage) return;
    loading = true;
    final response = await fetcher(page);
    if (response.list != null && response.lastPage > 0) {
      lastPage = response.lastPage;
      if (page != 1 && list.isNotEmpty && list.last == null) {
        list.removeLast();
      }
      list.addAll(response.list!);
      if (page < lastPage && list.isNotEmpty) {
        list.add(null);
      }
      page++;
      successCallback(list);
    } else {
      errorCallback(response.errorCode, response.errorMessage);
    }
    loading = false;
  }
}

class PaginationResponse<T> {
  final List<T>? list;
  final int lastPage;
  final int errorCode;
  final String errorMessage;

  PaginationResponse.success({required this.list, required this.lastPage})
      : errorCode = 0,
        errorMessage = '';

  PaginationResponse.error(
      {required this.errorCode, required this.errorMessage})
      : list = null,
        lastPage = -1;
}
