

import 'package:fetch_movie_app/model/movie.dart';
import 'package:flutter/material.dart';


class MovieDetail extends StatefulWidget {
  final Movie moviedetail;
  const MovieDetail({Key? key,required this.moviedetail}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Colors.black,
    body: Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 400,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${widget.moviedetail.posterPath.toString()}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text('Title: ',style: TextStyle(color: Colors.grey,fontSize: 20),),
                      ),
                      Container(
                        child: Text(
                          widget.moviedetail.title.toString(),style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text('Release Date: ',style: TextStyle(color: Colors.grey,fontSize: 20),),
                      ),
                      Container(
                        child: Text(
                          widget.moviedetail.releaseDate.toString().split(' ')[0],style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text('Rating: ',style: TextStyle(color: Colors.grey,fontSize: 20),),
                      ),
                      Container(
                        child: Text(
                          widget.moviedetail.voteAverage.toString(),style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text('Overview:',style: TextStyle(color: Colors.grey,fontSize: 20),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  child: Text(widget.moviedetail.overview.toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
              ),


            ],
          ),
        ),
        new Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            title: Text(''),// You can add title here
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.blue.withOpacity(0), //You can make this transparent
            elevation: 0.0, //No shadow
          ),),
      ],
    )
  );

}

