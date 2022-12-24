
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateList(String movieName){
    print(movieName);
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
