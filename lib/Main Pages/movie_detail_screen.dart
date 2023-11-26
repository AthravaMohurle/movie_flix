
import 'package:flutter/material.dart';

import '../nowplaying_api.dart';
import '../movie.dart';
class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {



  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(widget.movie.title),
      ),
      body: Stack(
        children: [
          Image.network('https://image.tmdb.org/t/p/original${widget.movie.backDropPath}',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
            filterQuality: FilterQuality.high,
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Card(
              margin: EdgeInsets.all(40),
              color: Colors.white.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.movie.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    SizedBox(height: 10),
                    Text('Release Date: ${widget.movie.releaseDate}'),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.orange,),
                         Text(widget.movie.voteAverage.toStringAsFixed(1))
                      ],
                    ),
                    Text('Overview: ${widget.movie.overview}'),
                    SizedBox(height: 16),


                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
