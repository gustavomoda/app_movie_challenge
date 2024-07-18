import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../config/themes/tokens/text.dart';
import '../../../../shared/presenter/atoms/texts/texts.dart';
import '../../../../shared/presenter/organisms/scafolds.dart';

class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.all(AppTheme.spacings.md);
    // It's a showcase, in first time, it's simple to can view all components
    // to check the theme.
    // In the future must be refactored to a better way to show the components.
    return AppScaffolds.fullWithSafeArea(
      context,
      title: 'Theme showcase',
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Showcase of all components with the current theme'),
          ),
          const _SectionTitle('Butons variations'),
          Padding(
            padding: padding,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('ElevatedButton'),
            ),
          ),
          Padding(
            padding: padding,
            child: TextButton(
              onPressed: () {},
              child: const Text('TextButton'),
            ),
          ),
          Padding(
            padding: padding,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('OutlinedButton'),
            ),
          ),
          const _SectionTitle('Inputs variations'),
          Padding(
            padding: padding,
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'TextField',
              ),
            ),
          ),
          Padding(
            padding: padding,
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'TextField',
                icon: Icon(Icons.search),
                prefixIcon: Icon(Icons.read_more),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          RadioListTile<int>(
            title: const Text('RadioListTile'),
            value: 0,
            groupValue: 0,
            onChanged: (value) {},
          ),
          const _SectionTitle('Cards variations'),
          Padding(
            padding: padding,
            child: Card(
              child: Container(
                padding: padding,
                child: const Text('Card with Text'),
              ),
            ),
          ),
          const _SectionTitle('ListTile variations'),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Default ListTile'),
            subtitle: const Text('Subtitle'),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('ListTile with dense true'),
            subtitle: const Text('Subtitle'),
            dense: true,
            trailing: const Icon(Icons.navigate_next),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('ListTile with isThreeLine true'),
            subtitle: const Text('Subtitle\nSecond line'),
            isThreeLine: true,
            trailing: const Icon(Icons.navigate_next),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('ListTile with enabled false'),
            subtitle: const Text('Subtitle'),
            enabled: false,
            trailing: const Icon(Icons.navigate_next),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('ListTile with selected true'),
            subtitle: const Text('Subtitle'),
            selected: true,
            trailing: const Icon(Icons.navigate_next),
            onTap: () {},
          ),
          CheckboxListTile(
            title: const Text('CheckboxListTile'),
            value: false,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: const Text('SwitchListTile'),
            value: true,
            onChanged: (value) {},
          ),
          const _SectionTitle('Typography variations'),
          ...AppTextTokens.values.map(
            (element) => Padding(
              padding: padding,
              child: AppTexts.custom(
                element.name,
                style: element,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => const AppTexts.bodyLarge(
        'ListTile examples:',
        textAlign: TextAlign.center,
        // color: context.watch<AppTheme>().theme.colorScheme.secondary,
      );
}
