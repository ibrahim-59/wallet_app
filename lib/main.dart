import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet_app/cubit/fetch_data_cubit.dart';
import 'package:wallet_app/models/finance.dart';
import 'package:wallet_app/views/screens/splas_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Hive.registerAdapter(FinanceAdapter());
  await Hive.openBox<Finance>("financeBox");
  await Hive.openBox("darkModeBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchDataCubit(),
      child: ValueListenableBuilder(
        valueListenable: Hive.box("darkModeBox").listenable(),
        builder: (context, box, child) {
          var darkMode = box.get("darkMode", defaultValue: false);
          return MaterialApp(
            darkTheme: ThemeData.dark(useMaterial3: true),
            theme: ThemeData(useMaterial3: true),
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            title: 'Wallet',
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
