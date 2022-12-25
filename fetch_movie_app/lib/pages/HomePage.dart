
import 'package:fetch_movie_app/model/movie.dart';
import 'package:fetch_movie_app/service/api_services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'MovieDetail.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateList(String movieName){
    print(movieName);

  }

  Future <List<Movie>> popularMovies = ApiService().getMovie('popular');
  Future <List<Movie>> topRatedMovies = ApiService().getMovie('top_rated');
  Future <List<Movie>> nowPlayingMovies = ApiService().getMovie('now_playing');

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).backgroundColor,
    extendBodyBehindAppBar: false,
    body: Padding(
      padding: EdgeInsets.only(left: 8,right: 8,bottom: 8,top:50),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      onChanged: (value) => updateList(value),
                      style: TextStyle(color:Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(205,217,229,1),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.primary,
                            )
                        ),
                        hintText: 'e.g. Stranger Things',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(Icons.search,color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ElevatedButton(
                        onPressed: ()=>FirebaseAuth.instance.signOut(),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 22,vertical: 20),
                          backgroundColor: Colors.red,
                        ),
                        child: Text("SignOut",style: TextStyle(color: Colors.white,fontSize: 15),),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 20,
                child: Text(
                  'Trending Movies',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(205,217,229,1),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: FutureBuilder<List<Movie>>(
                  future: popularMovies,
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      final movie = snapshot.data!;
                      return buildMovie(movie);
                    }else{
                      return const Text('No movie data');
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 20,
                child: Text(
                  'Top Rated Movies',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(205,217,229,1),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 200,
                child: FutureBuilder<List<Movie>>(
                  future: topRatedMovies,
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      final movie = snapshot.data!;
                      return buildMovie(movie);
                    }else{
                      return const Text('No movie data');
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 20,
                child: Text(
                  'Now Playing',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(205,217,229,1),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 200,
                child: FutureBuilder<List<Movie>>(
                  future: nowPlayingMovies,
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      final movie = snapshot.data!;
                      return buildMovie(movie);
                    }else{
                      return const Text('No movie data');
                    }
                  },
                ),
              ),
            ),
            // Padding(
            //     padding: EdgeInsets.all(8),
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         minimumSize: Size.fromHeight(50),
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(18),
            //         ),
            //         backgroundColor: Colors.red,
            //       ),
            //       child: Text(
            //         'Sign Out',
            //         style: TextStyle(
            //             fontSize: 18,color:Colors.white
            //         ),
            //       ),
            //       onPressed: ()=>FirebaseAuth.instance.signOut(),
            //     ),
            // )
          ],
        ),
      ),
    ),
  );

  Widget buildMovie(List<Movie> movies) => ListView.separated(
    scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      separatorBuilder: (context,_)=>const SizedBox(width: 12),
      itemBuilder: (context,index) {
        final movie = movies[index];
        final path = movie.posterPath;
        return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder:(context) => MovieDetail(moviedetail : movie),
                  )
              );
            },
            child: buildCard('https://image.tmdb.org/t/p/w500$path')
        );
      },
  );


  Widget buildCard(url) => Container(
    width: 200,
    child: Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 4/3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    ),
  );

}
