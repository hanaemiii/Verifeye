class ImageInfo {
  final String time;

  ImageInfo({
    required this.time,
  });

  factory ImageInfo.fromMap(Map<String, dynamic> map) {
    return ImageInfo(
      time: (map['time'] ?? '') as String,
    );
  }
}
