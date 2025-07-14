import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsPage extends StatefulWidget {
  final EventModel eventModel;
  const EventDetailsPage({super.key, required this.eventModel});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool isAddressExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.event_details,
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage("${widget.eventModel.image}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.eventModel.eventName,
              style: textTheme(context).headlineLarge?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, size: 16),
                SizedBox(width: 5),
                // Text(
                //   widget.eventModel.days.toString(),
                //   style: textTheme(context).titleSmall?.copyWith(
                //         fontSize: 14,
                //         color: colorScheme(context).onSurface.withOpacity(0.3),
                //         fontWeight: FontWeight.w400,
                //       ),
                // ),
                // SizedBox(width: 5),
                Text(
                  widget.eventModel.startDate != null
                      ? DateFormat("dd MMM, hh:mm a")
                          .format(widget.eventModel.startDate!)
                      : "",
                  style: textTheme(context).titleSmall?.copyWith(
                        fontSize: 14,
                        color: colorScheme(context).onSurface.withOpacity(0.3),
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    widget.eventModel.address,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: isAddressExpanded ? null : 2,
                    style: textTheme(context).titleMedium?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.5),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAddressExpanded = !isAddressExpanded;
                    });
                  },
                  child: Text(
                    isAddressExpanded
                        ? AppLocalizations.of(context)!.na_seeLess
                        : AppLocalizations.of(context)!.na_seeMore,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              AppLocalizations.of(context)!.description,
              style: textTheme(context).headlineLarge?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 3),
            Text(
              widget.eventModel.description,
              style: textTheme(context).titleSmall?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                  ),
            ),
            SizedBox(height: 40),
            Consumer<EventController>(
              builder: (context, eventController, child) => CustomButton(
                  iconColor: colorScheme(context).primary,
                  arrowCircleColor: colorScheme(context).surface,
                  // text: AppLocalizations.of(context)!.edit_event,
                  text: AppLocalizations.of(context)!.sendRequest,
                  backgroundColor: colorScheme(context).primary,
                  onPressed: () async {
                    print("user id is ${StaticData.userId}");
                    eventController.associateEstablishmentWithEvent(
                      eventId: widget.eventModel.id,
                      context: context,
                    );
                  }),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
