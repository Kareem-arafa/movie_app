import 'package:hive/hive.dart';
import 'package:movie_app/data/model/movieDetails_data.dart';

class FavoriteRepository {
  const FavoriteRepository();

  void addFavorite(DetailsModel detailsModel) {
    final favoriteBox = Hive.box('favoriteMovie');
    favoriteBox.add(detailsModel);
  }

  void delete(int index) {
    final favoriteBox = Hive.box('favoriteMovie');
    favoriteBox.deleteAt(index);
  }

  Box<dynamic> getFavorite() {
    final favoriteBox = Hive.box('favoriteMovie');
    return favoriteBox;
  }
}
