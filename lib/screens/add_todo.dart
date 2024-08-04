import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';
import '../providers/theme_provider.dart';

class AddTodo {
  TextEditingController todoNameController = TextEditingController();

  void show(
      {required BuildContext context,
      required ThemeProvider themeProvider,
      required Function(String) onAddPressed}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        todoNameController.clear();
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 5,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add New Todo',
                    style: themeProvider.themeData == AppTheme.light()
                        ? poppinsLight(20)
                        : poppinsDark(20),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                      maxLength: 100,
                      controller: todoNameController,
                      style: themeProvider.themeData == AppTheme.light()
                          ? Constants.poppinsNormalLight
                          : Constants.poppinsNormalDark,
                      decoration: InputDecoration(
                        hintText: 'Tap to Create Todo',
                        hintStyle: themeProvider.themeData == AppTheme.light()
                            ? Constants.poppinsNormalLight
                            : Constants.poppinsNormalDark,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3)),
                      )),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          onAddPressed(todoNameController.text);
                        },
                        child: Text('Done',
                            style: themeProvider.themeData == AppTheme.light()
                                ? Constants.poppinsNormalLight
                                : Constants.poppinsNormalDark),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
