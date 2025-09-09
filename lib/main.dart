import 'package:bloc_demo/providers/authprovider.dart';
import 'package:bloc_demo/providers/userprovider.dart';
import 'package:bloc_demo/providers/themeprovider.dart';
import 'package:bloc_demo/screens/loginscreen.dart';
import 'package:bloc_demo/screens/userDetailscreen.dart';
import 'package:bloc_demo/screens/userlistscreen.dart';
import 'package:bloc_demo/models/usermodel.dart'; // Import your User model
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'User List App',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.isDarkMode
                ? ThemeData.dark()
                : ThemeData.light(),
            home: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return authProvider.isAuthenticated
                    ? const UserListScreen()
                    : const LoginScreen();
              },
            ),
            routes: {
              '/login': (context) => const LoginScreen(),
              '/users': (context) => const UserListScreen(),
            },
            // Use onGenerateRoute for complex navigation with arguments
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case '/user-detail':
                  final user = settings.arguments as User;
                  return MaterialPageRoute(
                    builder: (context) => UserDetailScreen(user: user),
                  );
                default:
                  return null;
              }
            },
          );
        },
      ),
    );
  }
}

// USAGE EXAMPLES:

// Option 1: Navigate with User object from UserListScreen
/*
// In your UserListScreen or any other screen:
onTap: () {
  Navigator.pushNamed(
    context,
    '/user-detail',
    arguments: user, // Pass the entire User object
  );
}
*/

// Option 2: Alternative - Direct navigation without named routes
/*
// In your UserListScreen:
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UserDetailScreen(user: user),
    ),
  );
}
*/