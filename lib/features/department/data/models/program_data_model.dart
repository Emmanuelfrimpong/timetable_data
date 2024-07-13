import 'dart:convert';
import 'package:flutter/widgets.dart';

class ProgramsDataModel {
  String? id;
  String? name;
  String? department;
  String? departmentId;
  int createdAt;
  ProgramsDataModel({
    this.id,
    this.name,
    this.department,
    this.departmentId,
    required this.createdAt,
  });

  ProgramsDataModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? name,
    ValueGetter<String?>? department,
    ValueGetter<String?>? departmentId,
    int? createdAt,
  }) {
    return ProgramsDataModel(
      id: id != null ? id() : this.id,
      name: name != null ? name() : this.name,
      department: department != null ? department() : this.department,
      departmentId: departmentId != null ? departmentId() : this.departmentId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'departmentId': departmentId,
      'createdAt': createdAt,
    };
  }

  factory ProgramsDataModel.fromMap(Map<String, dynamic> map) {
    return ProgramsDataModel(
      id: map['id'],
      name: map['name'],
      department: map['department'],
      departmentId: map['departmentId'],
      createdAt: map['createdAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProgramsDataModel.fromJson(String source) =>
      ProgramsDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProgramsDataModel(id: $id, name: $name, department: $department, departmentId: $departmentId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProgramsDataModel &&
      other.id == id &&
      other.name == name &&
      other.department == department &&
      other.departmentId == departmentId &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      department.hashCode ^
      departmentId.hashCode ^
      createdAt.hashCode;
  }
}
