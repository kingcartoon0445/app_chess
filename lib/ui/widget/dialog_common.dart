import 'package:app_chess/ui/dialog_status.dart';

import '../../main.dart';

class DialogCommon {
  // Show Success Dialog
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const StatusDialog(
        isSuccess: true,
        // Optional customizations:
        // title: 'Custom Title',
        // message: 'Custom message here',
        // buttonText: 'Custom Button Text',
        // onButtonPressed: () => print('Button pressed'),
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
