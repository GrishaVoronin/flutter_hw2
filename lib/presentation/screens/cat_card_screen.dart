import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dialogs/network_error_dialog.dart';
import '../widgets/like_dislike_button.dart';
import '../cubits/cat_card_cubit.dart';
import 'cat_details_screen.dart';
import 'liked_cats_screen.dart';

class CatCardScreen extends StatefulWidget {
  const CatCardScreen({super.key});

  @override
  CatCardScreenState createState() => CatCardScreenState();
}

class CatCardScreenState extends State<CatCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KotoTinder'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LikedCatsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.favorite, color: Colors.pinkAccent),
            label: const Text('Favorites'),
          ),
        ],
      ),
      body: BlocConsumer<CatCardCubit, CatCardState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(
                message: state.errorMessage!,
                onRetry: () {
                  context.read<CatCardCubit>().loadNewCat();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<CatCardCubit>();

          if (state.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage ?? 'There are no available seals.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      cubit.loadNewCat();
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: state.isLoading
                ? const _LoadingIndicator()
                : state.currentCat == null
                    ? const Text('There are no available seals.')
                    : _CatCardContent(
                        state: state,
                        onLike: cubit.likeCat,
                        onDislike: cubit.dislikeCat,
                        onTapDetails: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CatDetailsScreen(cat: state.currentCat!),
                            ),
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}

class _LoadingIndicator extends StatefulWidget {
  const _LoadingIndicator();

  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<_LoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: const Icon(
        Icons.pets,
        size: 100,
        color: Colors.blueGrey,
      ),
    );
  }
}

class _CatCardContent extends StatelessWidget {
  final CatCardState state;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onTapDetails;

  const _CatCardContent({
    required this.state,
    required this.onLike,
    required this.onDislike,
    required this.onTapDetails,
  });

  @override
  Widget build(BuildContext context) {
    final cat = state.currentCat!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Dismissible(
          key: ValueKey(cat.id),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              onDislike();
            } else {
              // context.read<LikedCatsCubit>().likeCat(cat);
              onLike();
            }
          },
          child: GestureDetector(
            onTap: onTapDetails,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Hero(
                      tag: cat.id,
                      child: CachedNetworkImage(
                        imageUrl: cat.url ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                if (cat.breeds?.isNotEmpty ?? false)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                      child: Text(
                        cat.breeds!.first.name!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LikeDislikeButton(
              icon: Icons.close,
              onPressed: onDislike,
              color: Colors.red,
            ),
            const SizedBox(width: 50),
            LikeDislikeButton(
              icon: Icons.favorite,
              onPressed: () {
                // context.read<LikedCatsCubit>().likeCat(cat);
                onLike();
              },
              color: Colors.green,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Likes: ${state.likeCount}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
