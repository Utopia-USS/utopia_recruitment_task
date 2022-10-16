import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utopia_recruitment_task/blocs/app_bloc/app_bloc.dart';
import 'package:utopia_recruitment_task/blocs/items_bloc/items_bloc.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/models/firebase_user_model.dart';
import 'package:utopia_recruitment_task/models/item_model.dart';
import 'package:utopia_recruitment_task/pages/_widgets/buttons/primary_button.dart';
import 'package:utopia_recruitment_task/pages/auth_page/auth_page.dart';
import 'package:utopia_recruitment_task/pages/home_page/_widgets/arrow_indicator.dart';
import 'package:utopia_recruitment_task/pages/item_page/item_page.dart';
import 'package:utopia_recruitment_task/pages/new_item_page/new_item_page.dart';
import 'package:utopia_recruitment_task/service/firebase_item_service.dart';

import '_widgets/list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  late FirebaseUser _user;
  late ItemsBloc _itemsBloc;

  void _scrollUp() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    _user = (BlocProvider.of<AppBloc>(context).state).user;
    _itemsBloc = ItemsBloc(FirebaseItemService())..add(GetItemsEvent(_user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContent(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'UTOPIA',
        style: CustomTheme.appBarTitle,
      ),
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
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          ),
        )
      ],
    );
  }

  Widget _buildContent() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: CustomTheme.pageGradient,
      ),
      child: SafeArea(
        child: BlocConsumer<ItemsBloc, ItemsState>(
          bloc: _itemsBloc,
          listener: (_, state) {
            // if (state is CompleteItemsState) {
            //   () => _scrollUp();
            // }
          },
          builder: (context, state) {
            if (state is LoadingItemsState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CompleteItemsState) {
              return RefreshIndicator(
                child: (state.items.isEmpty)
                    ? _buildEmpty()
                    : _buildListView(state.items),
                onRefresh: () async => _itemsBloc.add(GetItemsEvent(_user)),
              );
            } else if (state is ErrorItemsState) {
              return _buildError();
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: CustomTheme.white,
      child: const Icon(Icons.add_rounded),
      onPressed: () async {
        var result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewItemPage()),
        );
        if (result != null) {
          _scrollUp();
        }
      },
    );
  }

  Widget _buildEmpty() {
    return Padding(
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

  Widget _buildListView(List<Item> items) {
    return ListView(
      controller: _controller,
      padding: CustomTheme.contentPadding,
      children: [
        ...items.asMap().entries.map((entry) {
          final item = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: CustomTheme.spacing),
            child: ListItem(
                index: entry.key,
                item: item,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemPage(item: item)),
                  );
                }),
          );
        }),
        const SizedBox(height: 75.0),
      ],
    );
  }

  Widget _buildError() {
    return SizedBox(
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
            action: () => _itemsBloc.add(GetItemsEvent(_user)),
          )
        ],
      ),
    );
  }
}
