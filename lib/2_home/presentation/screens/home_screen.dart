import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osclink_mobile/1_common/presentation/themes/app_colors.dart';
import 'package:osclink_mobile/1_common/presentation/themes/app_dimens.dart';
import '../../business_logic/post_list/post_list_bloc.dart';
import '../widgets/post_card_widget.dart';
import '../widgets/create_post_fab.dart';
import '../widgets/stories_bar_widget.dart';

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
      backgroundColor: AppColors.background,
      appBar: const _HomeAppBar(),
      body: Column(
        children: [
          const StoriesBar(),
          const Divider(height: 1, color: Color(0xFFCED5DC)),
          Expanded(
            child: BlocBuilder<PostListBloc, PostListState>(
              builder: (context, state) {
                if (state is PostListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (state is PostListError) {
                  return _ErrorView(
                    message: state.message,
                    onRetry: () =>
                        context.read<PostListBloc>().add(LoadPostsEvent()),
                  );
                }

                if (state is PostListLoaded) {
                  if (state.posts.isEmpty) return const _EmptyView();

                  return RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: () async =>
                        context.read<PostListBloc>().add(LoadPostsEvent()),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: AppDimens.contentMaxWidth(context),
                        ),
                        child: ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) =>
                              PostCardWidget(post: state.posts[index]),
                        ),
                      ),
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const CreatePostFab(),
    );
  }
}

// ─── AppBar ───────────────────────────────────

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.hub, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          const Text(
            'OSC Link',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF141619),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Color(0xFF141619)),
          onPressed: () {},
        ),
        _NotificationButton(),
        const SizedBox(width: 4),
      ],
    );
  }
}

class _NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined,
              color: Color(0xFF141619)),
          onPressed: () {},
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── États vide / erreur ─────────────────────

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFCED5DC)),
              ),
              child: const Icon(Icons.article_outlined,
                  size: 36, color: Color(0xFFCED5DC)),
            ),
            const SizedBox(height: 16),
            const Text(
              'Aucune publication',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF141619),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Commencez à publier ou suivez d\'autres organisations',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFCED5DC)),
              ),
              child: const Icon(Icons.wifi_off_outlined,
                  size: 36, color: Color(0xFFCED5DC)),
            ),
            const SizedBox(height: 16),
            const Text(
              'Impossible de charger le fil',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF141619),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Réessayer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
