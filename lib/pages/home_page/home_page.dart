import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/pages/item_page/item_page.dart';
import 'package:utopia_recruitment_task/pages/new_item/new_item.dart';

import '_widgets/list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> items = [
      1,
      2,
      3,
      4,
      5,
      1,
      1,
      2,
      3,
      4,
      5,
      1,
      1,
      2,
      3,
      4,
      5,
      1,
    ];

    return Scaffold(
      appBar: AppBar(title: Text('UTOPIA')),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: CustomTheme.pageGradient,
        ),
        child: SafeArea(
          child: ListView.builder(
            padding: CustomTheme.pagePadding,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ProductItem(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ItemPage()),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomTheme.white,
        child: const Icon(Icons.add_rounded),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const NewItem())),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
