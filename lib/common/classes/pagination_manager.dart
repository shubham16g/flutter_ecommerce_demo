
class PaginationManager<T> {
  int page = 1;
  int lastPage = 2;
  bool loading = false;
  List<T?> list = [];

  Future<void> startFetching(
      {required Future<PaginationResponse<T>> Function(int page) fetcher,
        required Function(bool isSuccess, List<T?> list) postCallback}) async {
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
      postCallback(true, list);
    } else {
      postCallback(false, list);
    }
    loading = false;
  }
}

class PaginationResponse<T> {
  final List<T>? list;
  final int lastPage;

  PaginationResponse.success({required this.list, required this.lastPage});

  PaginationResponse.error({this.list, this.lastPage = -1});
}
