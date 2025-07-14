import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';

import 'package:flutter_application_copcup/src/features/responsible/add_event_catagory/controller/event_category_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class AllEventCatagories extends StatefulWidget {
  const AllEventCatagories({super.key});

  @override
  State<AllEventCatagories> createState() => _AllEventCatagoriesState();
}

class _AllEventCatagoriesState extends State<AllEventCatagories> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getEventsCategory();
    });

    super.initState();
  }

  getEventsCategory() async {
    final provider =
        Provider.of<EventCategoryController>(context, listen: false);
    await provider.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.all_event_categories,
          onLeadingPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Expanded(
                child: Consumer<EventCategoryController>(
                  builder: (context, provider, child) {
                    if (provider.isEventCategoryLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                      itemCount: provider.eventCategoryList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, childAspectRatio: 0.8),
                      itemBuilder: (context, index) {
                        final category = provider.eventCategoryList[index];
                        if (provider.eventCategoryList.isEmpty) {
                          return Center(
                            child: Text("No Category Found"),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomContainer(
                              height: 70,
                              onTap: () async {
                                provider.selectCategory(category.categoryName!, category.id!);
                                final result = await context.pushNamed(
                                  AppRoute.eventCatagoryDetailPage,
                                  extra: category,
                                );
                                print(result);
                                if (result == true) {
                                  await provider.getCategoryList();
                                }
                              },
                              width: 79,
                              borderRadius: 5,
                              color: provider.selectedCategory ==
                                      category.categoryName
                                  ? colorScheme(context).secondary
                                  : AppColor.categoryColor,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: "${category.image}",
                                width: double.infinity,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    color: Colors.grey[300],
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              category.categoryName!,
                              style: textTheme(context).labelLarge?.copyWith(
                                  letterSpacing: 0.2,
                                  fontSize: 10,
                                  color: colorScheme(context).onSurface),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              CustomButton(
                height: 55,
                iconColor: colorScheme(context).secondary,
                backgroundColor: colorScheme(context).secondary,
                text: AppLocalizations.of(context)!.na_addCategory,
                onPressed: () {
                  context.pushNamed(AppRoute.addEventCatagoryPage);
                },
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ));
  }
}
