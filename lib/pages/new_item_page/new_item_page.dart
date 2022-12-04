import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:utopia_recruitment_task/blocs/app_bloc/app_bloc.dart';
import 'package:utopia_recruitment_task/blocs/new_item_cubit/new_item_cubit.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/pages/_widgets/buttons/primary_button.dart';
import 'package:utopia_recruitment_task/pages/_widgets/buttons/primary_loading_button.dart';
import 'package:utopia_recruitment_task/pages/_widgets/custom_messenger.dart';
import 'package:utopia_recruitment_task/service/datetime_service.dart';
import 'package:utopia_recruitment_task/service/firebase_item_service.dart';

class NewItemPage extends StatelessWidget {
  const NewItemPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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
            child: BlocProvider(
              create: (context) => NewItemCubit(
                FirebaseItemService(),
                DateTimeService(),
              ),
              child: Container(
                padding: CustomTheme.contentPadding,
                decoration: const BoxDecoration(
                  color: CustomTheme.white,
                  borderRadius: CustomTheme.mainRadius,
                ),
                child: const _NewItemView(),
              ),
            ),
          ),
        ),
      );
}

class _NewItemView extends StatelessWidget {
  const _NewItemView();

  @override
  Widget build(BuildContext context) => Column(
        children: const [
          SizedBox(height: CustomTheme.spacing),
          _NameInput(),
          SizedBox(height: CustomTheme.spacing),
          _NoteInput(),
          SizedBox(height: CustomTheme.spacing),
          _URLInput(),
          SizedBox(height: CustomTheme.spacing),
          _SaveButton(),
        ],
      );
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<NewItemCubit, NewItemState>(
        builder: (_, state) => TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state.name.invalid ? 'Please enter name' : null,
          ),
          onChanged: context.read<NewItemCubit>().nameChanged,
        ),
      );
}

class _NoteInput extends StatelessWidget {
  const _NoteInput();

  @override
  Widget build(BuildContext context) => SizedBox(
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Note',
            alignLabelWithHint: true,
          ),
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 5,
          onChanged: context.read<NewItemCubit>().noteChanged,
        ),
      );
}

class _URLInput extends StatelessWidget {
  const _URLInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<NewItemCubit, NewItemState>(
        builder: (_, state) => TextFormField(
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
            labelText: 'Url',
            errorText: state.url.invalid ? 'Please enter correct url' : null,
          ),
          onChanged: context.read<NewItemCubit>().urlChanged,
        ),
      );
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<NewItemCubit, NewItemState>(
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
              onPressed: () {
                final user = (context.read<AppBloc>().state).user;
                context.read<NewItemCubit>().addItem(user.id);
              },
            );
          }
        },
      );
}
