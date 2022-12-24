
import 'package:fetch_movie_app/model/movieModel.dart';
import 'package:fetch_movie_app/widgets/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateList(String movieName){
    print(movieName);
  }

  Future<List<Movies>> movies = getMovies();

  static Future<List<Movies>> getMovies() async {
    const url = 'https://api.themoviedb.org/3/movie/popular?api_key=6cc529d2eeeff21654a884fba5c5eb58&language=en-US';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode==200){
      final body = welcomeFromJson(response.body);
      return body.Map<Movies>(Movies.fromJson).toList();
    }
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
                  prefixIcon: Icon(Icons.search),
                ),
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
                child:ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  separatorBuilder: (context,_)=>const SizedBox(width: 12),
                  itemBuilder: (context,index)=>buildCard('https://i.pinimg.com/736x/59/85/80/59858064a5695c9e0bbd2f91855a1127.jpg'),
                )
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
                  child:ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    separatorBuilder: (context,_)=>const SizedBox(width: 12),
                    itemBuilder: (context,index)=>buildCard('https://w0.peakpx.com/wallpaper/586/179/HD-wallpaper-naruto-kid-thumbnail.jpg'),
                  )
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
                  child:ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    separatorBuilder: (context,_)=>const SizedBox(width: 12),
                    itemBuilder: (context,index)=>buildCard('https://w7.pngwing.com/pngs/28/1007/png-transparent-naruto-uzumaki-sasuke-uchiha-chibi-kurama-naruto-child-face-orange.png'),
                  )
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                    ),
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                        fontSize: 18,color:Colors.white
                    ),
                  ),
                  onPressed: ()=>FirebaseAuth.instance.signOut(),
                ),
            )
          ],
        ),
      ),
    ),
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
