import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

import 'package:open_local_ui/layout/page_base.dart';
import 'package:open_local_ui/providers/locale.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, value, child) => PageBaseLayout(
        body: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AdaptiveTheme.of(context).theme.dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: _buildThemeSettings(context),
              ),
            ),
            const SizedBox(width: 32.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AdaptiveTheme.of(context).theme.dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: _buildAccessibilitySettings(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSettings(BuildContext context) {
    String themeModeString;

    switch (AdaptiveTheme.of(context).mode) {
      case AdaptiveThemeMode.light:
        themeModeString = AppLocalizations.of(context)!.settingsThemeModeLight;
        break;
      case AdaptiveThemeMode.dark:
        themeModeString = AppLocalizations.of(context)!.settingsThemeModeDark;
        break;
      case AdaptiveThemeMode.system:
        themeModeString = AppLocalizations.of(context)!.settingsThemeModeSystem;
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.settingsPageThemeLabel,
          style: const TextStyle(fontSize: 24.0),
        ),
        const SizedBox(height: 8.0),
        DropdownMenu(
          leadingIcon: const Icon(UniconsLine.moon_eclipse),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          initialSelection: themeModeString,
          dropdownMenuEntries: [
            DropdownMenuEntry(
                value: 'Light',
                label: AppLocalizations.of(context)!.settingsThemeModeLight),
            DropdownMenuEntry(
                value: 'Dark',
                label: AppLocalizations.of(context)!.settingsThemeModeDark),
            DropdownMenuEntry(
                value: 'System',
                label: AppLocalizations.of(context)!.settingsThemeModeSystem),
          ],
          onSelected: (value) {
            switch (value) {
              case 'Light':
                AdaptiveTheme.of(context).setLight();
                break;
              case 'Dark':
                AdaptiveTheme.of(context).setDark();
                break;
              case 'System':
                AdaptiveTheme.of(context).setSystem();
                break;
            }
          },
        ),
      ],
    );
  }

  Widget _buildAccessibilitySettings(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.settingsPageAccessiblityLabel,
          style: const TextStyle(fontSize: 24.0),
        ),
        const SizedBox(height: 8.0),
        DropdownMenu(
          leadingIcon: const Icon(UniconsLine.language),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          initialSelection: context.watch<LocaleProvider>().languageCode,
          dropdownMenuEntries: [
            DropdownMenuEntry(
                value: 'en',
                label: AppLocalizations.of(context)!.settingsLanguageEnglish),
            DropdownMenuEntry(
                value: 'es',
                label: AppLocalizations.of(context)!.settingsLanguageSpanish),
            DropdownMenuEntry(
                value: 'fr',
                label: AppLocalizations.of(context)!.settingsLanguageFrench),
            DropdownMenuEntry(
                value: 'de',
                label: AppLocalizations.of(context)!.settingsLanguageDetusche),
            DropdownMenuEntry(
                value: 'it',
                label: AppLocalizations.of(context)!.settingsLanguageItalian),
          ],
          onSelected: (value) async {
            context.read<LocaleProvider>().setLocale(Locale(value ?? 'en'));

            final prefs = await SharedPreferences.getInstance();

            await prefs.setString('locale', value ?? 'en');
          },
        ),
      ],
    );
  }
}
