import 'package:flutter/material.dart';
import 'package:splash_screen_app/models/global_translations.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  static final List<String> languagesList =
      allTranslations.supportedLanguagesName;
  static final List<String> languageCodesList =
      allTranslations.supportedLanguagesCodes;

  final Map<String, String> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(allTranslations.text('title_select_language')),
      ),
      body: _buildLanguagesList(),
    );
  }

  _buildLanguagesList() {
    return ListView.builder(
      itemCount: languagesList.length,
      itemBuilder: (context, index) {
        return _buildLanguageItem(languagesList[index]);
      },
    );
  }

  _buildLanguageItem(String language) {
    return InkWell(
      onTap: () async {
        // change language here
        await allTranslations.setNewLanguage(languagesMap[language], true);
        setState(() {}); // set state to reload
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(allTranslations.text(language), style: TextStyle(fontSize: 24.0)),
        ),
      ),
    );
  }
}
