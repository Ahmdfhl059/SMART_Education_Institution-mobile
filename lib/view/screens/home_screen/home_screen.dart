import 'package:SMART/data/api/post_api.dart';
import 'package:SMART/data/repo/post_repo.dart';
import 'package:SMART/logic/post_cubit/post_cubit.dart';
import 'package:SMART/shared/components/components.dart';
import 'package:SMART/shared/localization/app_localization.dart';
import 'package:SMART/utils/constants.dart';
import 'package:SMART/view/screens/home_screen/build_carousel.dart';
import 'package:SMART/view/screens/home_screen/build_news_items.dart';
import 'package:SMART/view/screens/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        toolbarHeight: 65,
        backgroundColor: defaultColor,
        title: DefaultText(
          text: 'Home'.tr(context),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: [
          DefaultIconButton(
            onPressed: () {
              navigateTo(context, SettingsScreen());
            },
            icon: Icon(Icons.settings_outlined),
            color: Colors.white,
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 10),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildCarouselSlider(),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: DefaultText(
                text: 'News'.tr(context),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            BlocProvider(
              create: (context) =>
                  PostCubit(postRepo: PostRepo(postApi: PostApi())),
              child: BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  if (state.status == PostStatus.loading) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: CircularProgressIndicator(color: defaultColor),
                      ),
                    );
                  }

                  if (state.status == PostStatus.error) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        state.error.isEmpty
                            ? 'Error loading post'
                            : state.error,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          BuildNewsItems(post: state.posts[index]),
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 5, width: double.infinity),
                      itemCount: state.posts.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
