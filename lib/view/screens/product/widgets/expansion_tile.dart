import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class DetailsExpansionTileWidget extends StatelessWidget {
  final String textData;
  final String titleData;
  const DetailsExpansionTileWidget({
    super.key,
    required this.textData,
    required this.titleData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ExpansionTile(
        iconColor: Colors.black,
        collapsedIconColor: Colors.black,
        initiallyExpanded: true,
        title: SectionTitleWidget(
          title: titleData,
          size: 0.0,
        ),
        children: [
          ListTile(
            title: Text(
              textData,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
