import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/router.gr.dart';
import 'package:rect_getter/rect_getter.dart';

import '../../../services/storage.dart';
import 'data/intro_page_data.dart';
import 'intro_state.dart';

class IntroBloc extends Cubit<IntroState> {
  StackRouter _appRouter;
  SecureStorageService _storageService;

  IntroBloc({
    required StackRouter appRouter,
    required SecureStorageService storageService,
  })  : _appRouter = appRouter,
        _storageService = storageService,
        super(
          IntroState(
            currentPage: introPages.first,
            isLastPage: false,
          ),
        );

  final Duration _animationDuration = const Duration(milliseconds: 500);
  final Duration _delay = const Duration(milliseconds: 300);

  var skipKey = RectGetter.createGlobalKey();
  var getStartedKey = RectGetter.createGlobalKey();
  final PageController controller = PageController();

  var currentIndex = 0;

  void setIndex(int index) {
    currentIndex = index;
    emit(
      IntroState(
        currentPage: introPages[currentIndex],
        isLastPage: currentIndex == introPages.length - 1,
      ),
    );
  }

  void getStarted(BuildContext context) {
    emit(
      state.copyWith(
        animationRect: RectGetter.getRectFromKey(getStartedKey)!,
      ),
    );
    _nextPage(context);
  }

  void skip(BuildContext context) {
    emit(state.copyWith(animationRect: RectGetter.getRectFromKey(skipKey)!));
    _nextPage(context);
  }

  void _nextPage(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      emit(
        state.copyWith(
          animationRect: state.animationRect!.inflate(
            1.3 * MediaQuery.of(context).size.longestSide,
          ),
        ),
      );
      Future.delayed(_animationDuration + _delay, () => _goToNextPage(context));
    });
  }

  void _goToNextPage(BuildContext context) {
    _storageService.setIntroShown(true);
    _appRouter.push(const LoginRoute());
  }
}
