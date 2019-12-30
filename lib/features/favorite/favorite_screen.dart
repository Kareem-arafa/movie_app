import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/data/model/movieDetails_data.dart';

class FavoriteMovies extends StatefulWidget {
  @override
  _FavoriteMoviesState createState() => _FavoriteMoviesState();
}

class _FavoriteMoviesState extends State<FavoriteMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
          child: WatchBoxBuilder(
              box: Hive.box('favoriteMovie'),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.length,
                  itemBuilder: (context, index) {
                    final details = snapshot.getAt(index) as DetailsModel;
                    return Container(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 210,
                            width: double.infinity,
                          ),
                          Positioned(
                            top: 30,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Material(
                                elevation: 10,
                                child: Container(
                                  height: 170,
                                  width: MediaQuery.of(context).size.width - 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.black45),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10.0,
                            left: 30.0,
                            child: Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(7.0),
                              child: Container(
                                height: 170.0,
                                width: 130.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  image: new DecorationImage(
                                    image: new NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${details.PosterPath}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 170,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 170,
                                  child: Text(
                                    details.Title,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          details.ReleaseDate,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
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
                                              margin: EdgeInsets.only(
                                                  left: 1.0, right: 2.0),
                                            ),
                                            Text(
                                              details.VoteAverage.toString(),
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 165,
                                  child: Text('Action',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 95,
                            left: MediaQuery.of(context).size.width - 90,
                            child: MaterialButton(
                              elevation: 5.0,
                              shape: CircleBorder(),
                              child: Icon(Icons.delete),
                              color: Colors.amber,
                              onPressed: () {
                                snapshot.deleteAt(index);
                              },
                            ),
                          )
                        ],
                      ),
                    ));
                  },
                );
              })),
    );
  }
}
