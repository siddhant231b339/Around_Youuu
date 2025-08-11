import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../providers/providers.dart';
import '../../../models/memory.dart';

class CreateMemoryScreen extends ConsumerStatefulWidget {
  const CreateMemoryScreen({super.key});

  @override
  ConsumerState<CreateMemoryScreen> createState() => _CreateMemoryScreenState();
}

class _CreateMemoryScreenState extends ConsumerState<CreateMemoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _text = TextEditingController();
  bool _isPublic = true;
  File? _image;

  @override
  void dispose() {
    _title.dispose();
    _text.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final x = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (x != null) setState(() => _image = File(x.path));
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final locService = ref.read(locationServiceProvider);
    final storage = ref.read(storageServiceProvider);
    final memService = ref.read(memoryServiceProvider);

    final pos = await locService.getCurrentPosition();
    if (pos == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location not available')));
      return;
    }

    String? imageUrl;
    if (_image != null) {
      imageUrl = await storage.uploadImage(_image!);
    }

    final id = const Uuid().v4();
    final modelUrl = dotenv.env['AR_TEST_GLB_URL'] ?? '';
    final position = memService.buildPositionField(lat: pos.latitude, lng: pos.longitude);

    final memory = Memory(
      id: id,
      ownerUid: 'me',
      title: _title.text.trim(),
      text: _text.text.trim().isEmpty ? null : _text.text.trim(),
      imageUrl: imageUrl,
      audioUrl: null,
      modelUrl: modelUrl,
      lat: pos.latitude,
      lng: pos.longitude,
      geohash: position['geohash'] as String,
      isPublic: _isPublic,
      createdAt: DateTime.now(),
    );

    final map = memory.toMap()..['position'] = position;

    await ref.read(firestoreProvider).collection('memories').doc(id).set(map);

    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Memory created')));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Memory')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _title,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter a title' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _text,
                      decoration: const InputDecoration(labelText: 'Optional text'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Switch(
                          value: _isPublic,
                          onChanged: (v) => setState(() => _isPublic = v),
                        ),
                        const SizedBox(width: 8),
                        Text(_isPublic ? 'Public' : 'Private'),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.image),
                          label: Text(_image == null ? 'Add photo' : 'Change photo'),
                        ),
                      ],
                    ),
                    if (_image != null) ...[
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(_image!, height: 160, fit: BoxFit.cover),
                      ),
                    ],
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _save,
                        icon: const Icon(Icons.save),
                        label: const Text('Save Memory'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Model URL: ${dotenv.env['AR_TEST_GLB_URL'] ?? 'Not set'}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}