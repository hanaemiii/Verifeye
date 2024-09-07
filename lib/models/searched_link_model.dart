class SearchedLink {
  final String url;
  String? domainStatus;
  String? googleStatus;
  String? sslStatus;
  String? virustotalStatus;

  SearchedLink({
    required this.url,
    this.domainStatus,
    this.googleStatus,
    this.sslStatus,
    this.virustotalStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'domainStatus': domainStatus,
      'googleStatus': googleStatus,
      'sslStatus': sslStatus,
      'virustotalStatus': virustotalStatus,
    };
  }

  factory SearchedLink.fromMap(Map<String, dynamic> map) {
    return SearchedLink(
      url: (map['url'] ?? '') as String,
      domainStatus: map['domainStatus'] as String?,
      googleStatus: map['googleStatus'] as String?,
      sslStatus: map['sslStatus'] as String?,
      virustotalStatus: map['virustotalStatus'] as String?,
    );
  }
}
