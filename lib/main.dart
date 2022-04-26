import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gitme/src/infrastructure/theme/pallet.dart';
import 'package:gitme/src/presentation/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gitme',
          theme: ThemeData(
            primarySwatch: Pallet.primary,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
