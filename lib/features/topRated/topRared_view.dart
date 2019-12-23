import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/UI/movie_details.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/features/movieDetails/movieDetails_view.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/features/topRated/topRated_view_model.dart';


class TopRatedView extends StatelessWidget {
  TopRatedView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TopRatedViewModel>(
      distinct: true,
      converter: (store) => TopRatedViewModel.fromStore(store),
      builder: (_, viewModel) => TopRatedViewContent(
        viewModel: viewModel,
      ),
    );
  }
}

class TopRatedViewContent extends StatefulWidget {
  final TopRatedViewModel viewModel;
  TopRatedViewContent({Key key, this.viewModel}) : super(key: key);

  @override
  _TopRatedViewContentState createState() => _TopRatedViewContentState();
}

class _TopRatedViewContentState extends State<TopRatedViewContent> {
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
    this.widget.viewModel.getTopRateds(true);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        this.widget.viewModel.getTopRateds(false);
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
      itemCount: this.widget.viewModel.topRateds.length + 1,
      gridDelegate:
      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        if (index == this.widget.viewModel.topRateds.length) {
          return _buildProgressIndicator();
        } else {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w200${this.widget.viewModel.topRateds[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MovieDetailsView(id:this.widget.viewModel.topRateds[index].id);
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