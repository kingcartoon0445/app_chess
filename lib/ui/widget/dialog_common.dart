import 'package:app_chess/ui/dialog_status.dart';

import '../../main.dart';

class DialogCommon {
  // Show Success Dialog
  void showSuccessDialog(BuildContext context,
      {required String message, Function()? onButtonPressed}) {
    showDialog(
      context: context,
      builder: (context) => StatusDialog(
        isSuccess: true,
        // Optional customizations:
        // title: 'Custom Title',
        message: message,
        // buttonText: 'Custom Button Text',
        onButtonPressed: onButtonPressed,
      ),
    );
  }

// Show Error Dialog
  void showErrorDialog(BuildContext context, {required String message}) {
    showDialog(
      context: context,
      builder: (context) => StatusDialog(
        isSuccess: false,
        message: message,
      ),
    );
  }
}
