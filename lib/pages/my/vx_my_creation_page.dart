import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/extension/vx_appbar_widget.dart';
import 'package:xmvx/helper/vx_color.dart';
import 'package:xmvx/pages/my/vx_my_creation_detail_page.dart';
import 'package:xmvx/pages/my/vx_my_creation_drafts_page.dart';

class VxMyCreationPage extends StatefulWidget {
  const VxMyCreationPage({super.key});

  @override
  State<VxMyCreationPage> createState() => _VxMyCreationPageState();
}

class _VxMyCreationPageState extends State<VxMyCreationPage> {
  bool isClick = true;
  List<Map<String, dynamic>> mapList = [
    {
      "status": true,
      "imgUrl":
          "https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_9163ee9a21ff32e0ed69a78c00f6fb30.jpeg",
    },
    {
      "status": false,
      "imgUrl":
          "https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_9163ee9a21ff32e0ed69a78c00f6fb30.jpeg",
    },
    {
      "status": false,
      "imgUrl":
          "https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_9163ee9a21ff32e0ed69a78c00f6fb30.jpeg",
    },
    {
      "status": false,
      "imgUrl":
          "https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_9163ee9a21ff32e0ed69a78c00f6fb30.jpeg",
    },
    {
      "status": false,
      "imgUrl":
          "https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_9163ee9a21ff32e0ed69a78c00f6fb30.jpeg",
    },
    {
      "status": false,
      "imgUrl":
          "https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_9163ee9a21ff32e0ed69a78c00f6fb30.jpeg",
    },
    {
      "status": false,
      "imgUrl":
          "https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_9163ee9a21ff32e0ed69a78c00f6fb30.jpeg",
    },
    {
      "status": false,
      "imgUrl":
          "https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_9163ee9a21ff32e0ed69a78c00f6fb30.jpeg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VxColor.cF4F5FA,
      appBar: VxAppbarWidget(
        title: '我的创作',
        actions: [
          Text(
            "草稿箱",
            style: TextStyle(color: VxColor.c51565F, fontSize: 32.sp, fontWeight: FontWeight.w400),
          ),
          Gap(30.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 1.w, child: Container(color: VxColor.cEDEDED)),
            Gap(20.w),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isClick = true;
                    });
                  },
                  child: Text(
                    "视频数字人",
                    style: TextStyle(
                      color: isClick ? VxColor.c1A1A1A : VxColor.c51565F,
                      fontSize: 32.w,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Gap(40.w),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isClick = false;
                    });
                  },
                  child: Text(
                    "图片数字人",
                    style: TextStyle(
                      color: isClick ? VxColor.c51565F : VxColor.c1A1A1A,
                      fontSize: 32.w,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Gap(20.w),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15.w,
                  crossAxisSpacing: 15.w,
                  childAspectRatio: 224 / 300,
                ),
                itemCount: mapList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          mapList[index]['status']
                              ? Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => VxMyCreationDraftsPage()),
                              )
                              : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => VxMyCreationDetailPage(
                                        imageUrl: mapList[index]["imgUrl"],
                                        isVideo: isClick,
                                      ),
                                ),
                              );
                        },
                        child: Image.network(
                          mapList[index]["imgUrl"],
                          fit: BoxFit.cover,
                          width: 224.w,
                          height: 300.w,
                        ),
                      ),
                      mapList[index]['status']
                          ? Positioned(
                            child: Center(
                              child: Text(
                                "创作中...",
                                style: TextStyle(
                                  color: VxColor.cWhite,
                                  fontSize: 24.w,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                          : Positioned(
                            bottom: 12.w,
                            right: 12.w,
                            child: GestureDetector(
                              onTap: () {
                                _showCustomBottomSheet(context);
                              },
                              child: Icon(Icons.more_vert, color: VxColor.cWhite, weight: 40.w),
                            ),
                          ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.w)),
      ),
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(24.w),
              _buildSheetItem('分享', () => _onItemClick(context, '分享')),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w),
                child: Divider(height: 1.w, color: VxColor.cEDEDED),
              ),
              _buildSheetItem('下载', () => _onItemClick(context, '下载')),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w),
                child: Divider(height: 1.w, color: VxColor.cEDEDED),
              ),
              _buildSheetItem('开直播', () => _onItemClick(context, '开直播')),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w),
                child: Divider(height: isClick ? 1.w : 0.w, color: VxColor.cEDEDED),
              ),
              _buildSheetItem('删除', () => _onItemClick(context, '删除')),
              Divider(height: 8.w, color: VxColor.cEDEDED),
              _buildSheetItem('取消', () => Navigator.pop(context), textColor: VxColor.c51565F),
            ],
          ),
    );
  }

  Widget _buildSheetItem(String title, VoidCallback onTap, {Color textColor = VxColor.c1A1A1A}) {
    if (!isClick && title == '开直播') {
      return Divider(height: 0.w, color: VxColor.cBlack.withValues(alpha: 0));
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.w),
        height: 96.w,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 32.sp, color: textColor, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  void _onItemClick(BuildContext context, String action) {
    Navigator.pop(context);
    // 处理点击事件，例如：
    print('点击了$action');
  }
}
