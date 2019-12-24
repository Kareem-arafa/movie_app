import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/redux/app/app_state.dart';

import 'movieDetails_view_model.dart';

class MovieDetailsView extends StatelessWidget {
  final int id;
  MovieDetailsView({Key key,this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MovieDetailsViewModel>(
      distinct: true,
      converter: (store) => MovieDetailsViewModel.fromStore(store),
      builder: (_, viewModel) => DetailScreen( viewModel,id),
    );
  }
}

class DetailScreen extends StatefulWidget {
 final MovieDetailsViewModel viewModel;
 final int id;

 DetailScreen(this.viewModel,this.id);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.widget.viewModel.getTrailer(widget.id);
    this.widget.viewModel.getMovieDetails(widget.id);
    this.widget.viewModel.getCast(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 390,
                      width: double.infinity,
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(
                              'https://image.tmdb.org/t/p/w500${this.widget
                                  .viewModel.detailsModel.backdropPath}'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.3)
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 75,
                      right: (MediaQuery
                          .of(context)
                          .size
                          .width / 2) - 25,
                      child: GestureDetector(
                        onTap: (){
                         // print(this.widget.viewModel.trailers.length);
                          _openYoutube( this.widget.viewModel.trailers.results[0].key);
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 170.0,
                      left: 15.0,
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(7.0),
                        child: Container(
                          height: 200.0,
                          width: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            image: new DecorationImage(
                              image: new NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${this.widget
                                      .viewModel.detailsModel.posterPath}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 215,
                      left: 165,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 165,
                            child: Text(
                              this.widget.viewModel.detailsModel.title,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(this.widget.viewModel.detailsModel.releaseDate,
                              style: TextStyle(
                                fontSize: 18.0,
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 1.0, right: 2.0),
                              ),
                              Text(
                                this.widget.viewModel.detailsModel.voteAverage
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(this.widget.viewModel.detailsModel
                              .genres.map((gen) => gen.name).join(' - '), style: TextStyle(
                            fontSize: 15.0,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                      child: Text(
                        'Description :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        this.widget.viewModel.detailsModel.overview,
                        style:
                        TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 8.0),
                  child: Container(
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        'Casts : ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: new ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) =>
                            Container(
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.0),
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(
                                              "https://image.tmdb.org/t/p/w600_and_h900_bestv2/${this.widget.viewModel.castModel.casts[index].profilePath}")),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                  ),
                                  Container(
                                    width: 80,
                                    child: Text(
                                      this.widget.viewModel.castModel.casts[index].name,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                  ),
                )
              ],
            ))
    );
  }
  _openYoutube(String videoId) async {
    try {
      await launch(
        'https://www.youtube.com/watch?v=$videoId',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          // or user defined animation.
//          animation: new CustomTabsAnimation(
//          startEnter: 'slide_up',
//          startExit: 'android:anim/fade_out',
//          endEnter: 'android:anim/fade_in',
//          endExit: 'slide_down',
//        ),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

}
