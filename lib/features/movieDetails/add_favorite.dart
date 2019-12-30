import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/data/model/movieDetails_data.dart';
import 'package:movie_app/features/favorite/favorite_view_model.dart';
import 'package:movie_app/redux/app/app_state.dart';
int loveState = 1;
class AddFavorite extends StatelessWidget {
  final DetailsModel detailsModel;

  AddFavorite({this.detailsModel});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FavoriteViewModel>(
      distinct: true,
      converter: (store) => FavoriteViewModel.fromStore(store),
      builder: (_, viewModel) => AddFavoriteContent(
        viewModel: viewModel,
        detailsModel: detailsModel,
      ),
    );
  }
}

class AddFavoriteContent extends StatefulWidget {
  final DetailsModel detailsModel;
  final FavoriteViewModel viewModel;

  AddFavoriteContent({this.viewModel, this.detailsModel});



  @override
  _AddFavoriteContentState createState() => _AddFavoriteContentState();
}

class _AddFavoriteContentState extends State<AddFavoriteContent> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: loveState == 0
              ? Icon(
                  Icons.favorite,
                  size: 30.0,
                  color: Colors.red,
                )
              : Icon(
                  Icons.favorite_border,
                  size: 30.0,
                ),
          onPressed: () {
            if (loveState == 0) {
              setState(() {
                loveState = 1;
              });
            } else {
              this.widget.viewModel.addFavorite(this.widget.detailsModel);
              setState(() {
                loveState = 0;
              });
            }
          }),
    );
  }
}
