import 'package:auto_route/auto_route.dart';
import 'package:bookmark_llm/features/auth/pages/login_page.dart';
import 'package:bookmark_llm/features/home/pages/home_page.dart';
part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
      ];
}
