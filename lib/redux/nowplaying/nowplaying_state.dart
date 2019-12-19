import 'package:meta/meta.dart';
import 'package:movie_app/data/model/nowplaying_data.dart';
import 'package:movie_app/data/model/page_data.dart';
import 'package:movie_app/redux/action_report.dart';

class NowPlayingState {
  final Map<String, NowPlaying> nowplayings;
  final NowPlaying nowplaying;
  final Map<String, ActionReport> status;
  final Page page;

  NowPlayingState({
    @required this.nowplayings,
    @required this.nowplaying,
    @required this.status,
    @required this.page,
  });

  NowPlayingState copyWith({
    Map<String, NowPlaying> nowplayings,
    NowPlaying nowplaying,
    Map<String, ActionReport> status,
    Page page,
  }) {
    return NowPlayingState(
      nowplayings: nowplayings ?? this.nowplayings ?? Map(),
      nowplaying: nowplaying ?? this.nowplaying,
      status: status ?? this.status,
      page: page ?? this.page,
    );
  }
}
