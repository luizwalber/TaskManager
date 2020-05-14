import 'package:flutter/material.dart';

class UserPreferences {
  final Locale language;
  final int countSize;
  final Color countColor;
  final bool addTaskModal;

  UserPreferences(
      {this.language, this.countSize, this.countColor, this.addTaskModal});

  factory UserPreferences.initial() {
    return UserPreferences(
      language: null,
      countSize: 12,
      countColor: Colors.cyanAccent,
      addTaskModal: true,
    );
  }

  UserPreferences copyWith({
    Locale language,
    int countSize,
    Color countColor,
    bool addTaskModal,
  }) {
    return UserPreferences(
      language: language ?? this.language,
      countSize: countSize ?? this.countSize,
      countColor: countColor ?? this.countColor,
      addTaskModal: addTaskModal ?? this.addTaskModal,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPreferences &&
          language == other.language &&
          countSize == other.countSize &&
          countColor == other.countColor &&
          addTaskModal == other.addTaskModal;

  @override
  int get hashCode =>
      language.hashCode ^
      countSize.hashCode ^
      countColor.hashCode ^
      addTaskModal.hashCode;

  @override
  String toString() {
    return 'UserPreferences{idioma: $language, coutSize: $countSize, countColor: $countColor, addTaskModal: $addTaskModal}';
  }
}
