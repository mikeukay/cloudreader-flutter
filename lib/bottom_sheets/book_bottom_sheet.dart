import 'package:cloudreader/blocs/books_bloc/bloc.dart';
import 'package:cloudreader/constants/colors.dart';
import 'package:cloudreader/constants/decorations.dart';
import 'package:cloudreader/models/book.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void showBookEditBottomSheet(BuildContext ctx, Book book, BooksBloc bloc) {
  showModalBottomSheet(
      context: ctx,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(
                  Icons.edit,
                ),
                title: Text('Rename'),
                onTap: () async {
                  String newBookName = await showEditBookDialog(context, book.name);
                  Navigator.of(context).pop();
                  if(newBookName != null && newBookName != book.name) {
                   bloc.add(BookUpdated(book, book.copyWith(name: newBookName)));
                  }
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                title: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  bool delete = await showDeleteDialog(context);
                  Navigator.of(context).pop();
                  if(delete) {
                    bloc.add(BookDeleted(book));
                    if(kIsWeb) {
                      Scaffold.of(ctx)..hideCurrentSnackBar()..showSnackBar(SnackBar(
                          content: Text('Book deleted. Please refresh your browser.'),
                        ));
                    }
                  }
                },
              ),
            ],
          ),
        );
      }
  );
}

Future<bool> showDeleteDialog(context) async {
  bool delete = false;

  Widget cancelButton = FlatButton(
    child: Text("CANCEL", style: TextStyle(color: kDialogButtonColor)),
    onPressed:  () {
      delete = false;
      Navigator.of(context).pop();
    },
  );
  Widget deleteButton = FlatButton(
    child: Text(
      "DELETE",
      style: TextStyle(color: Colors.red),
    ),
    onPressed:  () {
      delete = true;
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Are you sure?"),
    content: Text("Do you really want to delete this book? This action cannot be reversed."),
    actions: [
      cancelButton,
      deleteButton,
    ],
  );

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

  return delete;
}

Future<String> showEditBookDialog(context, String initialVal) async {
  String name = initialVal;
  return await showDialog<String>(
    context: context,
    builder: (context) => new AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              autofocus: true,
              maxLength: 32,
              controller: TextEditingController(text: initialVal),
              decoration: kInputDecoration.copyWith(
                labelText: 'New Name',
                hintText: 'eg. The Are of War',
              ),
              onChanged: (newValue) {
                name = newValue;
              },
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            child: const Text('CANCEL', style: TextStyle(color: kDialogButtonColor)),
            onPressed: () {
              Navigator.pop(context);
              return initialVal;
            }),
        new FlatButton(
            child: const Text('EDIT', style: TextStyle(color: kDialogButtonColor)),
            onPressed: () {
              Navigator.pop(context, name);
              return name;
            })
      ],
    ),
  );
}