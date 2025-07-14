import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/user/home/controller/favourite_controller.dart';

import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
class FavoritesEventsPage extends StatefulWidget {
  const FavoritesEventsPage({super.key});

  @override
  State<FavoritesEventsPage> createState() => _FavoritesEventsPageState();
}

class _FavoritesEventsPageState extends State<FavoritesEventsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFavouriteEvents();
    });
  }

  getFavouriteEvents() async {
    final provider = Provider.of<FavouriteController>(context, listen: false);
    await provider.getFavoritesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.favoritesEventsTitle,
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.favoriteEventsSubtitle,
              style: textTheme(context).headlineSmall?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(0.4),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 25),
            Expanded(child: Consumer<FavouriteController>(
                builder: (context, provider, child) {
              if (provider.isFavoritesLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (provider.favoriteEvents.isEmpty) {
                return Center(
                  child: Text(
                      AppLocalizations.of(context)!.na_noFavoriteEventsFound),
                );
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: provider.favoriteEvents.length,
                itemBuilder: (context, index) {
                  final favevents = provider.favoriteEvents[index];
                  if (provider.favoriteEvents.isEmpty) {
                    return Center(
                      child: Text(
                          AppLocalizations.of(context)!.na_noFavEventsFound),
                    );
                  }
                  return EventCards(event: favevents);
                },
              );
            })),
          ],
        ),
      ),
    );
  }
}

class EventCards extends StatelessWidget {
  final EventModel event;

  const EventCards({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesController = Provider.of<FavouriteController>(context);
    final eventController = Provider.of<EventController>(context);
    final isFavorite = favoritesController.isFavorite(event.id.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                eventController.selectEvent(event.eventName);
                context.pushNamed(AppRoute.specificEventDetailPage,
                    extra: event.id);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  event.image.startsWith('http')
                      ? event.image
                      : "${ApiEndpoints.baseImageUrl}${event.image}",
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: colorScheme(context).surface,
                child: IconButton(
                  onPressed: () {
                    favoritesController.removeFavorite(
                        context: context, id: event.id.toString());
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite_outline : Icons.favorite,
                    size: 19,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          event.eventName,
          style: textTheme(context).titleSmall?.copyWith(
              color: colorScheme(context).primary, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          event.description,
          style: textTheme(context).bodySmall?.copyWith(
              color: colorScheme(context).onSurface.withOpacity(0.4),
              fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
