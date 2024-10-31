import 'package:flutter/material.dart';

class EditBookScreen extends StatefulWidget {
  @override
  _EditBookScreen createState() => _EditBookScreen();
}

class _EditBookScreen extends State<EditBookScreen> {
  final List<Book> books = [
    Book(
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      imageUrl: 'https://example.com/great_gatsby.jpg',
      description: 'A novel set in the Jazz Age.',
    ),
    // เพิ่มหนังสืออื่น ๆ ที่นี่
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Books'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // กลับไปยังหน้าจอก่อนหน้า
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showBookForm(context); // แสดงฟอร์มเพิ่มหนังสือ
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(8.0),
              leading: Image.network(
                book.imageUrl,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
              title: Text(
                book.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Author: ${book.author}',
                      style: TextStyle(color: Colors.grey[700])),
                  Text(
                    book.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showBookForm(context,
                          book: book, index: index); // แก้ไขหนังสือ
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDeleteBook(index); // ยืนยันการลบหนังสือ
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showBookForm(BuildContext context, {Book? book, int? index}) {
    final titleController = TextEditingController(text: book?.title ?? '');
    final authorController = TextEditingController(text: book?.author ?? '');
    final descriptionController =
        TextEditingController(text: book?.description ?? '');
    final imageUrlController =
        TextEditingController(text: book?.imageUrl ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(book == null ? 'Add Book' : 'Edit Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (book == null) {
                  _addBook(titleController.text, authorController.text,
                      imageUrlController.text, descriptionController.text);
                } else {
                  // เรียกใช้ _editBook
                  _editBook(index!, titleController.text, authorController.text,
                      imageUrlController.text, descriptionController.text);
                }
                Navigator.of(context).pop(); // ปิด Dialog
              },
              child: Text(book == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  void _addBook(
      String title, String author, String imageUrl, String description) {
    setState(() {
      books.add(Book(
          title: title,
          author: author,
          imageUrl: imageUrl,
          description: description));
    });
  }

  void _editBook(int index, String title, String author, String imageUrl,
      String description) {
    setState(() {
      books[index] = Book(
          title: title,
          author: author,
          imageUrl: imageUrl,
          description: description);
    });
  }

  void _confirmDeleteBook(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this book?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteBook(index); // ลบหนังสือ
                Navigator.of(context).pop(); // ปิด Dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteBook(int index) {
    setState(() {
      books.removeAt(index);
    });
  }
}

class Book {
  String title; // เปลี่ยนเป็นไม่ใช้ final
  String author; // เปลี่ยนเป็นไม่ใช้ final
  String imageUrl; // URL ของภาพหนังสือ
  String description; // คำอธิบายของหนังสือ

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
  });
}
