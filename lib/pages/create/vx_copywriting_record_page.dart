import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/extension/vx_appbar_widget.dart';
import 'package:xmvx/helper/vx_color.dart';

class VXCopywritingRecordPage extends StatefulWidget {
  const VXCopywritingRecordPage({super.key});

  @override
  State<VXCopywritingRecordPage> createState() => _VXCopywritingRecordPageState();
}

class _VXCopywritingRecordPageState extends State<VXCopywritingRecordPage> {
  List<Map<String, String>> mapList = [
    {
      "title": "海狗丸推广文案",
      "time": "2025-10-13 15:43",
      "txtStyle": "通用风格",
      "content":
          "熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！",
    },
    {
      "title": "海狗丸推广文案",
      "time": "2025-10-13 15:43",
      "txtStyle": "通用风格",
      "content":
          "熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！",
    },
    {
      "title": "海狗丸推广文案",
      "time": "2025-10-13 15:43",
      "txtStyle": "通用风格",
      "content":
          "熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！",
    },
    {
      "title": "海狗丸推广文案",
      "time": "2025-10-13 15:43",
      "txtStyle": "通用风格",
      "content":
          "熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！",
    },
    {
      "title": "海狗丸推广文案",
      "time": "2025-10-13 15:43",
      "txtStyle": "通用风格",
      "content":
          "熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！",
    },
    {
      "title": "海狗丸推广文案",
      "time": "2025-10-13 15:43",
      "txtStyle": "通用风格",
      "content":
          "熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！熬夜加班、带娃崩溃、追剧上头…感觉身体被掏空？别慌！御坊堂一参元气饮来探救你的元气值！",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VxColor.cF4F5FA,
      appBar: VxAppbarWidget(title: "创作记录", backgroundColor: VxColor.cF4F5FA),
      body: ListView.builder(
        itemCount: mapList.length,
        itemBuilder: (context, index) => _ListItemContent(index, mapList),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _ListItemContent(int index, List<Map<String, String>> mapList) {
    Map<String, String> map = mapList[index];
    return Container(
      width: ScreenUtil().screenWidth,
      height: 378.w,
      margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 4.w, bottom: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24.w)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${map["title"]}",
                style: TextStyle(
                  color: VxColor.c1A1A1A,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.more_horiz, weight: 48.w, color: VxColor.c1A1A1A),
            ],
          ),
          Gap(16.w),
          _txtView("${map["content"]}"),
          Gap(24.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_txtView("${map["time"]}"), _txtView("${map["txtStyle"]}")],
          ),
        ],
      ),
    );
  }

  Widget _txtView(String txt) {
    return Text(
      txt,
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: VxColor.c51565F, fontSize: 28.sp, fontWeight: FontWeight.w500),
    );
  }
}
