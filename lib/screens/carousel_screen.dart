import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  final imageUrls = [
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/07/05/10/18/tree-832079_640.jpg',
    'https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_640.jpg',
    'https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_640.jpg',
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/07/05/10/18/tree-832079_640.jpg',
    'https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_640.jpg',
    'https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_640.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Image Slider",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.blueGrey),
        ),
        centerTitle: true,

        backgroundColor: Colors.grey,
      ),
      body: CarouselSlider.builder(
        itemCount: imageUrls.length,

        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Container(
            margin: const EdgeInsets.all(8),
            decoration:BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageUrls[index]),
                fit: BoxFit.cover,
              ),


            borderRadius: BorderRadius.circular(25),
            ),
          );


      }, options: CarouselOptions(
        height: 170,
        aspectRatio: 16 / 8,
        viewportFraction: 0.8,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 700),
        enlargeCenterPage: true,
        enlargeFactor: 0.5,
        reverse: true,
        scrollDirection: Axis.horizontal,

      ),),
    );
  }
}
