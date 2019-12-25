class ReviewModel {
  int _id;
  int _page;
  int _totalPages;
  int _totalResults;
  List<_Reviews> _review;

  ReviewModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _page=parsedJson['page'];
    _totalPages=parsedJson['total_pages'];
    _totalResults=parsedJson['total_results'];
    List<_Reviews> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Reviews result = _Reviews(parsedJson['results'][i]);
      temp.add(result);
    }
    _review = temp;
  }
  int get id => _id;
  int get page => _page;
  int get totalPages => _totalPages;
  int get tatalResults => _totalResults;
  List<_Reviews> get review =>_review;
}

class _Reviews {
  String _author;
  String _content;
  String _id;
  String _url;

  _Reviews(review) {
    _author = review['author'];
    _id = review['id'];
    _content = review['content'];
    _url = review['url'];
  }

  String get id => _id;

  String get url => _url;

  String get content => _content;

  String get author => _author;
}
