import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utopia_recruitment_task/blocs/app_bloc/app_bloc.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/pages/auth_page/auth_page.dart';
import 'package:utopia_recruitment_task/pages/item_page/item_page.dart';
import 'package:utopia_recruitment_task/pages/new_item/new_item.dart';

import '_widgets/list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

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
      appBar: AppBar(
        title: const Text('UTOPIA'),
        actions: <Widget>[
          BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              if (state.user.isEmpty) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const AuthPage()),
                    (Route<dynamic> route) => false);
              }
            },
            child: CupertinoButton(
              key: const Key('homePage_logout_iconButton'),
              child: const Icon(
                Icons.exit_to_app_rounded,
                color: CustomTheme.semiBlue,
              ),
              onPressed: () =>
                  context.read<AppBloc>().add(AppLogoutRequested()),
            ),
          )
        ],
      ),
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
                padding: const EdgeInsets.only(bottom: CustomTheme.spacing),
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
