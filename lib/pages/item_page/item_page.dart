import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/helpers/datetime_helper.dart';
import 'package:utopia_recruitment_task/models/item_model.dart';
import 'package:utopia_recruitment_task/pages/_widgets/buttons/primary_button.dart';

class ItemPage extends StatelessWidget {
  final Item item;

  const ItemPage({super.key, required this.item});

  Page<void> page() => MaterialPage<void>(child: ItemPage(item: item));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text(item.name),
          ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: CustomTheme.pageGradient,
        ),
        child: SingleChildScrollView(
          padding: CustomTheme.pagePadding,
          child: Container(
            padding: CustomTheme.contentPadding,
            decoration: BoxDecoration(
              color: CustomTheme.white,
              borderRadius: CustomTheme.mainRadius,
              boxShadow: [CustomTheme.shadow],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateTimeHelper.fullDate(item.created),
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1,
                    fontWeight: FontWeight.w500,
                    color: CustomTheme.grey,
                  ),
                ),
                const SizedBox(height: CustomTheme.spacing),
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (item.note != null)
                  Padding(
                    padding: const EdgeInsets.only(top: CustomTheme.spacing),
                    child: Text(item.note!),
                  ),
                if (item.url != null)
                  Padding(
                    padding: const EdgeInsets.only(top: CustomTheme.spacing),
                    child: PrimaryButton(title: 'Open link', action: () {}),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
