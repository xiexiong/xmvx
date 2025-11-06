import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/extension/vx_appbar_widget.dart';
import 'package:xmvx/helper/vx_color.dart';

class VxMyCreationDraftsPage extends StatefulWidget {
  const VxMyCreationDraftsPage({super.key});

  @override
  State<VxMyCreationDraftsPage> createState() => _VxMyCreationDraftsPageState();
}

class _VxMyCreationDraftsPageState extends State<VxMyCreationDraftsPage> {
  bool isClick = true;
  List<Map<String, dynamic>> mapList = [
    {
      "title": "未命名草稿",
      "dateTime": "9/13 11:24",
      "imgUrl":
          "https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_9163ee9a21ff32e0ed69a78c00f6fb30.jpeg",
    },
    {
      "title": "未命名草稿",
      "dateTime": "9/13 11:24",
      "imgUrl":
          "https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_9163ee9a21ff32e0ed69a78c00f6fb30.jpeg",
    },
    {
      "title": "未命名草稿",
      "dateTime": "9/13 11:24",
      "imgUrl":
          "https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_9163ee9a21ff32e0ed69a78c00f6fb30.jpeg",
    },
    {
      "title": "未命名草稿",
      "dateTime": "9/13 11:24",
      "imgUrl":
          "https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_9163ee9a21ff32e0ed69a78c00f6fb30.jpeg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VxColor.cF4F5FA,
      appBar: VxAppbarWidget(title: '草稿箱'),
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
                  childAspectRatio: 224 / 378,
                ),
                itemCount: mapList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Image.network(
                          mapList[index]["imgUrl"],
                          fit: BoxFit.cover,
                          width: 224.w,
                          height: 300.w,
                        ),
                      ),
                      Gap(12.w),
                      Text(
                        mapList[index]['title'],
                        style: TextStyle(
                          color: VxColor.c1A1A1A,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        mapList[index]['dateTime'],
                        style: TextStyle(
                          color: VxColor.c969DA7,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
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
}
