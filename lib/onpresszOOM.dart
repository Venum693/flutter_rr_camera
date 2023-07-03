import 'dart:ui';

import 'package:flutter/material.dart';



class Stacked extends StatefulWidget {
  @override
  _StackedState createState() => _StackedState();
}

class _StackedState extends State<Stacked> {
  final List<String> images = [
    'https://images.unsplash.com/photo-1448227922836-6d05b3f8b663?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60&foo=1',
    'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.unsplash.com/photo-1448227922836-6d05b3f8b663?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60&foo=1',
    'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'



  ];

  bool _showPreview = false;
  NetworkImage _image = NetworkImage('');


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
          children: [
            GridView.builder(
              itemCount: images.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      _showPreview = true;
                      _image = NetworkImage(images[index],);
                    });
                  },
                  onLongPressEnd: (details) {
                    setState(() {
                      _showPreview = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image(image: NetworkImage(images[index],),
                    ),
                  ),
                )
                );
              },
            ),
            if (_showPreview) ...[
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: Container(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              Container(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(image: _image,
                      height: 300,
                      width: 300,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ));
  }
}