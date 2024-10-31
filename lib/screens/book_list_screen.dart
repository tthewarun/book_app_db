import 'package:flutter/material.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final List<Book> books = [
    Book(
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      description: 'A novel set in the Jazz Age.',
      imageUrl:
          'https://e7.pngegg.com/pngimages/342/861/png-clipart-book-book.png',
    ),
    // สามารถเพิ่มหนังสืออื่น ๆ ที่นี่
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
              _showAddBookDialog(context); // แสดง Dialog เพื่อเพิ่มหนังสือ
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
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.network(
                    book.imageUrl,
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Author: ${book.author}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        SizedBox(height: 5),
                        Text(
                          book.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showEditBookDialog(
                          context, index); // แสดง Dialog เพื่อแก้ไขหนังสือ
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDeleteBook(context, index); // ยืนยันการลบหนังสือ
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

  void _showAddBookDialog(BuildContext context) {
    final titleController = TextEditingController();
    final authorController = TextEditingController();
    final imageUrlController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Book'),
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
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
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
                _addBook(
                  titleController.text,
                  authorController.text,
                  imageUrlController.text,
                  descriptionController.text,
                );
                Navigator.of(context).pop(); // ปิด Dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditBookDialog(BuildContext context, int index) {
    final book = books[index];
    final titleController = TextEditingController(text: book.title);
    final authorController = TextEditingController(text: book.author);
    final imageUrlController = TextEditingController(text: book.imageUrl);
    final descriptionController = TextEditingController(text: book.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Book'),
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
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
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
                _editBook(
                  index,
                  titleController.text,
                  authorController.text,
                  imageUrlController.text,
                  descriptionController.text,
                );
                Navigator.of(context).pop(); // ปิด Dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteBook(BuildContext context, int index) {
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

  void _addBook(
      String title, String author, String imageUrl, String description) {
    setState(() {
      books.add(Book(
        title: title,
        author: author,
        imageUrl: imageUrl,
        description: description,
      ));
    });
  }

  void _editBook(int index, String title, String author, String imageUrl,
      String description) {
    setState(() {
      books[index] = Book(
        title: title,
        author: author,
        imageUrl: imageUrl,
        description: description,
      );
    });
  }

  void _deleteBook(int index) {
    setState(() {
      books.removeAt(index);
    });
  }
}

class Book {
  String title;
  String author;
  String imageUrl; // URL ของภาพหนังสือ
  String description; // คำอธิบายของหนังสือ

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
  });
}
