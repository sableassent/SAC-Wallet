import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {

  List<String> images;

  ImageSlider(this.images);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Carousel(
        images: getImageList(images),
      ),
    );
  }

  List<Widget> getImageList(List<String> images) {
    List<Widget> imgWidgets = new List();
    for(String image in images){
      imgWidgets.add(
        Image.asset(image, fit: BoxFit.fill)
      );
    }

    return imgWidgets;
  }
}
