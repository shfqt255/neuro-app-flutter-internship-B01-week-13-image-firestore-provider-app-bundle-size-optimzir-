import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:optimized_firestore_app/Provider/product_provider.dart';
import 'package:optimized_firestore_app/Services/api_service.dart';
import 'package:provider/provider.dart';
import 'services/firestore_service.dart';
import 'screens/product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(
            apiService: ApiService(),
            firestoreService: FirestoreService(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductScreen(),
      ),
    );
  }
}
