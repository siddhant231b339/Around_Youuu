class UserProfile {
  final String uid;
  final String displayName;
  final String? photoUrl;
  final double? lat;
  final double? lng;
  final String? geohash;

  UserProfile({
    required this.uid,
    required this.displayName,
    this.photoUrl,
    this.lat,
    this.lng,
    this.geohash,
  });

  factory UserProfile.fromMap(Map<String, dynamic> data, String uid) {
    return UserProfile(
      uid: uid,
      displayName: data['displayName'] ?? 'Explorer',
      photoUrl: data['photoUrl'],
      lat: (data['lat'] as num?)?.toDouble(),
      lng: (data['lng'] as num?)?.toDouble(),
      geohash: data['geohash'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'photoUrl': photoUrl,
      'lat': lat,
      'lng': lng,
      'geohash': geohash,
    };
  }
}