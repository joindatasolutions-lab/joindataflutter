import 'package:flutter/material.dart';

class FeatureToggle extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool?) onChanged;

  const FeatureToggle({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(label, style: const TextStyle(fontSize: 16)),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.primary,
      secondary: Icon(
        value ? Icons.check_circle : Icons.cancel,
        color: value
            ? Theme.of(context).colorScheme.primary
            : Colors.grey,
      ),
    );
  }
}
