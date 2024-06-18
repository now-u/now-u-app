import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/ui/views/intro/data/intro_page_data.dart';

part 'intro_state.freezed.dart';

@freezed
class IntroState with _$IntroState {
  const factory IntroState({
    required IntroPageData currentPage,
    required bool isLastPage,
    Rect? animationRect,
  }) = _IntroState;
}
