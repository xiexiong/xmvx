import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/extension/vx_appbar_widget.dart';
import 'package:xmvx/extension/vx_image_ext.dart';
import 'package:xmvx/helper/vx_color.dart';
import 'package:xmvx/pages/create/vx_create_copywriting_page.dart';
import 'package:xmvx/pages/home/vx_custom_digital_human_page.dart';
import 'package:xmvx/pages/home/vx_module_style_detail_page.dart';
import 'package:xmvx/pages/timbre/vx_timbre_list_page.dart';

/// 首页主页面
class XmvxHomePage extends StatefulWidget {
  const XmvxHomePage({super.key});

  @override
  State<XmvxHomePage> createState() => _XmvxHomePageState();
}

class _XmvxHomePageState extends State<XmvxHomePage> with TickerProviderStateMixin {
  // Tab数据
  final List<String> _templateTabs = ["推荐模板"];
  int _selectedTemplateTab = 0;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });

    // 获取屏幕高度
    final screenHeight = MediaQuery.of(context).size.height;
    const tripleScreenHeight = 1.0; // 三屏高度倍数

    // 计算是否滑动超过三屏
    if (_scrollOffset >= screenHeight * tripleScreenHeight && !_hasTriggered) {
      setState(() {
        _hasTriggered = true;
      });
    } else if (_scrollOffset <= screenHeight * tripleScreenHeight && _hasTriggered) {
      setState(() {
        _hasTriggered = false;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _hasTriggered = false;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1624),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          appBar: VxAppbarWidget(
            title: "数字人短视频",
            boxDecoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/home_bg_appbar.png', package: 'xmvx'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          body: Stack(
            children: [
              // 固定背景色区域
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 288.w, // 固定高度
                child: VxImageExt(
                  assetPath: 'assets/home_bg_body.png',
                  width: ScreenUtil().screenWidth,
                  height: 288.w,
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    // 顶部区域
                    SliverToBoxAdapter(child: _TopHeader()),
                    // TabBar吸顶
                    SliverPersistentHeader(
                      pinned: false,
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
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _scrollToTop();
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Visibility(
              visible: _hasTriggered,
              child: VxImageExt(assetPath: 'assets/to_top_icon.png', width: 96.w, height: 96.w),
            ),
          ),
        );
      },
    );
  }
}

/// 顶部区域组件
// ignore: must_be_immutable
class _TopHeader extends StatelessWidget {
  List<BannerModel> listBanners = [
    BannerModel(
      id: "1",
      imagePath:
          'https://imgs-qn.51miz.com/Element/00/80/89/67/a82d18da_E808967_77319b42.jpg?imageMogr2/quality/100|imageMogr2/format/webp',
    ),
    BannerModel(
      id: "2",
      imagePath:
          'https://imgs-qn.51miz.com/Element/00/81/10/40/9d80fdbe_E811040_2352fce2.jpg?imageMogr2/quality/100|imageMogr2/format/webp',
    ),
    BannerModel(
      id: "3",
      imagePath:
          'https://imgs-qn.51miz.com/Element/00/81/10/35/0df87cf0_E811035_24ee159c.jpg?imageMogr2/quality/100|imageMogr2/format/webp',
    ),
    BannerModel(
      id: "4",
      imagePath:
          'https://imgs-qn.51miz.com/Element/00/95/65/55/82953bd4_E956555_21743213.jpg?imageMogr2/quality/100|imageMogr2/format/webp',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.only(bottom: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BannerCarousel(
            banners: listBanners,
            customizedIndicators: IndicatorModel.animation(
              width: 8.w,
              height: 8.w,
              spaceBetween: 8.w,
              widthAnimation: 16.w,
            ),
            width: ScreenUtil().screenWidth,
            height: 320.w,
            activeColor: VxColor.cFFFFFF,
            disableColor: VxColor.cFFFFFF.withValues(alpha: 0.4),
            animation: true,
            borderRadius: 16.w,
            indicatorBottom: false,
          ),
          Gap(48.w),
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
                  child: _MenuIcon(title: "图生视频", img: "play"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VxTimbreListPage()),
                    );
                  },
                  child: _MenuIcon(title: "视频生视频", img: "play"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VxCreateCopywritingPage()),
                    );
                  },
                  child: _MenuIcon(title: "我的视频", img: "play"),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => VxMyCreationPage()),
                //     );
                //   },
                //   child: _MenuIcon(title: "我的创作", img: "play"),
                // ),
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
    return Card(
      elevation: 4.0,
      shadowColor: VxColor.c000000.withValues(alpha: 0.04),
      child: Container(
        width: (ScreenUtil().screenWidth - 57) / 3,
        height: 136.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.w),
          gradient: VxColor.cE8F5FF_cffffff,
          border: Border.all(color: VxColor.cFFFFFF, width: 1.w),
        ),
        child: Column(
          children: [
            Gap(16.w),
            VxImageExt(assetPath: "assets/$img.png", width: 64.w, height: 64.w),
            Gap(4.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 24.sp,
                color: VxColor.c1A1A1A,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
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
      color: Colors.transparent,
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
                        fontSize: 32.sp,
                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                    // Gap(2.w),
                    // Container(
                    //   width: 48.w,
                    //   height: 8.w,
                    //   decoration: BoxDecoration(
                    //     // 设置底部选中指示器
                    //     color: isSelected ? VxColor.c4F7EFF : VxColor.cF4F5FA,
                    //     borderRadius: BorderRadius.all(Radius.circular(4.w)),
                    //   ),
                    // ),
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
        ];
    }

    // 用AspectRatio或Expanded包裹图片，避免高度溢出
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 24.w,
        childAspectRatio: 222.w / 360.w, // 调整比例，避免溢出
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
