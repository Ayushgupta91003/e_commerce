import 'package:e_commerce/common/widgets/bottom_bar.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/features/admin/screens/admin_screen.dart';
import 'package:e_commerce/features/auth/screens/auth_screen.dart';
import 'package:e_commerce/features/auth/services/auth_service.dart';
import 'package:e_commerce/features/home/screens/home_screen.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:e_commerce/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClickNBuy',
      theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          colorScheme: ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          )
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}




/*

Scaffold(
        appBar: AppBar(
          title: const Text("hello"),
        ),
        body: Column(
          children: [
            const Center(
              child: const Text("Flutter Demo Home Page"),
            ),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AuthScreen.routeName);
                },
                child: Text("Click"),
              );
            }),
          ],
        ),
      ),

*/