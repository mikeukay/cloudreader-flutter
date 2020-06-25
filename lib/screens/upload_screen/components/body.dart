import 'dart:io';

import 'package:cloudreader/blocs/book_upload_bloc/bloc.dart';
import 'package:cloudreader/constants/colors.dart';
import 'package:cloudreader/screens/upload_screen/components/upload_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'choose_file_button.dart';
import 'heading_text.dart';
import 'name_text_field.dart';
import 'upload_text.dart';

class Body extends StatefulWidget {
  Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _nameController = TextEditingController();

  File _file;

  @override
  void initState() {
    _nameController.addListener(_onNameChangedListener);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookUploadBloc, BookUploadState>(
      builder: (BuildContext context, BookUploadState state) {
        if(state.isSubmitting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(state.isFailure) {
          return Center(
            child: Text(
              'Failed to upload book :(',
              style: TextStyle(color: kPrimaryColor),
            ),
          );
        }

        if(state.isSuccess) {
          return Center(
            child: Text(
              'Book uploaded :)',
            ),
          );
        }

        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UploadText(),
              SizedBox(height: 32.0),
              HeadingText('Name', usePadding: false),
              NameTextField(nameController: _nameController, valid: state.isNameValid),
              SizedBox(height: 48.0),
              HeadingText('File'),
              ChooseFileButton(onTap: _chooseFile),
              _file != null ? Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text('(will replace the current file)', style: TextStyle(color: Theme.of(context).disabledColor))]) : Container(),
              UploadButton(enabled: state.isFormValid && _file != null, onTap: _handleSubmit),
            ],
          ),
        );
      },
    );
  }

  void _onNameChangedListener() {
    BlocProvider.of<BookUploadBloc>(context).add(BookUploadNameChanged(_nameController.text));
  }

  void _chooseFile() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf',],
    );
    _file = file;
    BlocProvider.of<BookUploadBloc>(context).add(BookUploadFileChanged(file));
  }

  void _handleSubmit() async {
    BlocProvider.of<BookUploadBloc>(context).add(BookUploadSubmitPressed(_nameController.text, _file));
  }
}