import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kototinder/presentation/cubits/cat_card_cubit.dart';
import 'package:kototinder/presentation/cubits/liked_cats_cubit.dart';
import 'package:kototinder/presentation/screens/cat_card_screen.dart';
import 'package:kototinder/di/injector.dart';

import 'di/injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<CatCardCubit>()),
        BlocProvider(create: (_) => sl<LikedCatsCubit>()),
      ],
      child: const CatTinderApp(),
    ),
  );
}

class CatTinderApp extends StatelessWidget {
  const CatTinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KotoTinder',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CatCardScreen(),
    );
  }
}
