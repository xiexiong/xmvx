import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/extension/vx_image_ext.dart';
import 'package:xmvx/helper/vx_color.dart';
import 'package:xmvx/pages/create/vx_create_copywriting_page.dart';
import 'package:xmvx/pages/home/vx_custom_digital_human_page.dart';
import 'package:xmvx/pages/home/vx_module_style_detail_page.dart';
import 'package:xmvx/pages/media/vx_media_home_page.dart';
import 'package:xmvx/pages/my/vx_my_creation_page.dart';
import 'package:xmvx/pages/timbre/vx_timbre_list_page.dart';

/// 首页主页面
class XmvxHomePage extends StatefulWidget {
  const XmvxHomePage({super.key});

  @override
  State<XmvxHomePage> createState() => _XmvxHomePageState();
}

class _XmvxHomePageState extends State<XmvxHomePage> with TickerProviderStateMixin {
  // Tab数据
  final List<String> _templateTabs = ["精选模版", "职场工作", "养生中医", "工厂车间", "饮食安全"];
  int _selectedTemplateTab = 0;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1624),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: VxColor.cF4F5FA,
          appBar: AppBar(
            title: Text(
              "AI数字人",
              style: TextStyle(
                color: VxColor.c1A1A1A,
                fontSize: 36.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            flexibleSpace: Container(decoration: BoxDecoration(gradient: VxColor.cE8F5FF_cE3F0FD)),
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                // 顶部区域
                SliverToBoxAdapter(child: _TopHeader()),
                // 热门模版标题
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32.w, 48.w, 32.w, 0.w),
                    child: Text(
                      "热门模版",
                      style: TextStyle(
                        color: VxColor.c1A1A1A,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // TabBar吸顶
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TemplateTabBarDelegate(
                    child: _TemplateTabBar(
                      tabs: _templateTabs,
                      selected: _selectedTemplateTab,
                      onChanged: (idx) {
                        setState(() {
                          _selectedTemplateTab = idx;
                        });
                      },
                    ),
                  ),
                ),
                // 网格内容
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32.w, 0.w, 32.w, 24.w),
                    child: _TemplateGrid(selectedTab: _selectedTemplateTab),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 顶部区域组件
class _TopHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(gradient: VxColor.cE3F0FD_cF4F5FA),
      padding: EdgeInsets.only(bottom: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => VXMediaHomePage()));
              },
              child: Card(
                elevation: 4.w,
                shadowColor: VxColor.c143C42.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.w)),
                child: Container(
                  height: 240.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: VxColor.cWhite, width: 1.w),
                    gradient: VxColor.cE8F5FF_cWhite,
                    borderRadius: BorderRadius.circular(24.w),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        VxImageExt(assetPath: 'assets/play.png', width: 56.w, height: 56.w),
                        Gap(12.w),
                        Text(
                          "智能成片",
                          style: TextStyle(
                            fontSize: 32.sp,
                            color: VxColor.c1A1A1A,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(12.w),
                        Text(
                          "AI数字人快速生成视频",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: VxColor.c969DA7,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Gap(40.w),
          // 图标菜单区
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VXCustomDigitalHumanPage()),
                    );
                  },
                  child: _MenuIcon(title: "定制数字人", img: "play"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VxTimbreListPage()),
                    );
                  },
                  child: _MenuIcon(title: "克隆音色", img: "play"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VxCreateCopywritingPage()),
                    );
                  },
                  child: _MenuIcon(title: "AI文案创作", img: "play"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VxMyCreationPage()),
                    );
                  },
                  child: _MenuIcon(title: "我的创作", img: "play"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 图标菜单组件
class _MenuIcon extends StatelessWidget {
  final String title;
  final String img;
  const _MenuIcon({required this.title, required this.img});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VxImageExt(assetPath: "assets/$img.png", width: 64.w, height: 64.w),
        Gap(8.w),
        Text(
          title,
          style: TextStyle(fontSize: 24.sp, color: VxColor.c1A1A1A, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

/// TabBar组件（横向滑动，可切换）
class _TemplateTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onChanged;

  const _TemplateTabBar({required this.tabs, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: VxColor.cF4F5FA,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 0, right: 0, top: 24.w),
        itemCount: tabs.length,
        separatorBuilder: (_, __) => Gap(16.w),
        itemBuilder: (context, idx) {
          final isSelected = selected == idx;
          return Padding(
            padding: EdgeInsets.only(
              left: idx == 0 ? 32.w : 0,
              right: idx == tabs.length - 1 ? 32.w : 0.w,
            ),
            child: GestureDetector(
              onTap: () => onChanged(idx),
              child: Container(
                margin: EdgeInsets.fromLTRB(0.w, 0.w, 40.w, 0.w),
                child: Column(
                  children: [
                    Text(
                      tabs[idx],
                      style: TextStyle(
                        color: isSelected ? VxColor.c1A1A1A : VxColor.c51565F,
                        fontSize: 30.sp,
                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                    Gap(2.w),
                    Container(
                      width: 48.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: isSelected ? VxColor.c4F7EFF : VxColor.cF4F5FA,
                        borderRadius: BorderRadius.all(Radius.circular(4.w)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// TabBar吸顶Delegate
class _TemplateTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _TemplateTabBarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 104.w;

  @override
  double get minExtent => 104.w;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

// ...existing code...
/// 模版网格组件
class _TemplateGrid extends StatelessWidget {
  final int selectedTab;
  const _TemplateGrid({required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    // 不同tab展示不同数据
    final List<Map<String, String>> data;
    switch (selectedTab) {
      case 1:
        data = [
          {"img": "play.png", "title": "办公场景 - 郑佳梦"},
          {"img": "play.png", "title": "办公场景 - 孙振华"},
        ];
        break;
      case 2:
        data = [
          {"img": "play.png", "title": "养生中医 - 许昭宇"},
        ];
        break;
      case 3:
        data = [
          {"img": "play.png", "title": "工厂车间 - 李工"},
        ];
        break;
      case 4:
        data = [
          {"img": "play.png", "title": "饮食安全 - 王老师"},
        ];
        break;
      default:
        data = [
          {"img": "play.png", "title": "办公场景 - 郑佳梦"},
          {"img": "play.png", "title": "办公场景 - 孙振华"},
          {"img": "play.png", "title": "瑜伽 - 樊晴川"},
          {"img": "play.png", "title": "工厂车间 - 许昭宇"},
          {"img": "play.png", "title": "办公场景 - 郑佳梦"},
          {"img": "play.png", "title": "办公场景 - 孙振华"},
          {"img": "play.png", "title": "瑜伽 - 樊晴川"},
          {"img": "play.png", "title": "工厂车间 - 许昭宇"},
          {"img": "play.png", "title": "办公场景 - 郑佳梦"},
          {"img": "play.png", "title": "办公场景 - 孙振华"},
          {"img": "play.png", "title": "瑜伽 - 樊晴川"},
          {"img": "play.png", "title": "工厂车间 - 许昭宇"},
        ];
    }

    // 用AspectRatio或Expanded包裹图片，避免高度溢出
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 19.w,
        mainAxisSpacing: 24.w,
        childAspectRatio: 334.w / 520.w, // 调整比例，避免溢出
      ),
      itemBuilder: (context, idx) {
        final item = data[idx];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (contex) => VXModuleStyleDetailPage()),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 334.w / 460.w, // 图片宽高比，保证不会溢出
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                  child: VxImageExt(
                    assetPath: 'assets/${item['img']}',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap(12.w),
              Text(
                item['title'] ?? '',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: VxColor.c1A1A1A,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ...existing code...
