import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import '../../../common/constants/app_images.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: colorScheme(context).surface,
        body: Stack(children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: colorScheme(context).surface,
              image: DecorationImage(
                  image: AssetImage(AppImages.getStartedImage),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 295),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.5,
                    width: size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          colorScheme(context).surface.withOpacity(0.2),
                          colorScheme(context).surface.withOpacity(0.3),
                          colorScheme(context).surface.withOpacity(0.4),
                          colorScheme(context).surface.withOpacity(0.5),
                          colorScheme(context).surface.withOpacity(0.6),
                          colorScheme(context).surface.withOpacity(0.7),
                          colorScheme(context).surface.withOpacity(0.8),
                          colorScheme(context).surface.withOpacity(0.9),
                          colorScheme(context).surface,
                          colorScheme(context).surface,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Discover Existing\n Events Near You',
                          style: textTheme(context).headlineLarge?.copyWith(
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w700,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            'From food festivals to live music, explore\n a variety of events happening around\n you. Tailor your experience by selecting\n your favorite event categories.',
                            style: textTheme(context).bodyLarge?.copyWith(
                              color: colorScheme(context).onSurface,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            iconColor: colorScheme(context).primary,
                            arrowCircleColor: colorScheme(context).surface,
                            text: 'Next',
                            backgroundColor: colorScheme(context).primary,
                            onPressed: () {
                              context
                                  .pushNamed(AppRoute.sigInMethodSelectionPage);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
