import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashon_app/Feature/Home/data/slider_model/datum.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:flutter/material.dart';

Widget carSlider({required List<DatumSlider>? data}) => Container(
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: CarouselSlider(
        items: data!
            .map((e) => Image(
                  image: NetworkImage('$IMGURL${e.img}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ))
            .toList(),
        options: CarouselOptions(
            height: 130,
            aspectRatio: 2.5,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            viewportFraction: 1.0,
            autoPlayInterval: const Duration(milliseconds: 1600)),
      ),
    );
