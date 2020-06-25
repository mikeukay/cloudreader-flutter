import 'package:cloudreader/constants/decorations.dart';
import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    Key key,
    @required TextEditingController nameController,
    @required bool valid
  }) : _nameController = nameController, _valid = valid, super(key: key);

  final TextEditingController _nameController;
  final bool _valid;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      autovalidate: true,
      autocorrect: false,
      decoration: kInputDecoration.copyWith(
        labelText: 'Book Name',
        hintText: 'e.g. War and Peace',
        errorText: _valid ? null : 'Invalid name',
      ),
    );
  }
}

