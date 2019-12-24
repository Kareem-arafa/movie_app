class CastModel {
  int _id;
  List<_Cast> _cast = [];

  CastModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    List<_Cast> temp = [];
    for (int i = 0; i < parsedJson['cast'].length; i++) {
      _Cast cast = _Cast(parsedJson['cast'][i]);
      temp.add(cast);
    }
    _cast = temp;
  }

  List<_Cast> get casts => _cast;

  int get id => _id;
}

class _Cast {

  String _name;
  String _profilePath;


  _Cast(cast) {

    _name = cast['name'];
    _profilePath=cast['profile_path'];
  }


  String get name => _name;

  String get profilePath => _profilePath;
}