import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/helper/vx_color.dart';

class VXTabBarGridViewPage extends StatefulWidget {
  final bool? isShowTitle;
  const VXTabBarGridViewPage({super.key, required this.isShowTitle});

  @override
  State<VXTabBarGridViewPage> createState() => _VXTabBarGridViewPageState();
}

class _VXTabBarGridViewPageState extends State<VXTabBarGridViewPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isShowTitle = true;
  final List<String> _categories = ['忐忐忑忑', '嗯嗯', '人人人', '忐忐忑忑', '一样一样啊', '啊啊啊啊啊啊', '水水水水啊啊啊'];

  @override
  void initState() {
    super.initState();
    isShowTitle = widget.isShowTitle ?? true;
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
            labelColor: VxColor.cWhite,
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
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 30.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isShowTitle ? 3 : 4,
                        mainAxisSpacing: isShowTitle ? 26.w : 24.w,
                        crossAxisSpacing: isShowTitle ? 15.w : 20.w,
                        childAspectRatio: isShowTitle ? 0.67 : 0.61,
                      ),
                      itemCount: 14,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.network(
                              'https://picsum.photos/300/200?random=$index',
                              fit: BoxFit.cover,
                              width: isShowTitle ? 224.w : 160.w,
                              height: isShowTitle ? 280.w : 254.w,
                            ),
                            Gap(isShowTitle ? 12.w : 0.w),
                            Visibility(
                              visible: isShowTitle,
                              child: Text(
                                '$category Item $index - 郑佳梦',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: VxColor.cWhite,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
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
