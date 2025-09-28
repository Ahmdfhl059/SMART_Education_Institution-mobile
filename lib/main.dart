import 'package:SMART/data/api/course_api.dart';
import 'package:SMART/data/api/level_api.dart';
import 'package:SMART/data/api/levels_request_api.dart';
import 'package:SMART/data/api/post_api.dart';
import 'package:SMART/data/api/scholarship_request.dart';
import 'package:SMART/data/api/scholarshpi_api.dart';
import 'package:SMART/data/api/student_api.dart';
import 'package:SMART/data/repo/course_repo.dart';
import 'package:SMART/data/repo/level_repo.dart';
import 'package:SMART/data/repo/level_request_repo.dart';
import 'package:SMART/data/repo/post_repo.dart';
import 'package:SMART/data/repo/scholarship_recuest_repo.dart';
import 'package:SMART/data/repo/scholarship_repo.dart';
import 'package:SMART/data/repo/student_repo.dart';
import 'package:SMART/firebase_options.dart';
import 'package:SMART/logic/auth_cubit/student_cubit.dart';
import 'package:SMART/logic/course_cubit/course_cubit.dart';
import 'package:SMART/logic/level_cubit/level_cubit.dart';
import 'package:SMART/logic/levels_request/levels_requests_cubit.dart';
import 'package:SMART/logic/local_cubit/local_cubit.dart';
import 'package:SMART/logic/local_cubit/local_state.dart';
import 'package:SMART/logic/post_cubit/post_cubit.dart';
import 'package:SMART/logic/scholarship/scholarship_cubit.dart';
import 'package:SMART/logic/scholarship_request_cubit/scholarships_requests_cubit.dart';
import 'package:SMART/logic/theme_cubit/theme_cubit.dart';
import 'package:SMART/logic/theme_cubit/theme_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'shared/localization/app_localization.dart';
import 'view/screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()..getSavedLanguage()),

        BlocProvider(create: (context) => ThemeCubit()..getCurrentThemeEvent()),
        BlocProvider(
          create: (context) =>
              StudentCubit(studentRepo: StudentRepo(StudentApi())),
        ),
        BlocProvider(
          create: (context) => ScholarshipsCubit(
            scholarshipRepo: ScholarshipRepo(ScholarshipApi()),
          ),
        ),
        BlocProvider(
          create: (context) =>
              CoursesCubit(courseRepo: CourseRepo(courseApi: CourseApi())),
        ),
        BlocProvider(
          create: (context) => LevelsRequestsCubit(
            levelRequestRepo: LevelsRequestRepo(api: LevelsRequestApi()),
          ),
        ),
        BlocProvider(
          create: (context) => ScholarshipsRequestsCubit(
            scholarshipRequestRepo: ScholarshipRequestRepo(api: ScholarshipRequestApi()),
          ),
        ),
        BlocProvider(
          create: (context) =>
              LevelCubit(levelRepo: LevelRepo(levelApi: LevelApi())),
        ),
        BlocProvider(
          create: (context) => PostCubit(postRepo: PostRepo(postApi: PostApi())),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is LoadedThemeState) {
            var theme = state.themeData;
            return BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, state) {
                if (state is ChangeLocaleState) {
                  return MaterialApp(
                    locale: state.locale,
                    theme: theme,
                    supportedLocales: [Locale('en'), Locale('ar')],
                    localizationsDelegates: [
                      AppLocalization.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    localeResolutionCallback: (deviceLocale, supportedLocales) {
                      for (var locale in supportedLocales) {
                        if (deviceLocale != null &&
                            deviceLocale.languageCode == locale.languageCode) {
                          return deviceLocale;
                        }
                      }
                      return supportedLocales.last;
                    },
                    debugShowCheckedModeBanner: false,
                    home: SplashScreen(),
                  );
                }
                return SizedBox();
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
