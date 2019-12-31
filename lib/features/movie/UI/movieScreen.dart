import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/features/movie/movie_view_model.dart';
import 'package:movie_app/features/movieDetails/movieDetails_view.dart';
import 'package:movie_app/redux/app/app_state.dart';

class MovieScreen extends StatefulWidget {
  final String type;

  MovieScreen({Key key, this.type}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MovieViewModel>(
        distinct: true,
        converter: (store) => MovieViewModel.fromStore(store, widget.type),
        builder: (context, viewModel) {
       /*   if(viewModel.movieModelState.loading){
      return Center(child: CircularProgressIndicator(),);
    }*/
            return PopularMovie(
                viewModel: viewModel,
            );

        });
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

  @override
  void initState() {
    // TODO: implement initState
    this.widget.viewModel.getMovieModels(true);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        this.widget.viewModel.getMovieModels(false);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
Widget getPageContent(){
    if(widget.viewModel.movieModelState.loading){
      return Center(child: CircularProgressIndicator(),);
    }
    return GridView.builder(
      itemCount: this.widget.viewModel.moviemodels.length + 1,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        if(this.widget.viewModel.moviemodels.length==0 && index == 0 ){
          return Center(child: CircularProgressIndicator(),);
        }
        return GridTile(
          child: InkResponse(
            enableFeedback: true,
            child: Image.network(
              'https://image.tmdb.org/t/p/w200${this.widget.viewModel.moviemodels[index].posterPath}',
              fit: BoxFit.fill,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return MovieDetailsView(
                        id: this.widget.viewModel.moviemodels[index].id);
                  }));
            },
          ),
        );
      },
      controller: _scrollController,
    );
}
  @override
  Widget build(BuildContext context) {
    return getPageContent();
  }
}
