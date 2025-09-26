import 'package:flutter/material.dart';

class VxTabbarWidget extends StatefulWidget {
  final List<String> tabs;
  final TabController? controller;
  final bool isScrollable;
  final Color indicatorColor;
  final double indicatorWeight;
  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;
  final List<Widget> tabViews;
  final bool showDivider;
  final Axis scrollDirection;
  final Function(int)? onTabChanged;
  final List<dynamic> listData;
  final bool useGridLayout;
  final SliverGridDelegate? gridDelegate;

  // ignore: use_super_parameters
  const VxTabbarWidget({
    Key? key,
    required this.tabs,
    this.controller,
    this.isScrollable = true,
    this.indicatorColor = Colors.blue,
    this.indicatorWeight = 2.0,
    this.labelStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.unselectedLabelStyle = const TextStyle(),
    required this.tabViews,
    this.showDivider = true,
    this.scrollDirection = Axis.horizontal,
    this.onTabChanged,
    required this.listData,
    this.useGridLayout = false,
    this.gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.8,
    ),
  }) : super(key: key);

  @override
  State<VxTabbarWidget> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<VxTabbarWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = widget.controller ?? TabController(length: widget.tabs.length, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      widget.onTabChanged?.call(_tabController.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: widget.isScrollable,
          labelColor: widget.indicatorColor,
          unselectedLabelColor: Colors.grey,
          labelStyle: widget.labelStyle,
          unselectedLabelStyle: widget.unselectedLabelStyle,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: widget.indicatorWeight, color: widget.indicatorColor),
          ),
          tabs: widget.tabs.map((tab) => Tab(text: tab)).toList(),
        ),
        if (widget.showDivider) Divider(height: 1, color: Colors.grey[300]),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children:
                widget.tabViews.isNotEmpty
                    ? widget.tabViews
                    : [
                      _buildDynamicList(),
                      ...List.generate(widget.tabs.length - 1, (index) => Container()),
                    ],
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicList() {
    return widget.useGridLayout
        ? GridView.builder(
          gridDelegate: widget.gridDelegate!,
          itemCount: widget.listData.length,
          itemBuilder: (context, index) {
            return Card(child: Center(child: Text(widget.listData[index].toString())));
          },
        )
        : ListView.builder(
          itemCount: widget.listData.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(widget.listData[index].toString()));
          },
        );
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    if (widget.controller == null) {
      _tabController.dispose();
    }
    super.dispose();
  }
}
