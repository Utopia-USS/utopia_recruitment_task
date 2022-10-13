import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/pages/_widgets/buttons/primary_button.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Item')),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: CustomTheme.pageGradient,
        ),
        child: SingleChildScrollView(
          padding: CustomTheme.pagePadding,
          child: Column(
            children: [
              _buildNameInput(),
              SizedBox(height: 12.0),
              _buildNoteInput(),
              SizedBox(height: 12.0),
              _buildURLInput(),
              SizedBox(height: 36.0),
              PrimaryButton(
                title: 'Add new',
                action: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameInput() {
    return SizedBox(
      height: 50.0,
      child: TextFormField(
        controller: _nameController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Name',
        ),
        onChanged: (val) {},
      ),
    );
  }

  Widget _buildNoteInput() {
    return SizedBox(
      child: TextFormField(
        controller: _noteController,
        decoration: InputDecoration(
          labelText: 'Note',
          alignLabelWithHint: true,
        ),
        keyboardType: TextInputType.multiline,
        minLines: 5,
        maxLines: 5,
        onChanged: (val) {},
      ),
    );
  }

  Widget _buildURLInput() {
    return SizedBox(
      height: 50.0,
      child: TextFormField(
        controller: _urlController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Url',
        ),
        onChanged: (val) {},
      ),
    );
  }
}
