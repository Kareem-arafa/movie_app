import 'package:hive/hive.dart';
import 'package:movie_app/redux/favorite/favorite_action.dart';
import 'package:redux/redux.dart';
import 'package:movie_app/data/model/movieDetails_data.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';

class FavoriteViewModel {
  final Box<dynamic> favorites;
  final Function() getFavorite;
  final Function(DetailsModel) addFavorite;
  final ActionReport getFavoriteReport;
  final Function(int) removeFavorite;

  FavoriteViewModel({
    this.favorites,
    this.addFavorite,
    this.getFavorite,
    this.getFavoriteReport,
    this.removeFavorite,
  });

  static FavoriteViewModel fromStore(Store<AppState> store) {
    return FavoriteViewModel(
      favorites: store.state.favoriteState.favorite,
      getFavorite: () {
        print(' get favorite');
        store.dispatch(GetFavoriteAction());
      },
      removeFavorite: (index){
        store.dispatch(GetRemoveFavoriteAction(index: index));
      },
      addFavorite: (detailModel){
        store.dispatch(GetAddFavoriteAction(detailsModel: detailModel));
      },
      getFavoriteReport: store.state.moviemodelState.status["GetMovieModelsAction"],

    );
  }
}
