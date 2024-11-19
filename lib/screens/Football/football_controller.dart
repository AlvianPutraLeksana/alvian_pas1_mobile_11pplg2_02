import 'package:get/get.dart';
import 'football_model.dart';

import 'football_service.dart';

class FootballController extends GetxController {
  var isLoading = true.obs;
  var footballList = <FootballModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTeams('bleach');
  }

  void fetchTeams(String query) async {
    try {
      isLoading(true);
      var football = await ApiService().fetchTeams(query);
      footballList.assignAll(football);
    } finally {
      isLoading(false);
    }
  }
}