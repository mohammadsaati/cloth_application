import 'package:flutter/material.dart';

import '../models/section.dart';

class SectionProvider with ChangeNotifier
{
    List<Section> _sections = [];

    List<Section> get sections
    {
        return [..._sections];
    }


}