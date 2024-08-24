import 'package:get_it/get_it.dart';
import 'package:verifeye/core/firebase_services/firebase_auth.dart';
import 'package:verifeye/core/firebase_services/firebase_storage.dart';

final sl = GetIt.instance;

void registerSingletons() {
  sl.registerLazySingleton<AuthService>(() => AuthService());

  // sl.registerLazySingleton<FirestoreDatabaseService>(
  //     () => FirestoreDatabaseService());

  sl.registerLazySingleton<FirebaseStorageService>(
      () => FirebaseStorageService());
}
