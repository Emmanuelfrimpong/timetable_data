import 'dart:convert';

class SettingsData {
  String id;
  String year;
  String semester;
  bool isCurrent;
  SettingsData({
    required this.id,
    required this.year,
    required this.semester,
    required this.isCurrent,
  });

  SettingsData copyWith({
    String? id,
    String? year,
    String? semester,
    bool? isCurrent,
  }) {
    return SettingsData(
      id: id ?? this.id,
      year: year ?? this.year,
      semester: semester ?? this.semester,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'year': year,
      'semester': semester,
      'isCurrent': isCurrent,
    };
  }

  factory SettingsData.fromMap(Map<String, dynamic> map) {
    return SettingsData(
      id: map['id'] ?? '',
      year: map['year'] ?? '',
      semester: map['semester'] ?? '',
      isCurrent: map['isCurrent'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsData.fromJson(String source) => SettingsData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SettingsData(id: $id, year: $year, semester: $semester, isCurrent: $isCurrent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SettingsData &&
      other.id == id &&
      other.year == year &&
      other.semester == semester &&
      other.isCurrent == isCurrent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      year.hashCode ^
      semester.hashCode ^
      isCurrent.hashCode;
  }
}
