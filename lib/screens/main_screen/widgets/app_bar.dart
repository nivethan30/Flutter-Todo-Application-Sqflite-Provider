import 'package:flutter/material.dart';
import '../../../providers/theme_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/theme.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final ThemeProvider themeProvider;
  const AppBarWidget({super.key, required this.themeProvider});

  @override
  /// Builds the app bar with the title of the app and an action button to toggle the theme.
  ///
  /// The title of the app is displayed in a [Text] widget with a style that depends on the
  /// current theme of the app.
  ///
  /// The action button is an [IconButton] with a tooltip of "Change Theme" that toggles the
  /// theme of the app when pressed. The icon of the button is a brightness icon that is
  /// either filled or unfilled depending on the current theme of the app. The color of the
  /// icon is either black or white depending on the current theme of the app.
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        Constants.appBarTitle,
        style: themeProvider.themeData == AppTheme.light()
            ? Constants.poppinsNormalLight
            : Constants.poppinsNormalDark,
      ),
      actions: [
        IconButton(
            tooltip: "Change Theme",
            onPressed: () {
              themeProvider.toggleTheme();
            },
            icon: themeProvider.themeData == AppTheme.light()
                ? const Icon(
                    Icons.brightness_4,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.brightness_7,
                    color: Colors.white,
                  )),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
