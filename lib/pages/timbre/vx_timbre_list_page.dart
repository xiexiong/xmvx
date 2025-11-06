import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/extension/vx_adaptive_bottom_sheet.dart';
import 'package:xmvx/extension/vx_appbar_widget.dart';
import 'package:xmvx/extension/vx_image_ext.dart';
import 'package:xmvx/helper/vx_color.dart';
import 'package:xmvx/pages/timbre/widget/vx_record_screen_state.dart';

class VxTimbreListPage extends StatefulWidget {
  const VxTimbreListPage({super.key});

  @override
  State<VxTimbreListPage> createState() => _VxTimbreListPageState();
}

class _VxTimbreListPageState extends State<VxTimbreListPage> {
  List<Map<String, dynamic>> listMap = [
    {
      'isPlay': true,
      'title': '邻家女孩',
      'tag': ['女', '童真', '纯净'],
    },
    {
      'isPlay': false,
      'title': '邻家女孩',
      'tag': ['女', '童真', '纯净'],
    },
    {
      'isPlay': false,
      'title': '邻家女孩',
      'tag': ['女', '童真', '纯净'],
    },
    {
      'isPlay': false,
      'title': '邻家女孩',
      'tag': ['女', '童真', '纯净'],
    },
    {
      'isPlay': false,
      'title': '邻家女孩',
      'tag': ['女', '童真', '纯净'],
    },
    {
      'isPlay': false,
      'title': '邻家女孩',
      'tag': ['女', '童真', '纯净'],
    },
    {
      'isPlay': false,
      'title': '邻家女孩',
      'tag': ['女', '童真', '纯净'],
    },
    {
      'isPlay': false,
      'title': '邻家女孩',
      'tag': ['女', '童真', '纯净'],
    },
    {
      'isPlay': false,
      'title': '邻家女孩',
      'tag': ['女', '童真', '纯净'],
    },
    {
      'isPlay': false,
      'title': '邻家女孩',
      'tag': ['女', '童真', '纯净'],
    },
    {
      'isPlay': false,
      'title': '邻家女孩',
      'tag': ['女', '童真', '纯净'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VxColor.cF4F5FA,
      appBar: VxAppbarWidget(
        title: '克隆音色',
        boxDecoration: BoxDecoration(gradient: VxColor.cE8F5FF_cE3F0FD),
      ),
      body: Stack(
        children: [
          Container(height: 279.w, decoration: BoxDecoration(gradient: VxColor.cE3F0FD_cF4F5FA)),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(top: 19.w, right: 32.w, left: 32.w, bottom: 139.w),
              decoration: BoxDecoration(
                color: VxColor.cWhite,
                borderRadius: BorderRadius.circular(24.w),
              ),
              child: ListView.builder(
                itemCount: listMap.length,
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
                                      listMap[index]['isPlay']
                                          ? VxImageExt(assetPath: "assets/playing.png", width: 40.w)
                                          : VxImageExt(
                                            assetPath: "assets/playicon.png",
                                            width: 40.w,
                                          ),
                                      Gap(16.w),
                                      Text(
                                        listMap[index]['title'],
                                        style: TextStyle(
                                          color:
                                              listMap[index]['isPlay']
                                                  ? VxColor.c4F7EFF
                                                  : VxColor.c1A1A1A,
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
                                          (listMap[index]['tag'] as List)
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
                              VxImageExt(assetPath: "assets/menu.png", width: 40.w),
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
            ),
          ),
          Positioned(
            bottom: 19.w,
            left: 32.w,
            right: 32.w,
            child: GestureDetector(
              onTap: () {
                _showAdaptiveBottomSheet(context, _recordingBody());
              },
              child: Container(
                width: ScreenUtil().screenWidth,
                height: 96.w,
                decoration: BoxDecoration(
                  color: VxColor.c4F7EFF,
                  borderRadius: BorderRadius.circular(24.w),
                ),
                child: Center(
                  child: Text(
                    "克隆音色",
                    style: TextStyle(
                      color: VxColor.cWhite,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAdaptiveBottomSheet(BuildContext context, Widget contentBody) {
    VXAdaptiveBottomSheet.show(
      context: context,
      showDragHandle: false,
      backgroundColor: VxColor.cWhite,
      isShowButtom: false,
      left: _adaptiveBottomSheetLeftWidget(),
      center: Text(""),
      right: IconButton(
        icon: Icon(Icons.close, weight: 48.w),
        onPressed: () => Navigator.pop(context),
      ),
      child: contentBody,
      maxHeight: 1280.w,
    );
  }

  Widget _adaptiveBottomSheetLeftWidget() {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 30.w),
      child: Row(
        children: [
          VxImageExt(assetPath: 'assets/upload.png', width: 48.w, height: 48.w),
          Gap(6.w),
          Text(
            '上传',
            style: TextStyle(color: VxColor.c1A1A1A, fontSize: 30.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _recordingBody() {
    return SizedBox(
      height: 1280.w,
      child: Stack(
        children: [
          Expanded(
            child: Column(
              children: [
                Gap(51.w),
                Text(
                  "请朗读",
                  style: TextStyle(
                    color: VxColor.c1A1A1A,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(180.w),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 50.w),
                  child: Text(
                    "这段时间天气不错，晚上出去散散步，吹吹风，听听音乐，心情好多了，真的是太舒服了！",
                    style: TextStyle(
                      color: VxColor.c1A1A1A,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.w,
            left: 32.w,
            right: 32.w,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VxRecordScreenState()),
                );
              },
              child: Text("data"),
            ),
          ),
        ],
      ),
    );
  }
}
