import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/features/movie/movie_view_model.dart';
import 'package:movie_app/features/movieDetails/movieDetails_view.dart';
import 'package:movie_app/redux/app/app_state.dart';


class Popular extends StatelessWidget {
  final String type;
  Popular({Key key,this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MovieViewModel>(
      distinct: true,
      converter: (store) => MovieViewModel.fromStore(store,type),
      builder: (context, viewModel) =>
          PopularMovie(
            viewModel: viewModel,

          ),
    );
  }
}

class PopularMovie extends StatefulWidget {
  final MovieViewModel viewModel;

  PopularMovie({Key key, this.viewModel}) : super(key: key);

  @override
  _PopularMovieState createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
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
    this.widget.viewModel.getMovieModels(true);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        this.widget.viewModel.getMovieModels(false);
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  @override
  void dispose() {    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: this.widget.viewModel.moviemodels.length + 1,
      gridDelegate:
      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        if (index == this.widget.viewModel.moviemodels.length) {
          return _buildProgressIndicator();
        } else {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w200${this.widget.viewModel
                    .moviemodels[index].posterPath}',
                fit: BoxFit.fill,
              ),
              onTap: () {
                String dropDown;
                this
                    .widget
                    .viewModel
                    .moviemodels[index]
                    .backdropPath == null
                    ?
                dropDown = this
                    .widget
                    .viewModel
                    .moviemodels[index]
                    .posterPath
                    : dropDown = this.widget.viewModel.moviemodels[index].backdropPath;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MovieDetailsView(id:this.widget.viewModel.moviemodels[index].id);
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
