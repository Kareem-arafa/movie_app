import 'package:movie_app/data/remote/favorite_repository.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/favorite/favorite_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createFavoriteMiddleware([
  FavoriteRepository _repository = const FavoriteRepository(),
]) {
  final getFavorite = _createGetFavorite(_repository);
  final removeFavorite = _createRemoveFavorite(_repository);
  final addFavorite = _createAddFavorite(_repository);

  return [
    TypedMiddleware<AppState, GetFavoriteAction>(getFavorite),
    TypedMiddleware<AppState, GetRemoveFavoriteAction>(removeFavorite),
    TypedMiddleware<AppState, GetAddFavoriteAction>(addFavorite),
  ];
}

Middleware<AppState> _createAddFavorite(FavoriteRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);

    repository.addFavorite(action.detailsModel);
  };
}

Middleware<AppState> _createRemoveFavorite(FavoriteRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);

    repository.delete(action.index);
  };
}

Middleware<AppState> _createGetFavorite(FavoriteRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);

    var favorite = repository.getFavorite();
    print(favorite.length);
    next(SyncFavoriteAction(favorites: favorite));
  };
}

void catchError(NextDispatcher next, action, error) {
  next(FavoriteStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "${action.actionName} is error;${error.toString()}")));
}

void completed(NextDispatcher next, action) {
  next(FavoriteStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "${action.actionName} is completed")));
}

void noMoreItem(NextDispatcher next, action) {
  next(FavoriteStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "no more items")));
}

void running(NextDispatcher next, action) {
  next(FavoriteStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.running,
          msg: "${action.actionName} is running")));
}

void idEmpty(NextDispatcher next, action) {
  next(FavoriteStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "Id is empty")));
}
