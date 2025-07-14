// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SpecifcCatagoryEventsPage extends StatefulWidget {
  final int id;
  const SpecifcCatagoryEventsPage({super.key, required this.id});

  @override
  State<SpecifcCatagoryEventsPage> createState() =>
      SpecifcCatagoryEventsPageState();
}

class SpecifcCatagoryEventsPageState extends State<SpecifcCatagoryEventsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getEvents();
    });

    super.initState();
  }

  getEvents() async {
    final provider = Provider.of<EventController>(context, listen: false);
    await provider.getUserEventList();
    print(provider.eventList);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'All Events',
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getEvents();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<EventController>(builder: (context, provider, child) {
                if (provider.isEventLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: provider.eventList.length,
                  itemBuilder: (context, index) {
                    print(provider.eventList);

                    final events = provider.eventList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              provider.selectEvent(events.eventName);
                              context.pushNamed(
                                  AppRoute.specificEventDetailPage,
                                  extra: events.id);
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
                                  style: textTheme(context)
                                      .headlineSmall
                                      ?.copyWith(
                                          color: colorScheme(context).surface,
                                          fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${events.description}",
                                  style: textTheme(context)
                                      .titleSmall
                                      ?.copyWith(
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
              }),
            ],
          ),
        ),
      ),
    );
  }
}
