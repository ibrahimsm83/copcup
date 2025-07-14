import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_shimer.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/home/controller/favourite_controller.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventController eventController = EventController();

    final navigationProvider = Provider.of<NavigationProvider>(context);
    return Consumer<FavouriteController>(
      builder: (context, favoritesController, child) {
        bool isFavorite = favoritesController.favoriteEvents
            .any((favEvent) => favEvent.id == event.id);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  eventController.selectEvent(event.eventName);
                  navigationProvider.updateEventBool(true);
                  final result = await context.pushNamed(
                    AppRoute.specificEventDetailPage,
                    extra: event.id,
                  );
                  if (result == true) {
                    await eventController.getEventList();
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: event.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CustomShimmer(
                      height: 200,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor:
                      colorScheme(context).surface.withOpacity(0.2),
                  child: IconButton(
                    onPressed: () async {
                      // Immediately toggle the favorite status in the UI
                      isFavorite = !isFavorite;

                      // Notify the controller to update the list
                      favoritesController.notifyListeners();

                      // Call the API in the background to update the favorite status
                      if (isFavorite) {
                        await favoritesController.addFavorite(
                          context: context,
                          event: event,
                        );
                      } else {
                        await favoritesController.removeFavorite(
                          context: context,
                          id: event.id.toString(),
                        );
                      }
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      size: 23,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${event.eventName}",
                      style: textTheme(context).headlineSmall?.copyWith(
                          color: colorScheme(context).surface,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${event.description}",
                      style: textTheme(context).titleSmall?.copyWith(
                          color: colorScheme(context).surface,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
