import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;
  final Widget? customLoadingWidget;
  final Color barrierColor;
  final bool barrierDismissible;
  final TextStyle? messageStyle;
  final EdgeInsets padding;

  const LoadingDialog({
    super.key,
    this.message,
    this.customLoadingWidget,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = false,
    this.messageStyle,
    this.padding = const EdgeInsets.all(24.0),
  });

  // Static method để show dialog dễ dàng
  static Future<void> show(
    BuildContext context, {
    String? message,
    Widget? customLoadingWidget,
    Color barrierColor = Colors.black54,
    bool barrierDismissible = false,
    TextStyle? messageStyle,
    EdgeInsets? padding,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (context) => LoadingDialog(
        message: message,
        customLoadingWidget: customLoadingWidget,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        messageStyle: messageStyle,
        padding: padding ?? const EdgeInsets.all(24.0),
      ),
    );
  }

  // Static method để hide dialog
  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => barrierDismissible,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Loading indicator
                customLoadingWidget ??
                    const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),

                // Message text if provided
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    message!,
                    style: messageStyle ??
                        const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom loading widget example
class CustomLoadingWidget extends StatelessWidget {
  final Color color;
  final double size;

  const CustomLoadingWidget({
    super.key,
    this.color = Colors.blue,
    this.size = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 4,
      ),
    );
  }
}
