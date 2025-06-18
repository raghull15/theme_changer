import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Theme Changer'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppTheme.values.map<Widget>((theme) {
            final themeLabel = _formatThemeName(theme);

            return RadioListTile<AppTheme>(
              title: Text(themeLabel),
              value: theme,
              groupValue: themeProvider.theme,
              onChanged: (selectedTheme) {
                if (selectedTheme != null) {
                  themeProvider.setTheme(selectedTheme);
                }
              },
              secondary: Icon(_themeIcon(theme)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _formatThemeName(AppTheme theme) {
    final name = theme.name;
    return name[0].toUpperCase() + name.substring(1);
  }

  IconData _themeIcon(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return Icons.light_mode;
      case AppTheme.dark:
        return Icons.dark_mode;
      case AppTheme.system:
        return Icons.brightness_auto;
    }
  }
}
