import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/extension/vx_adaptive_bottom_sheet.dart';
import 'package:xmvx/extension/vx_appbar_widget.dart';
import 'package:xmvx/extension/vx_image_ext.dart';
import 'package:xmvx/helper/vx_color.dart';
import 'package:xmvx/helper/vx_global.dart';
import 'package:xmvx/pages/create/vx_left_right_linkage_page.dart';

class VxCreateCopywritingPage extends StatefulWidget {
  const VxCreateCopywritingPage({super.key});

  @override
  State<VxCreateCopywritingPage> createState() => _VxCreateCopywritingPageState();
}

class _VxCreateCopywritingPageState extends State<VxCreateCopywritingPage> {
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VxColor.cF4F5FA,
      appBar: PreferredSize(preferredSize: Size.fromHeight(kToolbarHeight), child: _appBar()),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 35.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textView("选择产品", VxColor.c1A1A1A, FontWeight.bold),
                Gap(16.w),
                GestureDetector(
                  onTap: () {
                    _showAdaptiveBottomSheet(context, "选择产品", VXLeftRightLinkageWidget());
                  },
                  child: _selectView('请选择产品', VxColor.c969DA7, FontWeight.w400, ""),
                ),
                Gap(40.w),
                _textView("文案关键词", VxColor.c1A1A1A, FontWeight.bold),
                Gap(16.w),
                _inputEditView(),
                Gap(40.w),
                Container(
                  width: ScreenUtil().screenWidth,
                  height: 226.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.w),
                    color: VxColor.cWhite,
                  ),
                  child: Column(
                    children: [
                      Gap(8.w),
                      GestureDetector(
                        onTap: () {},
                        child: _selectView("用途", VxColor.c1A1A1A, FontWeight.bold, "推广文案"),
                      ),
                      Gap(17.w),
                      GestureDetector(
                        onTap: () {},
                        child: _selectView("选择风格", VxColor.c1A1A1A, FontWeight.bold, "通用"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: ScreenUtil().screenWidth,
              height: 170.w,
              color: VxColor.cWhite,
              child: GestureDetector(onTap: () {}, child: _bottomButtonWidget("生成文案")),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textView(String txt, Color color, FontWeight fw) {
    return Text(txt, style: TextStyle(color: color, fontSize: 32.sp, fontWeight: fw));
  }

  Widget _selectView(String txt, Color color, FontWeight fw, String childTxt) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: 96.w,
      decoration: BoxDecoration(color: VxColor.cWhite, borderRadius: BorderRadius.circular(24.w)),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _textView(txt, color, fw),
          Row(
            children: [
              _textView(childTxt, color, FontWeight.w400),
              Gap(8.w),
              VxImageExt(assetPath: 'assets/vx_select.png', width: 40.w),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputEditView() {
    return Container(
      width: ScreenUtil().screenWidth,
      height: 360.w,
      decoration: BoxDecoration(color: VxColor.cWhite, borderRadius: BorderRadius.circular(16.w)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.w, bottom: 98.w),
            child: TextField(
              controller: _editingController,
              maxLines: null,
              style: TextStyle(
                color: VxColor.c1A1A1A,
                fontSize: 32.sp,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                hintText: '请输入关键词',
                hintStyle: TextStyle(color: VxColor.c969DA7),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          Positioned(
            right: 24.w,
            bottom: 24.w,
            child: GestureDetector(
              onTap: () {
                showToast("帮写");
              },
              child: Row(
                children: [
                  VxImageExt(assetPath: 'assets/vx_help.png', width: 32.w),
                  Text(
                    "帮写",
                    style: TextStyle(
                      color: VxColor.c4F7EFF,
                      fontSize: 24.w,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return VxAppbarWidget(
      title: "Ai文案创作",
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 30.w),
          child: GestureDetector(
            onTap: () {
              showToast("点击了创作记录");
            },
            child: Text(
              "创作记录",
              style: TextStyle(
                color: VxColor.c51565F,
                fontSize: 34.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAdaptiveBottomSheet(BuildContext context, String txt, Widget contentBody) {
    VXAdaptiveBottomSheet.show(
      context: context,
      showDragHandle: false,
      backgroundColor: VxColor.cWhite,
      bottomTxt: "确认",
      left: Text(""),
      center: _textView(txt, VxColor.c1A1A1A, FontWeight.bold),
      right: IconButton(
        icon: Icon(Icons.close, weight: 48.w),
        onPressed: () => Navigator.pop(context),
      ),
      child: contentBody,
      maxHeight: 1208.w,
    );
  }

  Widget _bottomButtonWidget(String txt) {
    return Container(
      margin: EdgeInsets.only(top: 16.w, left: 30.w, right: 30.w, bottom: 58.w),
      decoration: BoxDecoration(color: VxColor.c4F7EFF, borderRadius: BorderRadius.circular(24.w)),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(color: VxColor.cWhite, fontSize: 34.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
