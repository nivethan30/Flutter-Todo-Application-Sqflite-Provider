import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'screens/main_screen/todo_main.dart';
import 'utils/constants.dart';
import 'providers/todo_provider.dart';

/// The main entry point of the app.
///
/// Initializes the [WidgetsFlutterBinding] and runs the app with a
/// [MultiProvider] that provides the [ThemeProvider] and the [TodoProvider].
///
/// The [ThemeProvider] is used for changing the theme of the app.
/// The [TodoProvider] is used for managing the Todo items.
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  /// Loads the theme from the preferences when the widget is first created.
  ///
  /// This is called when the widget is inserted into the tree.
  ///
  /// The theme is loaded by calling the [ThemeProvider.loadTheme] method.
  ///
  /// This needs to be called in [initState] because [ThemeProvider.loadTheme] is
  /// an asynchronous method.
  void initState() {
    super.initState();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.loadTheme();
  }

  @override
  /// Builds the app with the given [context].
  ///
  /// The [ThemeProvider] is obtained from the [context] using [context.watch].
  ///
  /// The [MaterialApp] is created with the following properties:
  ///
  /// * [debugShowCheckedModeBanner] is set to `false`.
  /// * [title] is set to [Constants.appTitle].
  /// * [theme] is set to the current theme of the [ThemeProvider].
  /// * [home] is set to an instance of [TodoMain].
  ///
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appTitle,
      theme: themeProvider.themeData,
      home: const TodoMain(),
    );
  }
}
