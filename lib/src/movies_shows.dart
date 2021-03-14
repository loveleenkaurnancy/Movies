import 'package:flutter/material.dart';
import 'package:flutter_app/src/moviedetails.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';




class movies extends StatefulWidget{

  String url;
  movies(this.url);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return moviesState();
  }

}

class moviesState extends State<movies>{

  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(widget.url),
        headers: {
          "Accept": "application/json"
        }
    );

    setState(() {
      var s = json.decode(response.body);
      data = s["results"];
    });

    return "Sucess";

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();

  }




  @override
  Widget build(BuildContext context) {

    var image_url = 'https://image.tmdb.org/t/p/w500/';

    return GridView.builder(

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 16.0 / 30,
          crossAxisSpacing: 2.0
      ),
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            child: Column(
              children: <Widget>[
                Image.network(image_url+data[index]["poster_path"],height:233.0, fit: BoxFit.cover,),

              ],
            ),

            onTap: (){
              String p = data[index]["id"].toString();
              print(data[index]["id"]);
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context)
                  { return moviedetails(p);}));
              } ,
          ),

        );
      },
    );
  }

}