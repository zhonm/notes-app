import 'package:flutter/material.dart';
import '../constants/constant_data.dart';

class FilterMenu extends StatelessWidget {
  const FilterMenu({super.key, required this.menuIndex});
  final int menuIndex;

  @override
  Widget build(BuildContext context) {
    final category = noteCategories[menuIndex];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChoiceChip(
        label: Text(category),
        selected: false,
        onSelected: (_) {},
      ),
    );
  }
}
