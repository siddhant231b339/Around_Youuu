class Memory {
  final String id;
  final String ownerUid;
  final String title;
  final String? text;
  final String? imageUrl;
  final String? audioUrl;
  final String modelUrl;
  final double lat;
  final double lng;
  final String geohash;
  final bool isPublic;
  final DateTime createdAt;

  Memory({
    required this.id,
    required this.ownerUid,
    required this.title,
    required this.modelUrl,
    required this.lat,
    required this.lng,
    required this.geohash,
    required this.isPublic,
    required this.createdAt,
    this.text,
    this.imageUrl,
    this.audioUrl,
  });

  factory Memory.fromMap(Map<String, dynamic> data, String id) {
    return Memory(
      id: id,
      ownerUid: data['ownerUid'] as String,
      title: data['title'] as String,
      text: data['text'] as String?,
      imageUrl: data['imageUrl'] as String?,
      audioUrl: data['audioUrl'] as String?,
      modelUrl: data['modelUrl'] as String,
      lat: (data['lat'] as num).toDouble(),
      lng: (data['lng'] as num).toDouble(),
      geohash: data['geohash'] as String,
      isPublic: data['isPublic'] as bool? ?? true,
      createdAt: DateTime.fromMillisecondsSinceEpoch((data['createdAt'] as int?) ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerUid': ownerUid,
      'title': title,
      'text': text,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'modelUrl': modelUrl,
      'lat': lat,
      'lng': lng,
      'geohash': geohash,
      'isPublic': isPublic,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}