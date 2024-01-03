import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusantarainfra_test/controller/data_controller.dart';
import 'package:nusantarainfra_test/screen/detail_screen.dart';
import 'package:nusantarainfra_test/screen/login_screen.dart';

class HomePage extends StatelessWidget {
  final DataController dataController = Get.find<DataController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      dataController.fetchBooks();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              dataController.logoutUser();
              Get.offAll(LoginPage());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(
              () => Text(
                'Welcome, ${dataController.currentUser['name']}!',
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: Obx(
              () {
                if (dataController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (dataController.books.isEmpty) {
                  return const Center(child: Text('No books found.'));
                } else {
                  return ListView.builder(
                    itemCount: dataController.books[0]['data'].length,
                    itemBuilder: (context, index) {
                      final book = dataController.books[0]['data'][index];

                      return GestureDetector(
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: ListTile(
                            title: Text(book['title']),
                            subtitle: Text(book['author']),
                          ),
                        ),
                        onTap: () {
                          Get.to(DetailPage(book: book));
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Tambah Buku'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: isbnController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'ISBN',
                      ),
                    ),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Judul',
                      ),
                    ),
                    TextField(
                      controller: authorController,
                      decoration: const InputDecoration(
                        labelText: 'Penulis',
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      dataController.addBook({
                        'isbn': isbnController.text,
                        'title': titleController.text,
                        'author': authorController.text,
                      });
                      titleController.clear();
                      authorController.clear();
                      isbnController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Tambah'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
