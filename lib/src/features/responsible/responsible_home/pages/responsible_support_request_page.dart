import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/support_request_model.dart';

class ResponsibleSupportRequestPage extends StatelessWidget {
  ResponsibleSupportRequestPage({super.key});

  List<SupportRequest> defaultSupportRequests = [
    SupportRequest(
      title: 'LinkedIn Job Alerts',
      subtitle: '"Real estate manager": Starbucks - r...',
      time: '12:58',
      icon: AppImages.linkDin,
    ),
    SupportRequest(
      title: 'Guardian Jobs',
      subtitle: '"Real estate manager": Starbucks - r...',
      time: '12:58',
      icon: AppImages.gPick,
    ),
    SupportRequest(
      title: 'Social',
      subtitle: '"Facebook, Kofi via Messenger, Twitter message',
      time: '12:58',
      icon: AppImages.personPic,
    ),
    SupportRequest(
      title: 'LinkedIn Job Alerts',
      subtitle: '"Real estate manager": Starbucks - r...',
      time: '12:58',
      icon: AppImages.linkDin,
    ),
    SupportRequest(
      title: 'LinkedIn Job Alerts',
      subtitle: '"Real estate manager": Starbucks - r...',
      time: '12:58',
      icon: AppImages.linkDin,
    ),
    SupportRequest(
      title: 'Center for Language Resources',
      subtitle: 'Fee Waiver Approval to Participate inside this program',
      time: '12:58',
      icon: AppImages.cPick,
    ),
    SupportRequest(
      title: 'Guardian Jobs',
      subtitle: '"Real estate manager": Starbucks - r...',
      time: '12:58',
      icon: AppImages.gPick,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ResponsibleAppBar(
        title: 'Support Requests',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: defaultSupportRequests.length,
                itemBuilder: (context, index) {
                  final request = defaultSupportRequests[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoute.responsibleChatPage);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: index == 1 ||
                                    index == 2 ||
                                    index == 5 ||
                                    index == 6
                                ? colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.1)
                                : null,
                            child: Image.asset(
                              request.icon,
                              height: index == 1 ||
                                      index == 2 ||
                                      index == 5 ||
                                      index == 6
                                  ? 20
                                  : null,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: size.width * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(request.title,
                                    style: textTheme(context).titleSmall),
                                SizedBox(
                                  height: 15,
                                  child: Text(request.subtitle,
                                      style: textTheme(context)
                                          .titleSmall
                                          ?.copyWith(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14)),
                                ),
                                SizedBox(
                                  height: 15,
                                  child: Text(
                                      'Starbucks real estate manager - Existing',
                                      style: textTheme(context)
                                          .titleSmall
                                          ?.copyWith(
                                              overflow: TextOverflow.ellipsis,
                                              color: colorScheme(context)
                                                  .onSurface
                                                  .withOpacity(0.6),
                                              fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                request.time,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme(context).onSurface),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Icon(Icons.star_border),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )

                      /*ListTile(
                    leading: CircleAvatar(
                      child: Icon(request.icon),
                    ),
                    title: Text(request.title, style: textTheme(context).titleSmall),
                    subtitle: Column(
                      children: [
                        Text(request.subtitle,
                            style:
                                textTheme(context).titleSmall?.copyWith(fontSize: 14)),
                        Text('Starbucks real estate manager - Existing',
                            style: textTheme(context).titleSmall?.copyWith(
                                color: colorScheme(context).onSurface.withOpacity(0.6),
                                fontSize: 12)),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          request.time,
                          style: TextStyle(
                              fontSize: 12, color: colorScheme(context).onSurface),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Icon(Icons.star_border),
                      ],
                    ),
                  )*/
                      ;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
