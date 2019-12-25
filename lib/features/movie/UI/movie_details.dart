import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final posterUrl;
  final description;
  final releaseDate;
  final dropDown;
  final String title;
  final String voteAverage;
  final int movieId;

  DetailScreen({
    this.title,
    this.posterUrl,
    this.dropDown,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
                          'https://image.tmdb.org/t/p/w500${widget.dropDown}'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.3)),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 75,
                  right: (MediaQuery.of(context).size.width / 2) - 25,
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
                              'https://image.tmdb.org/t/p/w500${widget.posterUrl}'),
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
                        width: MediaQuery.of(context).size.width - 165,
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.amber,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(widget.releaseDate,
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
                            widget.voteAverage,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      )
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
                    widget.description,
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 8.0),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    itemBuilder: (context, index) => Container(
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
                                          "https://i.pravatar.cc/300")),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              Container(
                                width: 80,
                                child: Text(
                                  'Karem arafa mahmoud',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
