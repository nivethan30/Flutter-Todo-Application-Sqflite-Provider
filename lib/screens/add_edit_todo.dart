import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';
import '../providers/theme_provider.dart';

class AddEditTodo {
  static TextEditingController todoNameController = TextEditingController();

  ///
  /// Shows a modal bottom sheet to add or edit a todo.
  ///
  /// [context] is the build context of the widget that calls this function.
  ///
  /// [todoName] is the name of the todo to be edited. If null, the text field
  /// will be empty.
  ///
  /// [isEdit] is a boolean indicating whether the todo is being edited or not.
  ///
  /// [themeProvider] is the theme provider of the app.
  ///
  /// [onDonePressed] is a callback function that will be called when the done
  /// button is pressed. It takes the text of the todo as a parameter.
  ///
  /// When the done button is pressed, the bottom sheet will be dismissed and
  /// the [onDonePressed] callback will be called with the text of the todo.
  ///
  static void show(
      {required BuildContext context,
      required String? todoName,
      required bool isEdit,
      required ThemeProvider themeProvider,
      required Function(String) onDonePressed}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        isEdit
            ? todoNameController.text = todoName!
            : todoNameController.clear();
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 5,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isEdit ? "Edit Todo" : "Add New Todo",
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
                        counterText: "",
                        hintText: 'Enter Todo Name',
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
                          onDonePressed(todoNameController.text);
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
