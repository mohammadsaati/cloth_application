import 'package:flutter/material.dart';

import '../models/slider.dart';

class SliderProvider with ChangeNotifier
{
    List<ImageSlider> _sliders = [];

    List<ImageSlider> get sliders
    {
      return [..._sliders];
    }




}