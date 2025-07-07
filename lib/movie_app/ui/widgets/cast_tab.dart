import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_app/infra/models/credits_model.dart';
import 'package:movie/movie_app/presenter/controllers/Credits/cubit/credits_cubit.dart';
import 'package:movie/movie_app/presenter/controllers/Credits/cubit/credits_state.dart';
import 'package:movie/movie_app/infra/datasources/movie_api_service.dart';

class CastTab extends StatelessWidget {
  final int movieId;

  const CastTab({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              CreditsCubit(context.read<MovieApiService>())
                ..fetchMovieCredits(movieId),
      child: BlocBuilder<CreditsCubit, CreditsState>(
        builder: (context, state) {
          if (state is CreditsLoading || state is CreditsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CreditsSuccess) {
            if (state.cast.isEmpty) {
              return const Center(
                child: Text('No cast information available.'),
              );
            }
            return CastGridView(castList: state.cast);
          } else if (state is CreditsFailure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return const Center(child: Text('Something went wrong!'));
        },
      ),
    );
  }
}

class CastGridView extends StatelessWidget {
  final List<Cast> castList;

  const CastGridView({super.key, required this.castList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),

      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        childAspectRatio: 2 / 3.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: castList.length,
      itemBuilder: (context, index) {
        final castMember = castList[index];
        return CastMemberCard(castMember: castMember);
      },
    );
  }
}

class CastMemberCard extends StatelessWidget {
  final Cast castMember;

  const CastMemberCard({super.key, required this.castMember});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey.shade200,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: castMember.fullProfilePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget:
                    (context, url, error) => Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey.shade400,
                    ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          castMember.name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }
}
