// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../misc/component.dart';

abstract class BaseController extends ChangeNotifier
    with WidgetsBindingObserver {
  BaseController() {
    _isMounted = true;
    onInitListeners();
  }

  late BuildContext _context;
  BuildContext get context => _context;


  late double _sizeWidth;
  double get sizeWidth => _sizeWidth;
  late double _sizeHeight;
  double get sizeHeight => _sizeHeight;

  late double _scaleWidth;
  double get scaleWidth => _scaleWidth;
  late double _scaleHeight;
  double get scaleHeight => _scaleHeight;
  
  late bool _isTablet;
  bool get isTablet => _isTablet;
  late bool _isDekstop;
  bool get isDekstop => _isDekstop;

  bool _isMounted = false;
  bool get isMounted => _isMounted;

  bool _internetAvailable = true;
  bool get internetAvailable => _internetAvailable;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @protected
  void onInitListeners() {
    // _checkInternetConnection();
  }

  void setContext(BuildContext newContext) {
    _context = newContext;
    _sizeHeight = Component.sizeHeight(context);
    _sizeWidth = Component.sizeWidth(context);
    _scaleWidth = Component.scaleWidth(context);
    _scaleHeight = Component.scaleHeight(context);
    _isTablet = Component.isTablet(context);
    _isDekstop = Component.isDekstop(context);
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @protected
  void refreshUI() {
    if (_isMounted) {
      notifyListeners();
    }
  }

  @protected
  void hideLoading() {
    _isLoading = false;
    refreshUI();
  }

  @protected
  void showLoading() {
    _isLoading = true;
    refreshUI();
  }

  // void _checkInternetConnection() {
  //   // Check if data/wifi is active every init controller
  //   Connectivity().checkConnectivity().then((connection) {
  //     if (connection.contains(ConnectivityResult.none)) {
  //       _internetAvailabilityCycle(false);
  //       hideLoading();
  //     } else {
  //       _internetAvailabilityCycle(true);
  //       refreshUI();
  //     }
  //   });

  //   // Check if data/wifi is active every OS setting change
  //   // eventBus.on<ConnectionEvent>().listen((event) {
  //   //   if (event.isConnected) {
  //   //     _internetAvailabilityCycle(true);
  //   //     refreshUI();
  //   //   } else {
  //   //     _internetAvailabilityCycle(false);
  //   //     hideLoading();
  //   //   }
  //   // });
  // }

  void _internetAvailabilityCycle(bool status) {
    if (status) {
      _internetAvailable = status;
      onInternetDisconnected();
    } else {
      _internetAvailable = status;
      onInternetConnected();
    }
  }

  @protected
  void onInActive() {}

  @protected
  void onPaused() {}

  @protected
  void onResumed() {}

  @protected
  void onInternetConnected() {}

  @protected
  void onInternetDisconnected() {}

  void loadOnStart() {
    _isLoading = true;
  }

  void dismissLoading() {
    _isLoading = false;
    refreshUI();
  }

  // void goToNotificationPage(BuildContext context) {
  //   Navigator.pushNamed(
  //     context,
  //     Pages.notification,
  //   );
  // }

  void delayedRefresh({int duration = 1}) {
    Future.delayed(Duration(seconds: duration), refreshUI);
  }

  // Future<void> disableScreenShot() async {
  //   if (!Utils.isDebug()) await ScreenProtector.preventScreenshotOn();
  // }

  // Future<void> enableScreenShot() async {
  //   if (!Utils.isDebug()) await ScreenProtector.preventScreenshotOff();
  // }
}