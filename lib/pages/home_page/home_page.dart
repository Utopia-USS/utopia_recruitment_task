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
import 'package:utopia_recruitment_task/pages/item_page/item_page.dart';
import 'package:utopia_recruitment_task/pages/new_item_page/new_item_page.dart';
import 'package:utopia_recruitment_task/service/firebase_item_service.dart';

import '_widgets/list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseUser _user;
  late ItemsBloc _itemsBloc;

  @override
  void initState() {
    super.initState();
    _user = (BlocProvider.of<AppBloc>(context).state).user;
    _itemsBloc = ItemsBloc(FirebaseItemService())..add(GetItemsEvent(_user));
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: CustomTheme.contentPadding,
        decoration: BoxDecoration(
          gradient: CustomTheme.pageGradient,
        ),
        child: SafeArea(
          child: BlocBuilder<ItemsBloc, ItemsState>(
            bloc: _itemsBloc,
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

  Widget _buildEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Your list is empty, press button bellow to add new items into the list.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: CustomTheme.white,
          ),
        ),
        SizedBox(height: CustomTheme.spacing),
        Icon(
          Icons.arrow_downward_sharp,
          color: CustomTheme.white,
        )
      ],
    );
  }

  Widget _buildListView(List<Item> items) {
    return ListView(
      padding: CustomTheme.contentPadding,
      children: [
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: CustomTheme.spacing),
            child: ProductItem(
              item: item,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ItemPage(item: item)),
              ),
            ),
          ),
        ),
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
