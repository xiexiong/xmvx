import 'package:xmcp_base/comm/router.dart';
import 'package:xmcp_base/xmcp_base.dart';
import 'package:xmvx/pages/xmvx_home_page.dart';

const String grpVxHome = '/vxhome';

registVxRouters() {
  XRouter.instance.registRouters([
    GoRoute(path: grpVxHome, builder: (context, state) => XmvxHomePage()),
  ]);
}
