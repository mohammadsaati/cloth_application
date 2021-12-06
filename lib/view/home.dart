import 'package:cloth_app/widgets/app_bar_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app.dart';
import '../view/section/home_section.dart';
import '../provider/home_provider.dart';
import '../widgets/home_sliders.dart';
import '../widgets/add_to_cart_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _isInit = true;
  bool _showSpinner = false;

 @override
  void didChangeDependencies() async
  {
   if(_isInit)
   {
     setState(() {
       _showSpinner = true;
     });
     await Provider.of<HomeProvider>(context).getHomeData();
     setState(() {
       _showSpinner = false;
     });
   }

   setState(() {
     _isInit = false;
   });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final home = Provider.of<HomeProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text(appName , style: TextStyle(fontSize: 20 , color: Colors.white),),
        actions: const [
          AppBarCartIcon()
        ],
      ),
      body: _showSpinner ? const  Center( child: CircularProgressIndicator(), ) : SingleChildScrollView(
        child: Container(

          padding: const EdgeInsets.all( 10 ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [

              SizedBox(
                width: double.infinity,
                height: 200,
                child: HomeSliders(imageSlider: home.sliders),
              ) ,
              /*Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    homeImage ,
                    errorBuilder: (context , url , error) => const Center( child: Icon(Icons.image), ),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ) ,*/

              const SizedBox(height: 10,) ,

              Column(
                children: home.sections.map((section) {
                  return HomeSection(section: section);
                }).toList(),
              )


            ],
          ),

        ),
      ) ,
    );
  }
}
