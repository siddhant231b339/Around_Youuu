import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final _client = Supabase.instance.client;
  final _bucket = 'ar_assets';

  Future<String> uploadImage(File file, {String folder = 'images'}) async {
    final id = const Uuid().v4();
    final path = '$folder/$id.jpg';
    await _client.storage.from(_bucket).upload(path, file);
    final url = _client.storage.from(_bucket).getPublicUrl(path);
    return url;
  }

  Future<String> uploadAudio(File file, {String folder = 'audio'}) async {
    final id = const Uuid().v4();
    final path = '$folder/$id.m4a';
    await _client.storage.from(_bucket).upload(path, file);
    final url = _client.storage.from(_bucket).getPublicUrl(path);
    return url;
  }
}