import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utopia_recruitment_task/blocs/app_bloc/app_bloc.dart';
import 'package:utopia_recruitment_task/blocs/new_item_cubit/new_item_cubit.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/pages/_widgets/buttons/primary_button.dart';
import 'package:utopia_recruitment_task/pages/_widgets/buttons/primary_loading_button.dart';
import 'package:utopia_recruitment_task/pages/_widgets/custom_messenger.dart';
import 'package:utopia_recruitment_task/service/firebase_item_service.dart';
import 'package:formz/formz.dart';

class NewItemPage extends StatefulWidget {
  const NewItemPage({super.key});

  @override
  State<NewItemPage> createState() => _NewItemState();
}

class _NewItemState extends State<NewItemPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final NewItemCubit _newItemCubit = NewItemCubit(FirebaseItemService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NEW',
          style: CustomTheme.appBarTitle,
        ),
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
            decoration: const BoxDecoration(
              color: CustomTheme.white,
              borderRadius: CustomTheme.mainRadius,
            ),
            child: Column(
              children: [
                _buildNameInput(),
                const SizedBox(height: CustomTheme.spacing),
                _buildNoteInput(),
                const SizedBox(height: CustomTheme.spacing),
                _buildURLInput(),
                const SizedBox(height: CustomTheme.spacing),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameInput() {
    return BlocBuilder<NewItemCubit, NewItemState>(
      bloc: _newItemCubit,
      builder: (_, state) {
        return TextFormField(
          controller: _nameController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state.name.invalid ? 'Please enter name' : null,
          ),
          onChanged: (value) => _newItemCubit.nameChanged(value),
        );
      },
    );
  }

  Widget _buildNoteInput() {
    return SizedBox(
      child: TextFormField(
        controller: _noteController,
        decoration: const InputDecoration(
          labelText: 'Note',
          alignLabelWithHint: true,
        ),
        keyboardType: TextInputType.multiline,
        minLines: 5,
        maxLines: 5,
        onChanged: (value) => _newItemCubit.noteChanged(value),
      ),
    );
  }

  Widget _buildURLInput() {
    return BlocBuilder<NewItemCubit, NewItemState>(
      bloc: _newItemCubit,
      builder: (_, state) {
        return TextFormField(
          controller: _urlController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Url',
            errorText: state.url.invalid ? 'Please enter correct url' : null,
          ),
          onChanged: (website) => _newItemCubit.urlChanged(website),
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return BlocConsumer<NewItemCubit, NewItemState>(
      bloc: _newItemCubit,
      listener: (_, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status == FormzStatus.submissionFailure) {
          CustomMessager().showError(
            context: context,
            message: 'Something went wrong, please try again.',
          );
        }
      },
      builder: (_, state) {
        if (state.status == FormzStatus.submissionInProgress ||
            state.status == FormzStatus.submissionSuccess) {
          return const PrimaryLoadingButton();
        } else {
          return PrimaryButton(
            title: 'Add new',
            active: !state.status.isPure && !state.status.isInvalid,
            action: () {
              final user = (BlocProvider.of<AppBloc>(context).state).user;
              _newItemCubit.addItem(user.id);
            },
          );
        }
      },
    );
  }
}
