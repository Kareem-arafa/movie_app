import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/UI/movie_details.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/features/movieDetails/movieDetails_view.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/features/upComing/upComing_view_model.dart';


class UpComingView extends StatelessWidget {
  UpComingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UpComingViewModel>(
      distinct: true,
      converter: (store) => UpComingViewModel.fromStore(store),
      builder: (_, viewModel) => UpComingViewContent(
        viewModel: viewModel,
      ),
    );
  }
}

class UpComingViewContent extends StatefulWidget {
  final UpComingViewModel viewModel;
  UpComingViewContent({Key key, this.viewModel}) : super(key: key);

  @override
  _UpComingViewContentState createState() => _UpComingViewContentState();
}

class _UpComingViewContentState extends State<UpComingViewContent> {
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
    this.widget.viewModel.getUpComigs(true);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        this.widget.viewModel.getUpComigs(false);
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
      itemCount: this.widget.viewModel.upComings.length + 1,
      gridDelegate:
      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        if (index == this.widget.viewModel.upComings.length) {
          return _buildProgressIndicator();
        } else {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w200${this.widget.viewModel.upComings[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MovieDetailsView(id:this.widget.viewModel.upComings[index].id);
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