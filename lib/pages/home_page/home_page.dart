import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utopia_recruitment_task/blocs/app_bloc/app_bloc.dart';
import 'package:utopia_recruitment_task/blocs/items_bloc/items_bloc.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/models/item_model.dart';
import 'package:utopia_recruitment_task/pages/_widgets/buttons/primary_button.dart';
import 'package:utopia_recruitment_task/pages/auth_page/auth_page.dart';
import 'package:utopia_recruitment_task/pages/home_page/_widgets/arrow_indicator.dart';
import 'package:utopia_recruitment_task/pages/home_page/_widgets/list_item.dart';
import 'package:utopia_recruitment_task/pages/item_page/item_page.dart';
import 'package:utopia_recruitment_task/pages/new_item_page/new_item_page.dart';
import 'package:utopia_recruitment_task/service/firebase_item_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const _AppBar(),
        body: Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: CustomTheme.pageGradient,
            ),
            child: SafeArea(
              child: BlocProvider(
                create: (_) => ItemsBloc(FirebaseItemService())
                  ..add(
                    GetItemsEvent(
                      (context.read<AppBloc>().state).user,
                    ),
                  ),
                child: const _HomePageView(),
              ),
            ),
          ),
        ),
        floatingActionButton: const _FloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  AppBar build(BuildContext context) => AppBar(
        title: Text(
          'UTOPIA',
          style: CustomTheme.appBarTitle,
        ),
        actions: <Widget>[
          BlocListener<AppBloc, AppState>(
            listener: (_, state) {
              if (state.user.isEmpty) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<void>(
                    builder: (context) => const AuthPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
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
      );
}

class _HomePageView extends StatelessWidget {
  const _HomePageView();

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: CustomTheme.pageGradient,
        ),
        child: BlocBuilder<ItemsBloc, ItemsState>(
          builder: (_, state) {
            if (state is LoadingItemsState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CompleteItemsState) {
              return RefreshIndicator(
                child: (state.items.isEmpty)
                    ? const _Empty()
                    : _ListView(state.items),
                onRefresh: () async => context.read<ItemsBloc>().add(
                      GetItemsEvent(
                        (context.read<AppBloc>().state).user,
                      ),
                    ),
              );
            } else if (state is ErrorItemsState) {
              return const _Error();
            }
            return const SizedBox();
          },
        ),
      );
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        backgroundColor: CustomTheme.white,
        child: const Icon(Icons.add_rounded),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (context) => const NewItemPage()),
          );
        },
      );
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) => Padding(
        padding: CustomTheme.contentPadding * 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Your list is empty, press button bellow to add new items into the list.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: CustomTheme.white,
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            SizedBox(height: CustomTheme.spacing),
            ArrowIndicator(),
          ],
        ),
      );
}

class _ListView extends StatelessWidget {
  _ListView(this.items);

  final List<Item> items;

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollTo() {
      _controller.animateTo(
        _controller.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => scrollTo());

    return ListView.builder(
      controller: _controller,
      padding: const EdgeInsets.fromLTRB(
        CustomTheme.spacing,
        CustomTheme.spacing,
        CustomTheme.spacing,
        75.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: CustomTheme.spacing),
        child: ListItem(
          index: index,
          item: items[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => ItemPage(item: items[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Something went wrong',
              style: TextStyle(
                color: CustomTheme.white,
              ),
            ),
            const SizedBox(height: CustomTheme.bigSpacing),
            PrimaryButton(
              title: 'Try again',
              onPressed: () => context.read<ItemsBloc>().add(
                    GetItemsEvent(
                      (context.read<AppBloc>().state).user,
                    ),
                  ),
            )
          ],
        ),
      );
}
