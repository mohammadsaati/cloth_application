import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/web_service.dart';
import '../provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPhone = true;

  String phoneNumber = "";
  String password = "";
  String activationCode = "";


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.network( loginImage , fit: BoxFit.cover,),
            ) ,


            const SizedBox( height: 30, ) ,


            _showPhone ? Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.width * 0.5,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Container(
                    width : double.infinity ,
                    height: 60,
                    padding: const EdgeInsets.symmetric(vertical: 15 , horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50) ,
                      color: Colors.blueGrey[100],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.phone ,
                          size: 24,
                        ) ,


                        Container(
                          width: 250,
                          height: 50,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onSubmitted: (String value) async {
                              setState(() {
                                phoneNumber = value;
                                _showPhone = false;
                              });

                              await Provider.of<AuthProvider>(context , listen: false).customerGetCode(phoneNumber);

                            },
                            decoration: const InputDecoration(
                              hintText: 'PhoneNumber',
                            ),
                          ),
                        )

                      ],
                    ) ,
                  )
                ],

              ),
            ) : Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.width * 1,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Container(
                    width : double.infinity ,
                    height: 60,
                    padding: const EdgeInsets.symmetric(vertical: 15 , horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50) ,
                      color: Colors.blueGrey[100],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.assignment_turned_in_sharp ,
                          size: 24,
                        ) ,


                        Container(
                          width: 250,
                          height: 50,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onSubmitted: (String value) {
                              print(phoneNumber);
                              setState(() {
                                phoneNumber = phoneNumber;
                                activationCode = value;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'activation code',
                            ),
                          ),
                        )

                      ],
                    ) ,
                  ) ,

                  const SizedBox(height: 20,),

                  Container(
                    width : double.infinity ,
                    height: 60,
                    padding: const EdgeInsets.symmetric(vertical: 15 , horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50) ,
                      color: Colors.blueGrey[100],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.password ,
                          size: 24,
                        ) ,


                        Container(
                          width: 250,
                          height: 50,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onSubmitted: (String value) {
                              setState(() {
                                phoneNumber = phoneNumber;
                                activationCode = activationCode;
                                password = value;
                              });
                              print(phoneNumber);
                            },
                            decoration: const InputDecoration(
                              hintText: 'password',
                            ),
                          ),
                        )

                      ],
                    ) ,
                  ) ,

                  const SizedBox(height: 10,) ,

                  InkWell(
                    onTap: () async {
                      await Provider.of<AuthProvider>(context , listen: false).customerLogin(phoneNumber: phoneNumber, activationCode: activationCode, password: password);
                      Navigator.of(context).pushNamed("/home");
                    },
                    child: Container(
                      width : double.infinity ,
                      height: 50,
                      padding: const EdgeInsets.symmetric(vertical: 15 , horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50) ,
                        color: Colors.amberAccent,
                      ),
                      child: const  Center(
                        child: Text(
                          "Login" ,
                          style: TextStyle(
                            fontSize: 16 ,
                            fontWeight: FontWeight.bold ,

                          ),
                        ),
                      ) ,
                    ),
                  )

                ],

              ),
            ) ,
          ],
        ),
      ),
    );
  }
}
