import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmvx/helper/vx_color.dart';
import 'package:xmvx/helper/vx_network_image.dart';

class VXTemplateGallery extends StatefulWidget {
  final List<String> categories;
  final List<Map<String, String>> templates;
  const VXTemplateGallery({super.key, required this.categories, required this.templates});

  @override
  State<VXTemplateGallery> createState() => _VXTemplateGalleryState();
}

class _VXTemplateGalleryState extends State<VXTemplateGallery> {
  // 当前选中的导航标签索引
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VxColor.c232323,
      body: Column(
        children: [
          // 顶部导航栏
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(widget.categories.length, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            widget.categories[index],
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight:
                                  _selectedCategoryIndex == index
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                              color:
                                  _selectedCategoryIndex == index ? Colors.white : VxColor.c969DA7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // 网格内容区域
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(12.w),
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 2 / 3,
              children: List.generate(widget.templates.length, (index) {
                return _buildTemplateItem(widget.templates[index]);
              }),
            ),
          ),
        ],
      ),
    );
  }

  // 构建网格项
  Widget _buildTemplateItem(Map<String, String> template) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: VXNetworkImage(
              imageUrl: template["imageUrl"]!,
              placeholderName: 'xmvx',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 12.w),
        Text(
          template["title"]!,
          style: TextStyle(fontSize: 24.sp, color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
