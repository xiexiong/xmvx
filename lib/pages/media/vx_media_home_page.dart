import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/extension/vx_bottom_sheet_widget.dart';
import 'package:xmvx/extension/vx_image_ext.dart';
import 'package:xmvx/helper/vx_color.dart';
import 'package:xmvx/pages/create/vx_create_copywriting_page.dart';
import 'package:xmvx/pages/media/vx_template_gallery_widget.dart';

class VXMediaHomePage extends StatefulWidget {
  const VXMediaHomePage({super.key});

  @override
  State<VXMediaHomePage> createState() => _MediaHomePageState();
}

class _MediaHomePageState extends State<VXMediaHomePage> {
  bool _tabIndex = true;
  bool _isShowWindow = false;
  final TextEditingController _inputFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VxColor.c1A1A1A,
      extendBody: true,
      resizeToAvoidBottomInset: true, // 关键属性
      appBar: AppBar(
        backgroundColor: VxColor.c1A1A1A, //设置顶部背景色
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light, //设置图标、事件颜色
        automaticallyImplyLeading: false, //隐藏push返回按钮
        title: _appbarWidget(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 50),
        child: Column(
          children: [
            Gap(19.w),
            Center(
              child: Container(
                width: _isShowWindow ? 271.w : 378.w,
                height: _isShowWindow ? 480.w : 670.w,
                decoration: BoxDecoration(
                  color: VxColor.c232323,
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_play, weight: 36.w, color: VxColor.c969DA7),
                      Gap(8.w),
                      Text(
                        "请选择视频",
                        style: TextStyle(
                          color: VxColor.c969DA7,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Gap(48.w),
            Container(
              width: ScreenUtil().screenWidth,
              height: 492.w,
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              decoration: BoxDecoration(
                color: VxColor.c232323,
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(24.w),
                      Container(
                        height: 362.w,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: TextField(
                          controller: _inputFieldController,
                          maxLines: null,
                          style: TextStyle(
                            color: VxColor.cWhite,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            isCollapsed: true, // 关键属性：高度包裹内容
                            hintText: "请输入文案...",
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(30.w),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => VxCreateCopywritingPage()),
                            );
                          },
                          child: _inputButtonIconWidget(164.w, 'assets/play.png', '生成文案'),
                        ),
                        Gap(16.w),
                        GestureDetector(
                          onTap: () {},
                          child: _inputButtonIconWidget(116.w, 'assets/play.png', '录音'),
                        ),
                        Gap(72.w),
                        GestureDetector(
                          onTap: () {},
                          child: _inputButtonIconWidget(138.w, 'assets/play.png', 'AI润色'),
                        ),
                        Gap(16.w),
                        GestureDetector(
                          onTap: () {},
                          child: _inputButtonIconWidget(116.w, 'assets/play.png', '试听'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(40.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isShowWindow = true;
                    });
                    _showBottomSheet(context, '选择数字人');
                  },
                  child: _buttonIconWidget('assets/play.png', "数字人"),
                ),
                GestureDetector(onTap: () {}, child: _buttonIconWidget('assets/play.png', "配音")),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isShowWindow = true;
                    });
                  },
                  child: _buttonIconWidget('assets/play.png', "背景"),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isShowWindow = false;
                    });
                  },
                  child: _buttonIconWidget('assets/play.png', "音乐"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, tTtitle) {
    VxBottomSheetWidget.show(
      context: context,
      title: tTtitle,
      height: 896.w,
      content: _bottomWindowContent(),
      onConfirm: () {
        setState(() {
          _isShowWindow = false;
        });
      },
      onDismiss: () {
        setState(() {
          _isShowWindow = false;
        });
      },
    );
  }

  Widget _bottomWindowContent() {
    // 导航标签数据
    final List<String> categoriesList = [
      "我的创建",
      "精选模版",
      "职场工作",
      "养生中医",
      "工厂车间",
      "教育培训",
      "餐饮美食",
      "旅游出行",
    ];
    // 模板数据
    final List<Map<String, String>> templatesList = [
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
      {
        "imageUrl":
            "https://fastly.picsum.photos/id/65/400/500.jpg?hmac=je1YWkhEagBbwEf-xh6Szgw_Safog_buVKdOjw8sKtc",
        "title": "办公场景 - 郑佳梦",
      },
    ];
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.46,
      child: VXTemplateGallery(categories: categoriesList, templates: templatesList),
    );
  }

  Widget _buttonIconWidget(iImg, iTxt) {
    return SizedBox(
      width: 160.w,
      child: Column(
        children: [
          VxImageExt(assetPath: iImg, width: 64.w, height: 64.w),
          Gap(12.w),
          Text(iTxt, style: TextStyle(color: VxColor.cWhite, fontSize: 24.w)),
        ],
      ),
    );
  }

  Widget _inputButtonIconWidget(iWidth, iImg, iTxt) {
    return Container(
      width: iWidth,
      height: 52.w,
      decoration: BoxDecoration(
        color: VxColor.cWhite.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Row(
        children: [
          Gap(14.w),
          VxImageExt(assetPath: iImg, width: 30.w, height: 30.w),
          Gap(7.w),
          Text(iTxt, style: TextStyle(color: VxColor.cWhite, fontSize: 24.sp)),
        ],
      ),
    );
  }

  Widget _appbarWidget() {
    return SizedBox(
      width: ScreenUtil().screenWidth,
      height: 98.w,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              width: 128.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VxImageExt(
                    assetPath: 'assets/vx_back_icon.png',
                    width: 48.w,
                    height: 48.w,
                    color: VxColor.cWhite,
                  ),
                ],
              ),
            ),
          ),
          Gap(45.w),
          Expanded(
            flex: 1,
            child: Container(
              width: 336.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: VxColor.cWhite.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(32.w),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _tabIndex = true;
                      });
                    },
                    child: Container(
                      width: 168.w,
                      height: 64.w,
                      decoration: BoxDecoration(
                        color: _tabIndex ? VxColor.c51565F : Colors.transparent,
                        borderRadius: BorderRadius.circular(32.w),
                      ),
                      child: Center(
                        child: Text(
                          "视频数字人",
                          style: TextStyle(
                            color: _tabIndex ? VxColor.cWhite : VxColor.c969DA7,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _tabIndex = false;
                      });
                    },
                    child: Container(
                      width: 168.w,
                      height: 64.w,
                      decoration: BoxDecoration(
                        color: _tabIndex ? Colors.transparent : VxColor.c51565F,
                        borderRadius: BorderRadius.circular(32.w),
                      ),
                      child: Center(
                        child: Text(
                          "图片数字人",
                          style: TextStyle(
                            color: _tabIndex ? VxColor.c969DA7 : VxColor.cWhite,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(45.w),
          Container(
            width: 128.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: VxColor.c4F7EFF,
              borderRadius: BorderRadius.circular(32.w),
            ),
            child: Center(
              child: Text(
                "合成",
                style: TextStyle(
                  fontSize: 32.sp,
                  color: VxColor.cWhite,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
