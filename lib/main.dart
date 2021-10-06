import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realme_clone/models/cart-model.dart';
import 'package:realme_clone/models/change-model.dart';
import 'package:realme_clone/models/user-address-model.dart';
import 'package:realme_clone/pages/Homepage/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProduct()),
        ChangeNotifierProvider(create: (_) => UserAddress()),
        ChangeNotifierProvider(create: (_) => ProductDetails()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: StartPg()),
    ),
  );
}

class StartPg extends StatelessWidget {
  const StartPg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.hasData) {
          return Homepage();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong!'),
          );
        } else {
          return Homepage();
        }
      },
    );
  }
}
