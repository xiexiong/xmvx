import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/extension/vx_adaptive_bottom_sheet.dart';
import 'package:xmvx/extension/vx_appbar_widget.dart';
import 'package:xmvx/extension/vx_image_ext.dart';
import 'package:xmvx/helper/vx_color.dart';
import 'package:xmvx/helper/vx_global.dart';
import 'package:xmvx/pages/create/vx_copywriting_record_page.dart';
import 'package:xmvx/pages/create/vx_left_right_linkage_page.dart';
import 'package:xmvx/pages/create/vx_option_grid_view.dart';
import 'package:xmvx/utils/vx_event_bus.dart';

class VxCreateCopywritingPage extends StatefulWidget {
  const VxCreateCopywritingPage({super.key});

  @override
  State<VxCreateCopywritingPage> createState() => _VxCreateCopywritingPageState();
}

class _VxCreateCopywritingPageState extends State<VxCreateCopywritingPage> {
  final TextEditingController _editingController = TextEditingController();
  StreamSubscription? _productNameSubscription;
  String _productName = "";
  String _useName = "";
  String _styleName = "";
  List<Map<String, dynamic>> useList = [
    {"isSelected": true, "title": '推广文案'},
    {"isSelected": false, "title": '商品卖点'},
    {"isSelected": false, "title": '带货文案'},
    {"isSelected": false, "title": '视频脚本'},
    {"isSelected": false, "title": '直播文案'},
    {"isSelected": false, "title": '客户见证'},
    {"isSelected": false, "title": '营销文章'},
  ];
  List<Map<String, dynamic>> styleList = [
    {"isSelected": true, "title": '通用'},
    {"isSelected": false, "title": '学术'},
    {"isSelected": false, "title": '有文采'},
    {"isSelected": false, "title": '更专业'},
    {"isSelected": false, "title": '更幽默'},
    {"isSelected": false, "title": '更口语'},
    {"isSelected": false, "title": '更书面'},
    {"isSelected": false, "title": '更消息'},
    {"isSelected": false, "title": '更啊啊'},
    {"isSelected": false, "title": '更宿舍'},
  ];

  @override
  void initState() {
    super.initState();
    _productNameSubscription = VXGlobal.eventBus.on<ProductNameEvent>().listen((event) {
      setState(() {
        _productName = event.pName;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _productNameSubscription?.cancel();
  }

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
                    _showAdaptiveBottomSheet(
                      context,
                      "选择产品",
                      VXLeftRightLinkageWidget(title: _productName),
                    );
                  },
                  child: _selectView(
                    _productName.isNotEmpty ? _productName : '请选择产品',
                    _productName.isNotEmpty ? VxColor.c1A1A1A : VxColor.c969DA7,
                    FontWeight.w400,
                    "",
                  ),
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
                        onTap: () {
                          _showAdaptiveBottomSheet(
                            context,
                            "选择用途",
                            _optionGridViewBuilder(useList, (val) {
                              setState(() {
                                _useName = val;
                              });
                            }),
                          );
                        },
                        child: _selectView("用途", VxColor.c1A1A1A, FontWeight.bold, _useName),
                      ),
                      Gap(17.w),
                      GestureDetector(
                        onTap: () {
                          _showAdaptiveBottomSheet(
                            context,
                            "选择用途",
                            _optionGridViewBuilder(styleList, (val) {
                              setState(() {
                                _styleName = val;
                              });
                            }),
                          );
                        },
                        child: _selectView("选择风格", VxColor.c1A1A1A, FontWeight.bold, _styleName),
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
    return Text(
      txt,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color, fontSize: 32.sp, fontWeight: fw),
    );
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
          Flexible(child: _textView(txt, color, fw)),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VXCopywritingRecordPage()),
              );
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

Widget _optionGridViewBuilder(List<Map<String, dynamic>> mList, ValueChanged<String> onSelected) {
  return StatefulBuilder(
    builder: (context, setState) {
      String currentType = "";
      return Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 56.w, top: 40.w),
        child: OptionGridView(
          itemCount: mList.length,
          spacing: 24.w,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  for (var ls in mList) {
                    ls["isSelected"] = false;
                  }
                  mList[index]["isSelected"] = true;
                  currentType = mList[index]["title"];
                });
                onSelected(currentType);
              },
              child: Container(
                height: 96.w,
                decoration:
                    mList[index]["isSelected"]
                        ? BoxDecoration(
                          color: VxColor.c4F7EFF.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(24.w),
                          border: Border.all(color: VxColor.c4F7EFF, width: 2.w),
                        )
                        : BoxDecoration(
                          color: VxColor.cF4F5FA,
                          borderRadius: BorderRadius.circular(24.w),
                        ),
                child: Center(
                  child: Text(
                    mList[index]["title"],
                    style: TextStyle(
                      color: mList[index]["isSelected"] ? VxColor.c4F7EFF : VxColor.c1A1A1A,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
