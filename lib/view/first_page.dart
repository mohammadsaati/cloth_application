import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home.dart';
import './login_screen.dart';
import '../provider/auth_provider.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    if(_isInit)
    {

    }
    setState(() {
      _isInit = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
