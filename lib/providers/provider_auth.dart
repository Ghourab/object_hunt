import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:object_hunt/providers/auth.dart';

// final authProvider = ChangeNotifierProvider<Auth>((ref) => Auth());

class ThemesState extends StateNotifier<AsyncValue<String>> {
  ThemesState() : super(AsyncLoading()) {
    initThemeState();
  }

  void initThemeState() async {
    final prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('theme');
    if (theme != null) {
      state = AsyncData(theme);
    } else {
      state = AsyncData("light");
    }
  }

  void setThemeState(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    state = AsyncLoading();
    await prefs.setString('theme', theme);

    state = AsyncData(theme);
  }
}
