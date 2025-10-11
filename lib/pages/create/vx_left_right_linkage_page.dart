import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/helper/vx_color.dart';

class VXLeftRightLinkageWidget extends StatefulWidget {
  const VXLeftRightLinkageWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VXLeftRightLinkageWidgetState createState() => _VXLeftRightLinkageWidgetState();
}

class _VXLeftRightLinkageWidgetState extends State<VXLeftRightLinkageWidget> {
  // 左侧导航数据
  final List<String> _navTitles = [
    "御坊堂",
    "东方素养",
    "生命健",
    "泽谷",
    "露嘉堡",
    "帝凡",
    "流星泉",
    "思莉姿",
    "泽颜",
    "美塑臻",
    "氧悦",
  ];

  // 右侧内容数据 - 模拟不同分类对应的产品
  final Map<String, List<Map<String, String>>> _contentData = {
    "御坊堂": [
      {"name": "海狗丸", "image": "assets/products/haigouwan.png"},
      {"name": "御坊堂肽参牡蛎饮御坊堂肽参牡蛎饮", "image": "assets/products/taicanshengmuli.png"},
    ],
    "东方素养": [
      {"name": "一参元气饮", "image": "assets/products/yuanshenqi.png"},
    ],
    "生命健": [
      {"name": "八珍萃妍饮", "image": "assets/products/bazhen.png"},
      {"name": "双萃酵素饮", "image": "assets/products/shuangcui.png"},
    ],
    "泽谷": [
      {"name": "肉苁蓉淫羊藿山茱萸", "image": "assets/products/roucongrong.png"},
    ],
    "露嘉堡": [],
    "帝凡": [],
    "流星泉": [],
    "思莉姿": [],
    "泽颜": [],
    "美塑臻": [
      {"name": "海狗丸胶囊", "image": "assets/products/haigouwanjiaonang.png"},
    ],
    "氧悦": [
      {"name": "角鲨烯", "image": "assets/products/jiaoshaxi.png"},
    ],
  };

  // 当前选中的导航项索引
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VxColor.cWhite,
      body: Row(
        children: [
          // 左侧导航
          Expanded(
            flex: 2,
            child: Container(
              color: VxColor.cF4F5FA,
              child: ListView.builder(
                itemCount: _navTitles.length,
                itemBuilder: (context, index) => _buildNavItem(index),
              ),
            ),
          ),

          // 右侧内容
          Expanded(flex: 5, child: _buildContent()),
        ],
      ),
    );
  }

  // 构建导航项
  Widget _buildNavItem(int index) {
    final String title = _navTitles[index];
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 16.w),
        color: isSelected ? Colors.white : VxColor.cF4F5FA,
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? VxColor.c4F7EFF : VxColor.c51565F,
            fontWeight: FontWeight.w500,
            fontSize: 28.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // 构建右侧内容区域
  Widget _buildContent() {
    final String selectedNav = _navTitles[_selectedIndex];
    final List<Map<String, String>> products = _contentData[selectedNav] ?? [];

    if (products.isEmpty) {
      return Center(
        child: Text("暂无$selectedNav分类产品", style: TextStyle(color: Colors.grey, fontSize: 16)),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductItem(product);
      },
    );
  }

  // 构建产品项
  Widget _buildProductItem(Map<String, String> product) {
    return Container(
      height: 112.w,
      margin: EdgeInsets.only(bottom: 16.w, right: 30.w, left: 24.w),
      decoration: BoxDecoration(color: VxColor.cF4F5FA, borderRadius: BorderRadius.circular(16.w)),
      child: Row(
        children: [
          // 产品图片
          Container(
            width: 112.w,
            height: 112.w,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
              image:
                  product["image"] != null
                      ? DecorationImage(image: AssetImage(product["image"]!), fit: BoxFit.cover)
                      : null,
            ),
            child:
                product["image"] == null
                    ? Icon(Icons.image_not_supported, color: Colors.grey)
                    : null,
          ),

          Gap(24.w),

          // 产品名称
          Expanded(
            child: Text(
              product["name"] ?? "未知产品",
              style: TextStyle(fontSize: 28.sp, color: VxColor.c1A1A1A),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
