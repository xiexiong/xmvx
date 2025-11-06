// ...existing code...
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/helper/vx_color.dart';

class VxMyCreationDetailPage extends StatefulWidget {
  final bool isVideo;
  final String imageUrl;
  const VxMyCreationDetailPage({super.key, required this.imageUrl, required this.isVideo});

  @override
  State<VxMyCreationDetailPage> createState() => _VxMyCreationDetailPageState();
}

class _VxMyCreationDetailPageState extends State<VxMyCreationDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VxColor.c1A1A1A,
      body: Stack(
        children: [
          // 背景图占满整个可用区域，支持加载占位和错误占位
          Container(
            margin: EdgeInsets.only(bottom: 156.w),
            child: Positioned.fill(
              child: Image.network(
                widget.imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: VxColor.c1A1A1A,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: VxColor.c1A1A1A,
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 56, color: Colors.white54),
                    ),
                  );
                },
              ),
            ),
          ),

          // 底部操作栏：使用 SafeArea + Align，保证不同机型下的适配
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 24.w),
                child: widget.isVideo ? _buildBottomBarVideo() : _buildBottomBar(),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsetsGeometry.only(left: 24.w, right: 24.w, top: 100.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      weight: 64.w,
                      color: VxColor.cWhite,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showCustomBottomSheet(context);
                    },
                    child: Icon(Icons.more_vert, weight: 64.w, color: VxColor.cWhite),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBarVideo() {
    return SizedBox(
      height: 96.w,
      child: Row(
        children: [
          // 下载按钮
          Expanded(
            child: _vxmcdButton(
              color: VxColor.cWhite.withValues(alpha: 0.08),
              text: "下载",
              onTap: _onDownloadTap,
            ),
          ),
          Gap(18.w),
          // 开直播按钮
          Expanded(child: _vxmcdButton(color: VxColor.c4F7EFF, text: "开直播", onTap: _onGoLiveTap)),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Expanded(child: _vxmcdButton(color: VxColor.c4F7EFF, text: "下载", onTap: _onDownloadTap));
  }

  Widget _vxmcdButton({required Color color, required String text, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 96.w,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(24.w)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: VxColor.cWhite, fontSize: 34.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  // 点击回调示例：根据实际业务替换实现
  void _onDownloadTap() {
    debugPrint('点击：下载');
    // TODO: 添加下载逻辑，例如检查权限、保存到相册/文件等
  }

  void _onGoLiveTap() {
    debugPrint('点击：开直播');
    // TODO: 跳转到直播或发布流程
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
              _buildSheetItem('删除', () => _onItemClick(context, '删除')),
              Divider(height: 8.w, color: VxColor.cEDEDED),
              _buildSheetItem('取消', () => Navigator.pop(context), textColor: VxColor.c51565F),
            ],
          ),
    );
  }

  Widget _buildSheetItem(String title, VoidCallback onTap, {Color textColor = VxColor.c1A1A1A}) {
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
// ...existing code...