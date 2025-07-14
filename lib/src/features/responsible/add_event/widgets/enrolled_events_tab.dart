import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class EnrolledEventsTab extends StatefulWidget {
  const EnrolledEventsTab({super.key});

  @override
  State<EnrolledEventsTab> createState() => _EnrolledEventsTabState();
}

class _EnrolledEventsTabState extends State<EnrolledEventsTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfessionalEvents();
    });

    super.initState();
  }

  getProfessionalEvents() async {
    final provider = Provider.of<EventController>(context, listen: false);
    await provider.getProfessionalEvents();
    print(provider.eventList);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await getProfessionalEvents();
      },
      child: Consumer<EventController>(
        builder: (context, provider, child) {
          if (provider.isProfessionalEventLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (provider.professionalEventList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.na_noEventAvailable),
                  SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme(context).primary,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      await getProfessionalEvents();
                    },
                    child: Text("Refresh"),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            child:
                Consumer<EventController>(builder: (context, provider, child) {
              return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.professionalEventList.length,
                separatorBuilder: (context, index) => const Divider(height: 25),
                itemBuilder: (context, index) {
                  print(provider.professionalEventList);

                  final events = provider.professionalEventList[index];

                  return InkWell(
                    onTap: () async {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: events.image,
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              child: Container(
                                width: 80,
                                height: 60,
                                color: Colors.grey.shade300,
                              ),
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${events.eventName}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme(context)
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${events.description}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: textTheme(context)
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          );
        },
      ),
    );
  }
}
