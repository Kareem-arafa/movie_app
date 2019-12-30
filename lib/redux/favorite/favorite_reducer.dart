import 'package:movie_app/redux/favorite/favorite_action.dart';
import 'package:movie_app/redux/favorite/favorite_state.dart';
import 'package:redux/redux.dart';

final favoriteReducer = combineReducers<FavoriteState>([
  TypedReducer<FavoriteState, FavoriteStatusAction>(_favoriteStatus),
 TypedReducer<FavoriteState, SyncFavoriteAction>(_syncFavorite),
]);

FavoriteState _favoriteStatus(
    FavoriteState state, FavoriteStatusAction action) {
  var status = state.status ?? Map();
  status.update(action.report.actionName, (v) => action.report,
      ifAbsent: () => action.report);
  return state.copyWith(status: status);
}

FavoriteState _syncFavorite(
    FavoriteState state, SyncFavoriteAction action) {
  state.favorite=action.favorites;
  return state.copyWith(favorite: state.favorite);
}
