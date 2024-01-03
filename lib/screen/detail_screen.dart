// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusantarainfra_test/controller/data_controller.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> book;

  const DetailPage({super.key, required this.book});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final DataController _dataController = Get.find<DataController>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.book['title'];
    authorController.text = widget.book['author'];
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Edit Book'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(labelText: 'Title'),
                        ),
                        TextField(
                          controller: authorController,
                          decoration: const InputDecoration(labelText: 'Author'),
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          final updatedBook = {
                            'id': widget.book['id'],
                            'isbn': widget.book['isbn'],
                            'title': titleController.text,
                            'author': authorController.text,
                          };
                          _dataController.updateBook(
                              widget.book['id'], updatedBook);
                          Navigator.of(context).pop();
                          Get.back();
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              _dataController.deleteBook(widget.book['id'].toString());
              Get.back();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Obx(
        () => _dataController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  ListTile(
                    title: const Text('ISBN'),
                    subtitle: Text(widget.book['isbn']),
                  ),
                  ListTile(
                    title: const Text('Title'),
                    subtitle: Text(widget.book['title']),
                  ),
                  ListTile(
                    title: const Text('Author'),
                    subtitle: Text(widget.book['author']),
                  ),
                ],
              ),
      ),
    );
  }
}
