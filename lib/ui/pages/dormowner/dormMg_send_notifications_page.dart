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
  bool _showPreview = false;

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

  void _deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
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
      // Bildirimi burada gönderebilirim
      print(notification.toJson());
    }
  }

  Future<String> uploadImageToServer(File image) async {
    // Sunucuya resimleri yükleme burada, boş örnek
    return '';
  }

  void _togglePreview() {
    setState(() {
      _showPreview = !_showPreview;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDrawer(activePage: ActivePages.dormMGsendNotifications,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(32.0),
                      constraints: BoxConstraints(maxWidth: 600),
                      child: _showPreview ? _buildPreview() : _buildForm(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Send Notifications & Alerts',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Group',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _groupController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Notification Title',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Notification Description',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Add Photo'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 16, horizontal: 32),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _togglePreview,
                  child: Text('Preview'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _uploadImages();
                    // Kaydetme fonksiyonu buraya gelecek, _uploadedImageUrls +
                  },
                  child: Text('Send Notification'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Preview Notification',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.notifications, color: Colors.blue),
          title: Text(
            _titleController.text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(_descriptionController.text),
          trailing: Text('Just now'),
        ),
        const SizedBox(height: 20),
        if (_images.isNotEmpty)
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Container(
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
                );
              },
            ),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _togglePreview,
          child: Text('Edit'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(
                vertical: 16, horizontal: 32),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _groupController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
