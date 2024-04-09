import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_login/twitter_login.dart';

import 'SecondScreen.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  var reult ="";
  var user;
  String name = "";
  String email = "";
  String id = "";

  @override
  void initState() {
    pattern();
    super.initState();
  }


  pattern() async {
    for(int i=0;i<5;i++)
      {

        for(int j=i;j>0;j--)
          {
            print("*");
          }
        //print("\n");
      }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Login With Twitter'),
              onPressed: () async {
                final twitterLogin = TwitterLogin(
                  // Consumer API keys
                  apiKey: 'S0dPGOWKzgKxiRRa0jxszuyzY',
                  // Consumer API Secret keys
                  apiSecretKey: 'g7kvPE5I9hmAXRwB8iTtEvbknNHJ8OCV8dGP1aagZHRnne8cOD',
                  // Registered Callback URLs in TwitterApp
                  // Android is a deeplink
                  // iOS is a URLScheme
                  redirectURI: 'flutter-twitter-login://',
                );
            await twitterLogin.login().then((value) async {

              print("Twitter Value $value");
              print("Twitter Value "+value.status.toString());


              print("Twitter Value "+value.user.toString());
              print("Twitter Value "+value.user!.name.toString());
              print("Twitter Value "+value.user!.email.toString());
              print("Twitter Value "+value.user!.id.toString());



              setState(() {
                //user=value.user;
                name=value.user!.name;
                email=value.user!.email;
                id=value.user!.id.toString();

              });



              final TwitterAuthCredential  = TwitterAuthProvider.credential(
                  accessToken: value.authToken!,
                  secret: value.authTokenSecret!);

              await FirebaseAuth.instance.signInWithCredential(TwitterAuthCredential);
              switch (value.status) {
                case TwitterLoginStatus.loggedIn:
                // success
                  break;
                case TwitterLoginStatus.cancelledByUser:
                // cancel
                  break;
                case TwitterLoginStatus.error:
                // error
                  break;
                case null:
                  // TODO: Handle this case.
                  break;
              }

            });

              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: Text('Login With Apple'),
              onPressed: () async {


              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async
             {
              await FirebaseAuth.instance.signOut().then((value){

              });

            }, child: Text("Log-out")),


             Text("Name : "+name),
             Text("Email : "+email),
             Text("uid : "+id),
            ElevatedButton(onPressed: () async
            {
              FirebaseCrashlytics.instance.crash();


            }, child: Text("Crash")),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async
            {
              FirebaseAnalytics.instance.logEvent(name: 'increment_button_press');

              Get.to(SecondScreeen());


            }, child: Text("Step 1")),
          ],
        ),



      ),

    );
  }
}