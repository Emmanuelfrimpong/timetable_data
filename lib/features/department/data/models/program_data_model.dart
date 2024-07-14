import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgramsDataModel {
  String? id;
  String? name;
  String? department;
  String? studyMode;
  String? departmentId;
  String? semester;
  String? year;
  int createdAt;
  ProgramsDataModel({
    this.id,
    this.name,
    this.department,
    this.studyMode,
    this.departmentId,
    this.semester,
    this.year,
    required this.createdAt,
  });

  ProgramsDataModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? name,
    ValueGetter<String?>? department,
    ValueGetter<String?>? studyMode,
    ValueGetter<String?>? departmentId,
    ValueGetter<String?>? semester,
    ValueGetter<String?>? year,
    int? createdAt,
  }) {
    return ProgramsDataModel(
      id: id != null ? id() : this.id,
      name: name != null ? name() : this.name,
      department: department != null ? department() : this.department,
      studyMode: studyMode != null ? studyMode() : this.studyMode,
      departmentId: departmentId != null ? departmentId() : this.departmentId,
      semester: semester != null ? semester() : this.semester,
      year: year != null ? year() : this.year,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'studyMode': studyMode,
      'departmentId': departmentId,
      'semester': semester,
      'year': year,
      'createdAt': createdAt,
    };
  }

  factory ProgramsDataModel.fromMap(Map<String, dynamic> map) {
    return ProgramsDataModel(
      id: map['id'],
      name: map['name'],
      department: map['department'],
      studyMode: map['studyMode'],
      departmentId: map['departmentId'],
      semester: map['semester'],
      year: map['year'],
      createdAt: map['createdAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProgramsDataModel.fromJson(String source) =>
      ProgramsDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProgramsDataModel(id: $id, name: $name, department: $department, studyMode: $studyMode, departmentId: $departmentId, semester: $semester, year: $year, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProgramsDataModel &&
      other.id == id &&
      other.name == name &&
      other.department == department &&
      other.studyMode == studyMode &&
      other.departmentId == departmentId &&
      other.semester == semester &&
      other.year == year &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      department.hashCode ^
      studyMode.hashCode ^
      departmentId.hashCode ^
      semester.hashCode ^
      year.hashCode ^
      createdAt.hashCode;
  }
}
