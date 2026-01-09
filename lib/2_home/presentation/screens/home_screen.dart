import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/post_list/post_list_bloc.dart';
import '../widgets/post_card_widget.dart';
import '../widgets/create_post_fab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostListBloc()..add(LoadPostsEvent()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OSC Link Home'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<PostListBloc, PostListState>(
        builder: (context, state) {
          if (state is PostListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PostListError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                ],
              ),
            );
          }

          if (state is PostListLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PostListBloc>().add(LoadPostsEvent());
              },
              child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return PostCardWidget(post: state.posts[index]);
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: const CreatePostFab(),
    );
  }
}
