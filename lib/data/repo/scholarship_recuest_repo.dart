import '../../utils/secure_storage.dart';
import '../api/scholarship_request.dart';
import '../models/scholarship_request .dart';

class ScholarshipRequestRepo{
  ScholarshipRequestApi api;
  ScholarshipRequestRepo({required this.api});
  Future<List<ScholarshipRequest>> myApplications() async {
    print("Repo: Fetching my Applications...");
    final token = await SecureStorage.getToken();
    final response = await api.myApplications(token: token);
    final dynamic data = response;
    if (data is! List) {
      print("Error: data is not a list, it's ${data.runtimeType}");
      return [];
    }
    final List<ScholarshipRequest> scholarshipRequests = (data as List<dynamic>)
        .map<ScholarshipRequest>((dynamic item) {
      try {
        return ScholarshipRequest.fromMap(item as Map<String, dynamic>);
      } catch (e) {
        print("Error parsing item: $e");
        print("Problematic item: $item");
        return ScholarshipRequest.fromMap({});
      }
    })
        .toList();

    return scholarshipRequests;
  }
}