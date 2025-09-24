import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:xmvx/helper/vx_platform.dart';
import 'package:xmvx/pages/xmvx_home_page.dart';
import 'package:xmvx/xmvx.dart';
import 'package:xmvx_example/loading.dart';

void main() async {
  await Xmvx.init(
    loading: XLoading(),
    showToast: (content, {animationTime, stackTrace}) {
      showToast(content, animationTime: animationTime, stackTrace: stackTrace);
    },
  );
  Xmvx.config(
    params: {
      "openToken": "11212sds",
      "appKey": "GAB3gEpJZNJB6__-mnMtUt==",
      "serviceId": "sasad2q323wsddsdsdsddssdsddsds",
    },
  );
  runApp(VXApp());
}

showToast(String? content, {int? animationTime, Object? stackTrace}) {
  content = content ?? '';
  if (content.isEmpty) return;
  BotToast.showText(
    text: content,
    align: Alignment.center,
    duration: Duration(seconds: animationTime ?? 2),
  );
}

class VXApp extends StatefulWidget {
  const VXApp({super.key});

  @override
  State<VXApp> createState() => _CsAppState();
}

class _CsAppState extends State<VXApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {}

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CN'), // 中文
        const Locale('en', 'US'), // 英文
      ],
      locale: const Locale('zh', 'CN'), // 默认语言设置为中文
      builder: EasyLoading.init(
        builder: (context, child) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent, // 关键属性，允许穿透点击‌
            onTap: () {
              // 关闭所有焦点键盘
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(VXPlatformTool.isDesktop() ? 0.95 : 1)),
              child: BotToastInit()(context, child),
            ),
          );
        },
        // 这里设置了全局字体固定大小，不随系统设置变更
      ),
      home: GestureDetector(
        behavior: HitTestBehavior.translucent, // 关键属性，允许穿透点击‌
        onTap: () {
          // 关闭所有焦点键盘
          FocusManager.instance.primaryFocus?.unfocus();
        },
        // child: HomePage(),
        child: XmvxHomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: const Text('进入聊天室'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Xmvx.csChatRoomPage;
                  },
                ),
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
