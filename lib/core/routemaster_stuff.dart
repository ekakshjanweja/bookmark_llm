import 'package:bookmark_llm/router.dart';
import 'package:routemaster/routemaster.dart';

class RoutemasterStuff {
  static final routemasterLoggedIn = RoutemasterDelegate(
    routesBuilder: (context) {
      return loggedInRoute;
    },
  );

  static final routemasterLoggedOut = RoutemasterDelegate(
    routesBuilder: (context) {
      return loggedOutRoute;
    },
  );
}
