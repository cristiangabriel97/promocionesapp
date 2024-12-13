import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:promociones_de_venta/blocs/promocion_bloc.dart';
import 'package:promociones_de_venta/blocs/promocion_event.dart';
import 'package:promociones_de_venta/firebase_options.dart';
import 'package:promociones_de_venta/repositorio/promocion_repositorio.dart';
import 'package:promociones_de_venta/screens/consultadatos_screen.dart';
import 'package:promociones_de_venta/screens/ingresodatos_screen.dart';
import 'package:promociones_de_venta/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PromotionBloc>(
          create: (context) => PromotionBloc(
            promotionRepository: PromotionRepository(),
          )..add(FetchPromotions()), // Inicializa cargando las promociones
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestión de Promociones',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/consulta': (context) => PromotionListScreen(),
        '/ingreso': (context) => PromotionInputScreen(),
      },
    );
  }
}
