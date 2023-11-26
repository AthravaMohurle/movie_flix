import 'package:flutter/material.dart';

import '../movie.dart';
import '../toprated_api.dart';
import 'movie_detail_screen.dart';

class top_rated_movie extends StatefulWidget {
  const top_rated_movie({Key? key}) : super(key: key);

  @override
  State<top_rated_movie> createState() => top_rated_movieState();
}

class top_rated_movieState extends State<top_rated_movie> {

  late Future<List<Movie>> _topRatedMovies;
  TextEditingController _searchController = TextEditingController();
  List<Movie> _allMovies = [];
  List<Movie> _displayedMovies = [];

  void initState() {

    super.initState();

    _topRatedMovies=topapi().getTopPlayingMovies();
    _loadMovies();
  }


  void _loadMovies() async {
    List<Movie> movies = await _topRatedMovies;
    setState(() {
      _allMovies = movies;
      _displayedMovies = _allMovies;
    });
  }

  void _searchMovies(String query) {
    setState(() {
      _displayedMovies = _allMovies
          .where((movie) =>
          movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  void _navigateToMovieDetails(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(movie: movie),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black26
      ,


      body:
      Column(

        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(

                hintText: 'Search Top Rated Movies',
                hintStyle: TextStyle(color: Colors.white),

                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),

              ),
              style: TextStyle(color: Colors.white),
              onChanged: _searchMovies,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Movie>>(
              future:  _topRatedMovies,
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting)
                {
                  return Center(
                    child:  CircularProgressIndicator(),
                  );
                }
                else if (snapshot.hasError)
                {
                  return Center(
                    child: Text('Error loading movies:${snapshot.error}',style: TextStyle(color: Colors.white),),
                  );
                }
                else if (!snapshot.hasData || snapshot.data!.isEmpty)
                {
                  return Center(
                    child: Text('No movies available',style: TextStyle(color: Colors.white),),
                  );
                }
                else{
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _displayedMovies.length,
                    itemBuilder: (context, index) {
                      final movie=_displayedMovies[index];
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          setState(() {
                            final originalIndex = _allMovies.indexOf(movie);
                            //_allMovies.removeAt(index);
                            _displayedMovies.removeAt(index);
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          height: 130,
                          child: Card(
                            elevation: 20,
                            color: Colors.orange[400],
                            child: Center(
                              child: ListTile(

                                title: Text(movie.title,style: TextStyle(fontWeight: FontWeight.bold),),
                                subtitle: SizedBox(

                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    child: Text(movie.overview,style: TextStyle(fontSize: 11),),
                                  ),
                                ),

                                contentPadding: EdgeInsets.symmetric(horizontal: 16),

                                leading: SizedBox(
                                    width:50,


                                    child: Center(
                                      child: Container(
                                        child: Image.network(filterQuality: FilterQuality.high,fit: BoxFit.fill,
                                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',height: 1500,width: 150,
                                        ),
                                      ),
                                    )
                                ),
                                onTap: ()
                                {
                                  _navigateToMovieDetails(movie);
                                },






                              ),
                            ),


                          ),
                        ),
                      );
                    },
                  );
                }
              },

            ),
          ),
        ],
      ),





    );
  }
}
