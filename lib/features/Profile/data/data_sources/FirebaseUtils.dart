import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../onboarding/services/sharedpreferencekeys.dart';
import '../../../onboarding/services/sharedpreferences.dart';

class FirebaseUtils {
  // مرجع لمجموعة التاريخ لكل مستخدم
  static CollectionReference getHistoryCollection() {
    return FirebaseFirestore.instance.collection("UserData");
  }

  // دالة لإضافة ID للفيلم للـ array
  static Future<void> addMovieID(int movieId) async {
    final token = LocalStorageServices.getString(LocalStorageKeys.authToken);
    print("Token: $token");

    if (token != null) {
      var userDoc = getHistoryCollection().doc(token);

      // استرجاع الـ array الحالية
      DocumentSnapshot doc = await userDoc.get();
      List<dynamic> moviesID = [];

      if (doc.exists && doc.data() != null) {
        moviesID = List.from(doc['moviesID'] ?? []);
      }

      // إزالة الـ ID لو موجود بالفعل
      moviesID.remove(movieId);

      // إضافة الـ ID الجديد في أول الـ list
      moviesID.insert(0, movieId);

      // تحديث الـ array في Firebase
      await userDoc
          .set(
            {'moviesID': moviesID},
            SetOptions(merge: true), // ➡️ دمج البيانات بدون حذف
          )
          .then((_) => print("✅ Movie ID $movieId added to Firebase"))
          .catchError((error) => print("❌ Failed to add movie ID: $error"));
    } else {
      print("❌ Token is null, cannot save data");
    }
  }

  static Future<List<int>> getMoviesIDs() async {
    final token = LocalStorageServices.getString(LocalStorageKeys.authToken);
    print("Token: $token");

    if (token != null) {
      var userDoc = getHistoryCollection().doc(token);

      try {
        DocumentSnapshot doc = await userDoc.get();

        if (doc.exists && doc.data() != null) {
          List<dynamic> moviesID = List.from(doc['moviesID'] ?? []);
          return moviesID
              .map((id) => id as int)
              .toList(); // تحويل الـ dynamic لـ int
        } else {
          return []; // لو الـ doc مش موجود نرجع ليست فاضية
        }
      } catch (e) {
        print("❌ Failed to fetch movie IDs: $e");
        return []; // في حالة الخطأ نرجع ليست فاضية
      }
    } else {
      print("❌ Token is null, cannot retrieve data");
      return [];
    }
  }

  static Future<void> removeMovieID(int movieId) async {
    final token = LocalStorageServices.getString(LocalStorageKeys.authToken);
    print("Token: $token");

    if (token != null) {
      var userDoc = getHistoryCollection().doc(token);

      DocumentSnapshot doc = await userDoc.get();
      List<dynamic> moviesID = [];

      if (doc.exists && doc.data() != null) {
        moviesID = List.from(doc['moviesID'] ?? []);
      }

      moviesID.remove(movieId);

      await userDoc
          .set(
            {'moviesID': moviesID},
            SetOptions(merge: true),
          )
          .then((_) => print("✅ Movie ID $movieId removed from Firebase"))
          .catchError((error) => print("❌ Failed to remove movie ID: $error"));
    } else {
      print("❌ Token is null, cannot remove data");
    }
  }
}
