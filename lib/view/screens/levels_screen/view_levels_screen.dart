import 'package:SMART/data/models/course.dart';
import 'package:SMART/logic/level_cubit/level_cubit.dart';
import 'package:SMART/logic/level_cubit/level_state.dart';
import 'package:SMART/shared/components/components.dart';
import 'package:SMART/shared/localization/app_localization.dart';
import 'package:SMART/utils/constants.dart';
import 'package:SMART/view/screens/levels_screen/build_items_levels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewLevelsScreen extends StatefulWidget {
  final Course course;

  const ViewLevelsScreen({super.key, required this.course});

  @override
  State<ViewLevelsScreen> createState() => _ViewLevelsScreenState();
}

class _ViewLevelsScreenState extends State<ViewLevelsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LevelCubit>().indexLevels(courseId: widget.course.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        titleSpacing: 0,
        backgroundColor: defaultColor,
        title: DefaultText(
          text: 'Levels'.tr(context),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: widget.course.imageUrl.isEmpty
                        ? AssetImage('assets/images/1.jpg')
                        : NetworkImage(widget.course.imageUrl),
                  ),
                ),
              ),
              SizedBox(height: 10),
              DefaultText(
                text: widget.course.name,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              DefaultText(
                text: widget.course.description,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 10),
              DefaultText(
                text: 'Certificate'.tr(context),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 5),
              DefaultText(
                text: widget.course.certificate ?? '',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 10),
              DefaultText(
                text: 'Levels'.tr(context),
                style: Theme.of(context).textTheme.titleMedium,
              ),

              BlocBuilder<LevelCubit, LevelsState>(
                builder: (context, state) {
                  if (state.status == LevelsStatus.loading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state.status == LevelsStatus.error) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.error.isEmpty
                            ? 'Error loading Levels'
                            : state.error,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildItemsLevels(context, state.levels[index]),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 10, width: double.infinity),
                    itemCount: state.levels.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
