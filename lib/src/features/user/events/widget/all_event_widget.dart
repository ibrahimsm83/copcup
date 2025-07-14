import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/user/home/provider/catagory_provider.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class AllEventWidget extends StatefulWidget {
  final String title;
  final List<EventModel> events;
  const AllEventWidget({super.key, required this.title, required this.events});

  @override
  State<AllEventWidget> createState() => _AllEventWidgetState();
}

class _AllEventWidgetState extends State<AllEventWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final providerEvent = Provider.of<EventController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            widget.title,
            style: textTheme(context).headlineSmall?.copyWith(
                  fontSize: 21,
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: widget.events.length,
            itemBuilder: (context, index) {
              print(widget.events.length);

              final events = widget.events[index];
              if (widget.events.isEmpty) {
                return Center(
                    child: Text(
                        AppLocalizations.of(context)!.noEventsFoundMessage));
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        providerEvent.selectEvent(events.eventName);
                        context.pushNamed(AppRoute.specificEventDetailPage,
                            extra: events.id);
                        // print(result);
                        // if (result == true) {
                        //   log('Sucess');
                        // }
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage("${events.image}"),
                            fit: BoxFit.cover,
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
                            "${events.eventName}",
                            style: textTheme(context).headlineSmall?.copyWith(
                                color: colorScheme(context).surface,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${events.description}",
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
          ),
        ],
      ),
    );
  }
}
