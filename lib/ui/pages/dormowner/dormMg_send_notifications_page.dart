import 'dart:io';
import 'package:dormitory_management/models/app_notification.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

class DormMGSendNotifications extends ConsumerStatefulWidget {
  const DormMGSendNotifications({Key? key}) : super(key: key);

  @override
  _DormMGSendNotificationsState createState() => _DormMGSendNotificationsState();
}

class _DormMGSendNotificationsState extends ConsumerState<DormMGSendNotifications> {
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<File> _images = [];

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _images.add(File(result.files.single.path!));
      });
    }
  }

  Future<void> _uploadImages() async {
    for (File image in _images) {
      String imageUrl = await uploadImageToServer(image);
      final notification = AppNotification(
        id: null,
        title: _titleController.text,
        description: _descriptionController.text,
        senderId: null,
        receiverId: null,
        imageUrl: imageUrl,
        seen: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      //bildirimi burda gönderebilirim
      print(notification.toJson());
    }
  }

  Future<String> uploadImageToServer(File image) async {
    // Sunucuya resimleri yükleme burada, boş örnek
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              constraints: BoxConstraints(maxWidth: 1000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send Notifications & Alerts',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _groupController,
                              decoration: InputDecoration(labelText: 'Group'),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _titleController,
                              decoration: InputDecoration(labelText: 'Notification Title'),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 5,
                              decoration: InputDecoration(labelText: 'Notification Description'),
                            ),
                            SizedBox(height: 16),
                            Container(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _images.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: FileImage(_images[index]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _deleteImage(index),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _pickImage,
                              child: Text('Add Photo'),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () async {
                                await _uploadImages();
                              //kaydetme fonksiyonu buraya gelecek, _uploadedImageUrls +
                              },
                              child: Text('Save'),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(thickness: 1, color: Colors.grey),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Preview',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16),
                            if (_images.isNotEmpty)
                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: FileImage(_images.first),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            SizedBox(height: 16),
                            Text(
                              _titleController.text,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _descriptionController.text,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  void dispose() {
    _groupController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
