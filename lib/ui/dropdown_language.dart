import 'package:app_chess/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 2, color: context.theme.primaryColor),
      ),
      child: DropdownButton<String>(
        value: context.locale.languageCode,
        borderRadius: BorderRadius.circular(25),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        onChanged: (String? value) {
          if (value != null) {
            context.setLocale(Locale(value));
          }
        },
        items: context.supportedLocales
            .map<DropdownMenuItem<String>>((Locale locale) {
          return DropdownMenuItem<String>(
            value: locale.languageCode,
            child: _getLanguageName(locale.languageCode),
          );
        }).toList(),
      ),
    );
  }

  Widget _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return const Text('English');
      case 'vi':
        return const Text('Tiếng Việt');
      case 'de':
        return const Text('Deutsch');
      default:
        return Text(languageCode);
    }
  }
}
