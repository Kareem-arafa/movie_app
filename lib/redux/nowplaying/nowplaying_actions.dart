import 'package:meta/meta.dart';
import 'package:movie_app/data/model/nowplaying_data.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/data/model/page_data.dart';

class GetNowPlayingsAction {
  final String actionName = "GetNowPlayingsAction";
  final bool isRefresh;

  GetNowPlayingsAction({this.isRefresh});
}

class GetNowPlayingAction {
  final String actionName = "GetNowPlayingAction";
  final int id;

  GetNowPlayingAction({@required this.id});
}

class NowPlayingStatusAction {
  final String actionName = "NowPlayingStatusAction";
  final ActionReport report;

  NowPlayingStatusAction({@required this.report});
}

class SyncNowPlayingsAction {
  final String actionName = "SyncNowPlayingsAction";
  final Page page;
  final List<NowPlaying> nowplayings;

  SyncNowPlayingsAction({this.page, this.nowplayings});
}

class SyncNowPlayingAction {
  final String actionName = "SyncNowPlayingAction";
  final NowPlaying nowplaying;

  SyncNowPlayingAction({@required this.nowplaying});
}

class CreateNowPlayingAction {
  final String actionName = "CreateNowPlayingAction";
  final NowPlaying nowplaying;

  CreateNowPlayingAction({@required this.nowplaying});
}

class UpdateNowPlayingAction {
  final String actionName = "UpdateNowPlayingAction";
  final NowPlaying nowplaying;

  UpdateNowPlayingAction({@required this.nowplaying});
}

class DeleteNowPlayingAction {
  final String actionName = "DeleteNowPlayingAction";
  final NowPlaying nowplaying;

  DeleteNowPlayingAction({@required this.nowplaying});
}

class RemoveNowPlayingAction {
  final String actionName = "RemoveNowPlayingAction";
  final int id;

  RemoveNowPlayingAction({@required this.id});
}

