import 'package:flutter/material.dart';

class OnBoarding {
  final String body;
  final String title;
  final String image;
  OnBoarding({
    required this.body,
    required this.title,
    required this.image,
  });
}

// the list to dispaye the screens
List<OnBoarding> screen = [
  OnBoarding(
    body: 'on Boarding 1 body',
    title: 'on Boarding 1 title',
    image: 'assest/image/Drawe_4.png',
  ),
  OnBoarding(
    body: 'on Boarding 2 body',
    title: 'on Boarding 2 title',
    image: 'assest/image/Drawe_5.png',
  ),
  OnBoarding(
    body: 'on Boarding 3 body',
    title: 'on Boarding 3 title',
    image: 'assest/image/Drawe_3.png',
  ),
  OnBoarding(
    body: 'on Boarding 4 body',
    title: 'on Boarding 4 title',
    image: 'assest/image/Drawe_6.png',
  ),
];

Widget buildBoardingItem(model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      const SizedBox(height: 30.0),
      Text(
        '${model.title}',
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 15.0),
      Text(
        '${model.body}',
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 30.0),
    ],
  );
}
