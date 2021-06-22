import 'package:provider/provider.dart';
import 'package:wiki_search/view_models/home_view_model.dart';
import 'package:wiki_search/views/home_view.dart';

class NavigationHelper {
  static getHomeViewWithProvider() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        )
      ],
      child: HomeView(),
    );
  }
}