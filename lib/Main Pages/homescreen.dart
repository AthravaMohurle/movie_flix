// HomeScreen.dart

import 'package:flutter/material.dart';

import 'now_playing_movies.dart';
import 'top_rated_movies.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Movie Flix', style: TextStyle(color: Colors.red)),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedLabelStyle: TextStyle(color: Colors.redAccent), // Set the color for the selected tab label
        unselectedLabelStyle: TextStyle(color: Colors.black),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie,color: Colors.redAccent,),
            label: 'Now Playing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star,color: Colors.redAccent,),
            label: 'Top Rated',
          ),
        ],
      ),



    );
  }


  Widget _buildBody() {
    if (_currentIndex == 0) {
      return now_playing_movie();
    } else {
      return top_rated_movie();
    }
  }
}


