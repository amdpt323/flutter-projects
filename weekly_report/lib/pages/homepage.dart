import 'package:flutter/material.dart';
import 'package:weekly_report/utils/colors.dart';
import '../model/quoteModel.dart';
import '../services/apiServices.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<QuoteModel> quote = ApiServices().getQuote();
  @override
  Widget build(BuildContext context) =>Scaffold(
    backgroundColor: Color.fromRGBO(29,28,33,1),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/calender.png'
                    ),
                    fit:BoxFit.cover,
                  )
                ),
              ),
              Text(
                  "WEEKLY-REPORT",
              style:TextStyle(fontSize: 38) ,
              )
            ],
          ),
        ),

        SizedBox(
          height:30,
        ),
        FutureBuilder<QuoteModel>(
          future: quote,
          builder: (context,snapshot){
            if(snapshot.hasData){
              final quoteData = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child:SingleChildScrollView(
                          child: Text(
                              '" ${quoteData.content.toString()} "',
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.amber,
                              ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child:Text(
                            '- ${quoteData.author.toString()}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        alignment: Alignment.bottomRight,
                      ),
                    ),
                  ],
                ),
              );
            }else{
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child:SingleChildScrollView(
                          child: Text(
                            '" In the Ninja world, Those who dont follow the rules are'
                                'Trash. But those who abandon their friends are worse '
                                'than Trash "',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child:Text(
                          '- Uchiha Obito',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        alignment: Alignment.bottomRight,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        )
      ],
    ),
  );
}
