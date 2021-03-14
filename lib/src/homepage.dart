import 'package:flutter/material.dart';
import 'package:flutter_app/src/movies_shows.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

String api_key = "";

class homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new homepagestate();
  }
}

class homepagestate extends State<homepage>
    with SingleTickerProviderStateMixin {
  int index = 0;
  TabController controller;

  String popular =
      "https://api.themoviedb.org/3/movie/popular?api_key=$api_key&language=en-US&page=1";
  String toprated =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$api_key&language=en-US&page=1";
  String nowshowing =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=$api_key&language=en-US&page=1";
  String upcoing =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$api_key&language=en-US&page=1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 4.0,

        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: null),

        title: Text("Movie Time"),

        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: null),
        ],

        bottom: new TabBar(
          isScrollable: true,
//          labelColor: Colors.amber,
          indicatorColor: Colors.amber,
          controller: controller,
          tabs: <Widget>[
            new Tab(
              text: "POPULAR",
            ),
            new Tab(
              text: "TOP RATED",
            ),
            new Tab(
              text: "NOW PLAYING",
            ),
            new Tab(
              text: "UP COMING",
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.amber,
        currentIndex: this.index, // this will be set when a new tab is tapped
        onTap: onTabTapped,

        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.tv),
            title: new Text('Movies'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.live_tv), title: Text('Series'))
        ],
      ),
      drawer: buildDrawer(),
      body: new TabBarView(controller: controller, children: <Widget>[
        new movies(popular),
        new movies(toprated),
        new movies(nowshowing),
        new movies(upcoing),
      ]),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      elevation: 4.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Shakil Ahmed",style: TextStyle(fontSize: 15.0,color: Colors.black),),
            accountEmail: Text("shakilme0031@gmail.com",style: TextStyle(fontSize: 14.0,color: Colors.black),),
            currentAccountPicture: new CircleAvatar(
              backgroundImage: NetworkImage("https://images.unsplash.com/photo-1497316730643-415fac54a2af?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80"),
            ),
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home,color: Colors.amber),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.feedback,color: Colors.amber),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      this.index = index;
      print("$index");
    });
  }
}
