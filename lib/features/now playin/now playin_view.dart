import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/model/nowplaying_data.dart';
import 'package:movie_app/features/movie/UI/movie_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/trans/translations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/features/now playin/now playin_view_model.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/utils/progress_dialog.dart';
import 'package:movie_app/features/widget/spannable_grid.dart';

class nowplayinView extends StatelessWidget {
  nowplayinView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, nowplayinViewModel>(
      distinct: true,
      converter: (store) => nowplayinViewModel.fromStore(store),
      builder: (_, viewModel) => nowplayinViewContent(
            viewModel: viewModel,
          ),
    );
  }
}

class nowplayinViewContent extends StatefulWidget {
  final nowplayinViewModel viewModel;
  nowplayinViewContent({Key key, this.viewModel}) : super(key: key);

  @override
  _nowplayinViewContentState createState() => _nowplayinViewContentState();
}

class _nowplayinViewContentState extends State<nowplayinViewContent> {
  ScrollController _scrollController = new ScrollController();

  bool isLoading = false;


  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    this.widget.viewModel.getNowPlayings(true);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        this.widget.viewModel.getNowPlayings(false);
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      itemCount: this.widget.viewModel.nowplayings.length + 1,
      gridDelegate:
      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        if (index == this.widget.viewModel.nowplayings.length) {
          return _buildProgressIndicator();
        } else {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w200${this.widget.viewModel.nowplayings[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailScreen(
                    title: this.widget.viewModel.nowplayings[index].title,
                    posterUrl:
                    this.widget.viewModel.nowplayings[index].posterPath,
                    description:
                    this.widget.viewModel.nowplayings[index].overview,
                    releaseDate:
                    this.widget.viewModel.nowplayings[index].releaseDate,
                    voteAverage: this
                        .widget
                        .viewModel
                        .nowplayings[index]
                        .voteAverage
                        .toString(),
                    movieId: this.widget.viewModel.nowplayings[index].id,
                  );
                }));
              },
            ),
          );
        }
      },
      controller: _scrollController,
    );
  }
}