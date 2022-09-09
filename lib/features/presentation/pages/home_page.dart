import 'package:capacious/features/presentation/cubit/video_cubit.dart';
import 'package:capacious/features/presentation/pages/about_page.dart';
import 'package:capacious/features/presentation/pages/subs_page.dart';
import 'package:capacious/features/presentation/widget/dynamic_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'video_page.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<VideoCubit>(context).fetchVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Capacious',
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutPage(uid: widget.uid),
                      ));
                },
                icon: const Icon(Icons.person))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SingleChildScrollView(
            child: _buildVideoList(),
          ),
        ));
  }

  Widget _buildVideoList() {
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) {
        if (state is VideoLoaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.video.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<VideoCubit>(context)
                      .checkSubscriptionStatus(widget.uid)
                      .then((value) {
                    if (value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VideoPage(video: state.video[index]),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubsPage(uid: widget.uid),
                          ));
                    }
                  });
                },
                child: Card(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DynamicCachedNetworkImage(
                      imageUrl: state.video[index].thumbnail!,
                      height: MediaQuery.of(context).size.height * 0.24,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.video[index].title!,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(state.video[index].author!,
                              style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  ],
                )),
              );
            },
          );
        } else if (state is VideoEmpty) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: const Center(child: Text('Video is empty')));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
