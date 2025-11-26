import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/extension/vx_image_ext.dart';
import 'package:xmvx/helper/vx_color.dart';

class VXTabBarListViewPage extends StatefulWidget {
  final bool? isShowMusic;
  const VXTabBarListViewPage({super.key, required this.isShowMusic});

  @override
  State<VXTabBarListViewPage> createState() => _VXTabBarGridViewPageState();
}

class _VXTabBarGridViewPageState extends State<VXTabBarListViewPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isShowMusic = true;
  final List<String> _categories = ['忐忐忑忑', '嗯嗯', '人人人', '忐忐忑忑', '一样一样啊', '啊啊啊啊啊啊', '水水水水啊啊啊'];
  List<String> items = ['女', '童真', '纯净'];

  @override
  void initState() {
    super.initState();
    isShowMusic = widget.isShowMusic ?? true;
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VxColor.c232323,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: 1, color: VxColor.c323232),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            dividerColor: Colors.transparent,
            labelColor: VxColor.cFFFFFF,
            unselectedLabelColor: VxColor.c969DA7,
            indicatorColor: Colors.transparent,
            tabs: _categories.map((category) => Tab(text: category, height: 72.w)).toList(),
          ),
          // Tab内容区域
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:
                  _categories.map((category) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 30.w),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              width: ScreenUtil().screenWidth,
                              height: 186.w,
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  isShowMusic
                                      ? Row(
                                        children: [
                                          Image.network(
                                            'https://picsum.photos/300/200?random=$index',
                                            fit: BoxFit.cover,
                                            width: 90.w,
                                            height: 90.w,
                                          ),
                                          Gap(24.w),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '$category Item $index - 郑佳梦',
                                                    style: TextStyle(
                                                      color: VxColor.cFFFFFF,
                                                      fontSize: 32.sp,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  Gap(16.w),
                                                  VxImageExt(
                                                    assetPath: "assets/play.png",
                                                    width: 40.w,
                                                  ),
                                                ],
                                              ),
                                              Gap(8.w),
                                              Text(
                                                '2:03',
                                                style: TextStyle(
                                                  color: VxColor.c969DA7,
                                                  fontSize: 24.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                      : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              VxImageExt(assetPath: "assets/play.png", width: 40.w),
                                              Gap(16.w),
                                              Text(
                                                '$category Item $index - 郑佳梦',
                                                style: TextStyle(
                                                  color: VxColor.cFFFFFF,
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
                                                            color: VxColor.cFFFFFF.withValues(
                                                              alpha: 0.08,
                                                            ),
                                                            borderRadius: BorderRadius.circular(
                                                              24.w,
                                                            ),
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
                              child: Divider(height: 1.w, color: VxColor.c323232),
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
