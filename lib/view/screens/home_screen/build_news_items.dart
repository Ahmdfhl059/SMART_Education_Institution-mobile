import 'package:SMART/data/api/post_api.dart';
import 'package:SMART/data/models/post.dart';
import 'package:SMART/data/repo/post_repo.dart';
import 'package:SMART/logic/post_cubit/post_cubit.dart';
import 'package:SMART/shared/components/components.dart';
import 'package:SMART/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildNewsItems extends StatefulWidget {
  final Post post;

  const BuildNewsItems({super.key, required this.post});

  @override
  State<BuildNewsItems> createState() => _BuildNewsItemsState();
}

class _BuildNewsItemsState extends State<BuildNewsItems> {
  bool isText = true;
  bool isLike = false;
  bool isDisLike = false;
  bool isEnable = false;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      width: double.infinity,
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
                image: NetworkImage(widget.post.imageUrl),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: widget.post.title,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8),
            child: SizedBox(
              width: 370,
              child: isText == true
                  ? DefaultText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: widget.post.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  : DefaultText(
                      text: widget.post.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8),
            child: SizedBox(
              height: 20,
              child: DefaultTextButton(
                text: isText ? 'Show More' : 'Show Least',
                color: defaultColor,
                size: 10,
                onPressed: () {
                  setState(() {
                    isText = !isText;
                  });
                },
                textDecoration: TextDecoration.underline,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => PostCubit(postRepo: PostRepo(postApi: PostApi())),
            child: BlocBuilder<PostCubit, PostState>(
              builder: (context, state) {
                return BuildNewsItemsButtons(post:widget.post );

              },
            ),
          ),
        ],
      ),
    );
  }
}



class BuildNewsItemsButtons extends StatelessWidget {
  final Post post;
  const BuildNewsItemsButtons({super.key, required this.post});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<PostCubit, PostState>(
      buildWhen: (prev, curr) =>
      prev.post != curr.post || prev.likesStatus != curr.likesStatus,
      builder: (context, state) {
        final cubit = context.read<PostCubit>();
        final p = state.post;

        return Row(
          children: [
            // Like
            IconButton(
              onPressed: (){
                cubit.likePost(post: post);
              },
              icon: Icon(
                Icons.arrow_upward,
                color: state.likesStatus == LikesStatus.like
                    ? Colors.green
                    : Colors.grey,
              ),
              tooltip: 'Like',
            ),
            Text('${p.likes}'),

            const SizedBox(width: 12),

            // Dislike
            IconButton(
              onPressed: (){
                cubit.dislikePost(post: post);
              },
              icon: Icon(
                Icons.arrow_downward,
                color: state.likesStatus == LikesStatus.dislike
                    ? Colors.red
                    : Colors.grey,
              ),
              tooltip: 'Dislike',
            ),
            Text('${p.dislikes}'),
          ],
        );
      },
    );
  }
}