import 'package:atmavishwasect/providers/affiliation_provider.dart';
import 'package:atmavishwasect/providers/category_provider.dart';
import 'package:atmavishwasect/providers/qr_scan_provider.dart';
import 'package:atmavishwasect/screens/home/home_screen.dart';
import 'package:atmavishwasect/utilites/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QrScanProvider()),
        ChangeNotifierProvider(create: (_) => AffiliationProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: whiteColor,
            iconTheme: const IconThemeData(color: blackColor),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          canvasColor: scaffoldBackgroundColor,
          primaryColor: kPrimaryColor,
          primarySwatch: primarySwatch,
          fontFamily: 'medium',
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashFactory: InkRipple.splashFactory,
          focusColor: Colors.transparent,
          dividerColor: Colors.transparent,
          // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: kPrimaryColor,
          ),
        ),

        home: const HomeScreen(),
      ),
    );
  }
}
