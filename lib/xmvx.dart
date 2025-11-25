import 'package:flutter/material.dart';
import 'package:xmvx/helper/vx_appinfo.dart';
import 'package:xmvx/helper/vx_global.dart';
import 'package:xmvx/helper/vx_user_manager.dart';
import 'package:xmvx/pages/xmvx_home_page.dart';

class Xmvx {
  static Future<void> init({
    required Function(String?, {int? animationTime, Object? stackTrace}) showToast,
    required dynamic loading,
  }) async {
    showCsToast = showToast;
    csLoading = loading;
    WidgetsFlutterBinding.ensureInitialized();
    await VXGlobal.init();
    await VXAppInfoManager().init();
  }

  static void config({required Map<String, dynamic> params, Function()? backToNative}) {
    VXUserManager.threeLoginData = params;
    csBackToNative = backToNative;
  }

  static get vxAIVXPage {
    // return BlocProvider(create: (context) => CSChatRoomCubit(), child: CSChatRoomPage());
    return XmvxHomePage();
  }
}
