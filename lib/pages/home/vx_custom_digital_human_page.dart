import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/extension/vx_adaptive_bottom_sheet.dart';
import 'package:xmvx/extension/vx_appbar_widget.dart';
import 'package:xmvx/extension/vx_image_ext.dart';
import 'package:xmvx/helper/vx_color.dart';

class VXCustomDigitalHumanPage extends StatefulWidget {
  const VXCustomDigitalHumanPage({super.key});

  @override
  State<VXCustomDigitalHumanPage> createState() => _VXCustomDigitalHumanPageState();
}

class _VXCustomDigitalHumanPageState extends State<VXCustomDigitalHumanPage> {
  List<String> items = ['女', '童真', '纯净'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VxAppbarWidget(
        title: "定制数字人",
        boxDecoration: BoxDecoration(gradient: VxColor.cE8F5FF_cE3F0FD),
      ),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(gradient: VxColor.cE3F0FD_cF4F5FA),
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(35.w),
            _textView("1. 上传形象 *", VxColor.c1A1A1A, 32.sp, FontWeight.bold),
            Gap(16.w),
            GestureDetector(
              onTap: () {
                _showAdaptiveBottomSheet(context, "拍摄教程", _shootingTutorial(), false);
              },
              child: _contentUploadVideo(),
            ),
            Gap(40.w),
            _textView("2. 选择声色 *", VxColor.c1A1A1A, 32.sp, FontWeight.bold),
            Gap(16.w),
            GestureDetector(
              onTap: () {
                _showAdaptiveBottomSheet(context, "选择音色", _TabListViewWidget(false), true);
              },
              child: _optionTimbre(),
            ),
            Gap(278.w),
            _submitButtom(),
          ],
        ),
      ),
    );
  }

  Widget _textView(String txt, Color txtColor, txtSize, FontWeight fw) {
    return Text(
      txt,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: txtColor, fontSize: txtSize, fontWeight: fw),
    );
  }

  Widget _contentUploadVideo() {
    return Container(
      height: 670.w,
      decoration: BoxDecoration(
        color: VxColor.cWhite,
        borderRadius: BorderRadius.circular(24.w),
        border: Border.all(width: 1.w, color: VxColor.cEDEDED),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, weight: 64.w, color: VxColor.c969DA7),
            Gap(11.w),
            _textView("上传训练视频", VxColor.c969DA7, 32.sp, FontWeight.w400),
          ],
        ),
      ),
    );
  }

  Widget _optionTimbre() {
    return Container(
      height: 112.w,
      padding: EdgeInsets.only(left: 24.w, right: 22.w),
      decoration: BoxDecoration(color: VxColor.cWhite, borderRadius: BorderRadius.circular(24.w)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _textView("请选择该形象的音色", VxColor.c969DA7, 32.sp, FontWeight.w400),
          VxImageExt(assetPath: "assets/vx_select.png"),
        ],
      ),
    );
  }

  Widget _submitButtom() {
    return Container(
      height: 96.w,
      decoration: BoxDecoration(color: VxColor.c4F7EFF, borderRadius: BorderRadius.circular(24.w)),
      child: Center(child: _textView("开始制作", VxColor.cWhite, 32.sp, FontWeight.bold)),
    );
  }

  void _showAdaptiveBottomSheet(
    BuildContext context,
    String txt,
    Widget contentBody,
    bool isShowRight,
  ) {
    VXAdaptiveBottomSheet.show(
      context: context,
      showDragHandle: false,
      backgroundColor: VxColor.cWhite,
      isShowButtom: false,
      left: Text(""),
      center: _textView(txt, VxColor.c1A1A1A, 32.sp, FontWeight.bold),
      right: Visibility(
        visible: isShowRight,
        child: IconButton(
          icon: Icon(Icons.close, weight: 48.w),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: contentBody,
      maxHeight: 1280.w,
    );
  }

  Widget _shootingTutorial() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(40.w),
            Row(
              children: [
                _textView("只需要上传 ", VxColor.c51565F, 28.sp, FontWeight.w500),
                _textView("5s - 10s", VxColor.c15D179, 28.sp, FontWeight.w500),
                _textView(" 的视频，即可训练定制形象", VxColor.c51565F, 28.sp, FontWeight.w500),
              ],
            ),
            Gap(40.w),
            _textView("正确示例", VxColor.c1A1A1A, 32.sp, FontWeight.bold),
            Gap(16.w),
            Row(
              children: [
                Container(width: 222.w, height: 296.w, color: Colors.amber),
                Gap(24.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20.w),
                    _shootingTutorialItem("表情放松，手势和身体自然微动"),
                    Gap(32.w),
                    _shootingTutorialItem("没有遮挡住嘴巴"),
                    Gap(32.w),
                    _shootingTutorialItem("没有拍侧脸"),
                    Gap(32.w),
                    _shootingTutorialItem("保持人物一直在画面中"),
                  ],
                ),
              ],
            ),
            Gap(40.w),
            _textView("错误示例", VxColor.c1A1A1A, 32.sp, FontWeight.bold),
            Gap(16.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shootingTutorialError("遮挡嘴巴"),
                _shootingTutorialError("人脸出框"),
                _shootingTutorialError("侧脸拍摄"),
                _shootingTutorialError("多人出境"),
              ],
            ),
            Gap(56.w),
            Row(
              children: [
                Expanded(flex: 1, child: _shootingTutorialButtom(false)),
                Gap(18.w),
                Expanded(flex: 1, child: _shootingTutorialButtom(true)),
              ],
            ),
            Gap(58.w),
          ],
        ),
      ),
    );
  }

  Widget _shootingTutorialButtom(bool isShoot) {
    return Container(
      height: 96.w,
      decoration: BoxDecoration(
        color: isShoot ? VxColor.c4F7EFF : VxColor.cF4F5FA,
        borderRadius: BorderRadius.circular(24.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isShoot ? Icons.camera_alt_outlined : Icons.photo_outlined,
            weight: 40.w,
            color: isShoot ? VxColor.cWhite : VxColor.c1A1A1A,
          ),
          Gap(8.w),
          _textView(
            isShoot ? "直接拍摄" : "上传视频",
            isShoot ? VxColor.cWhite : VxColor.c1A1A1A,
            34.sp,
            FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _shootingTutorialError(String txt) {
    return Column(
      children: [
        Container(width: 140.w, height: 140.w, color: Colors.amber),
        Gap(8.w),
        _textView(txt, VxColor.c1A1A1A, 24.sp, FontWeight.w400),
      ],
    );
  }

  Widget _shootingTutorialItem(String txt) {
    return Row(
      children: [
        Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            color: VxColor.c15D179,
            borderRadius: BorderRadius.circular(50.w),
          ),
        ),
        Gap(13.w),
        _textView(txt, VxColor.c1A1A1A, 26.w, FontWeight.bold),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _TabListViewWidget(bool isShowTitle) {
    return SizedBox(
      width: ScreenUtil().screenWidth,
      height: 1028.w,
      child: ListView.builder(
        itemCount: 12,
        itemBuilder:
            (context, index) => Column(
              children: [
                Container(
                  width: ScreenUtil().screenWidth,
                  height: 190.w,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              VxImageExt(assetPath: "assets/play.png", width: 40.w),
                              Gap(16.w),
                              Text(
                                ' Item $index - 郑佳梦',
                                style: TextStyle(
                                  color: VxColor.c1A1A1A,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Gap(8.w),
                          Padding(
                            padding: EdgeInsets.only(left: 40.w),
                            child: Row(
                              children:
                                  items
                                      .map(
                                        (item) => Container(
                                          height: 38.w,
                                          decoration: BoxDecoration(
                                            color: VxColor.cF4F5FA,
                                            borderRadius: BorderRadius.circular(24.w),
                                          ),
                                          margin: EdgeInsets.only(left: 8.w),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2.w,
                                            horizontal: 16.w,
                                          ),
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              color: VxColor.c969DA7,
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ],
                      ),
                      VxImageExt(assetPath: "assets/play.png", width: 40.w),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 114.w),
                  child: Divider(height: 1.w, color: VxColor.cEDEDED),
                ),
              ],
            ),
      ),
    );
  }
}
