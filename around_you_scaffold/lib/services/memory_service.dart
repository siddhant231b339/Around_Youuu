import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import '../models/memory.dart';

class MemoryService {
  final FirebaseFirestore _db;
  MemoryService(this._db);

  static const _collection = 'memories';
  final _geo = GeoFlutterFire();

  Future<void> createMemory(Memory memory) async {
    await _db.collection(_collection).doc(memory.id).set(memory.toMap());
  }

  Stream<List<Memory>> nearbyMemories({
    required double lat,
    required double lng,
    double radiusInKm = 0.2,
    bool onlyPublic = true,
  }) {
    final center = _geo.point(latitude: lat, longitude: lng);
    final collectionRef = _db.collection(_collection);

    final stream = _geo.collection(collectionRef: collectionRef).within(
      center: center,
      radius: radiusInKm,
      field: 'position',
      strictMode: true,
    );

    return stream.map((docs) {
      final filtered = docs.where((d) {
        if (!onlyPublic) return true;
        return (d.data()['isPublic'] as bool? ?? true) == true;
      }).toList();

      return filtered.map((d) => Memory.fromMap(d.data(), d.id)).toList();
    });
  }

  Map<String, dynamic> buildPositionField({required double lat, required double lng}) {
    final point = _geo.point(latitude: lat, longitude: lng);
    return point.data;
  }
}