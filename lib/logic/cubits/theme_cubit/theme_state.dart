import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeLight extends ThemeState {
  const ThemeLight();
}

class ThemeDark extends ThemeState {
  const ThemeDark();
}
