import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// Main title displayed on the Get Started screen.
  ///
  /// In en, this message translates to:
  /// **'Discover Existing\nEvents Near You'**
  String get getStartedMainTitle;

  /// Subtitle text displayed below the main title on the Get Started screen.
  ///
  /// In en, this message translates to:
  /// **'From food festivals to live music, explore\n a variety of events happening around\n you. Tailor your experience by selecting\n your favorite event categories.'**
  String get getStartedSubtitleText;

  /// Text for the next button.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// Label for a section displaying different categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get na_categories;

  /// Title text on the role selection screen.
  ///
  /// In en, this message translates to:
  /// **'Let’s Get Started'**
  String get letsGetStarted;

  /// Subtitle prompting the user to select a role.
  ///
  /// In en, this message translates to:
  /// **'Please Select Your Role!'**
  String get pleaseSelectYourRole;

  /// Label for the User role.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get roleUser;

  /// Prompt or instruction to use a confirmation token for verification.
  ///
  /// In en, this message translates to:
  /// **'Use confirmation token'**
  String get na_useConfirmationToken;

  /// Message confirming that a verification step is complete and thanking the user for their purchase.
  ///
  /// In en, this message translates to:
  /// **'for verification. Thank you for your purchase!'**
  String get na_verificationThankYou;

  /// Label for the seller role.
  ///
  /// In en, this message translates to:
  /// **'Seller'**
  String get role_seller;

  /// Label for the Professional role.
  ///
  /// In en, this message translates to:
  /// **'Professional'**
  String get roleProfessional;

  /// Label for the Responsible role.
  ///
  /// In en, this message translates to:
  /// **'Responsible'**
  String get roleResponsible;

  /// Error message when no role is selected and the user presses Next.
  ///
  /// In en, this message translates to:
  /// **'Please select your role before proceeding.'**
  String get selectRoleError;

  /// Indicates that the user is successfully registered or signed up for something (e.g., a course, service, or event).
  ///
  /// In en, this message translates to:
  /// **'Enrolled'**
  String get na_enrolled;

  /// Displayed when no seller is available or matched in the system.
  ///
  /// In en, this message translates to:
  /// **'No seller found'**
  String get na_noSellerFound;

  /// Subtitle encouraging the user to sign in to their account.
  ///
  /// In en, this message translates to:
  /// **'Let’s dive into your account!'**
  String get diveIntoAccount;

  /// Text for the Google sign-in button.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// Text for the Apple sign-in button.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// Text for the sign-up button.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// Text for the login button.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Main title displayed on the Sign In screen.
  ///
  /// In en, this message translates to:
  /// **'Let’s Sign In.!'**
  String get signInTitle;

  /// Subtitle text displayed below the main title on the Sign In screen.
  ///
  /// In en, this message translates to:
  /// **'Fill the information to login account!'**
  String get signInSubtitle;

  /// Placeholder text for the email input field.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// Placeholder text for the password input field.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// Label for the Remember Me checkbox.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// Text for the Forgot Password button.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Text for the Sign In button.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// Text displayed above the social sign-in buttons.
  ///
  /// In en, this message translates to:
  /// **'Or Continue With'**
  String get continueWithText;

  /// Title of the Forgot Password page.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgotPasswordTitle;

  /// Instruction text on the Forgot Password page, prompting the user to select a contact method.
  ///
  /// In en, this message translates to:
  /// **'Select which contact details should we use to reset your password'**
  String get forgotPasswordInstruction;

  /// Label for the email contact option.
  ///
  /// In en, this message translates to:
  /// **'Via Email'**
  String get viaEmail;

  /// Label for the SMS contact option.
  ///
  /// In en, this message translates to:
  /// **'Via SMS'**
  String get viaSms;

  /// Example email address displayed for the email contact option.
  ///
  /// In en, this message translates to:
  /// **'priscilla.frank26@gmail.com'**
  String get emailContactExample;

  /// Example phone number displayed for the SMS contact option.
  ///
  /// In en, this message translates to:
  /// **'(+1) 480-894-5529'**
  String get smsContactExample;

  /// Text for the Continue button.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Title of the OTP Verification page.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerificationTitle;

  /// Instruction text on the OTP Verification page.
  ///
  /// In en, this message translates to:
  /// **'We sent a reset link to your email, enter 4 digit code that mentioned in the email'**
  String get otpVerificationInstruction;

  /// Text for the Verify button.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyButtonText;

  /// Error message shown when the user enters an invalid OTP.
  ///
  /// In en, this message translates to:
  /// **'Please enter a 4-digit OTP.'**
  String get invalidOtpMessage;

  /// Main title for the Sign Up screen.
  ///
  /// In en, this message translates to:
  /// **'Let’s Sign Up.!'**
  String get signUpTitle;

  /// Subtitle text on the Sign Up screen.
  ///
  /// In en, this message translates to:
  /// **'Fill the information to Create account!'**
  String get signUpSubtitle;

  /// Placeholder for the name input field.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameHint;

  /// Title for the reset password page
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// Description text for the reset password page
  ///
  /// In en, this message translates to:
  /// **'Reset your password to regain access to your account.'**
  String get resetPasswordDescription;

  /// Hint text for the new password field
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get newPasswordHint;

  /// Label for the confirm password field
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmPasswordLabel;

  /// Text for the reset password button
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordButton;

  /// Placeholder for the surname input field.
  ///
  /// In en, this message translates to:
  /// **'Sur Name'**
  String get surNameHint;

  /// Placeholder for the country input field.
  ///
  /// In en, this message translates to:
  /// **'(+1) 724-848-1225'**
  String get countryHint;

  /// Title of the Change Password page.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordTitle;

  /// Label for the old password input field.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPasswordLabel;

  /// Label for the new password input field.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordLabel;

  /// Label for the confirm password input field.
  ///
  /// In en, this message translates to:
  /// **'Re-enter Password'**
  String get confirmPasswordLabels;

  /// Text for the Change Password button.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordButton;

  /// Title for the success dialog after changing the password.
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congratulationsText;

  /// Message displayed in the success dialog after changing the password.
  ///
  /// In en, this message translates to:
  /// **'Your Account is Ready to Use. You will be'**
  String get accountReadyMessage;

  /// Redirected Message
  ///
  /// In en, this message translates to:
  /// **'redirected to the Home Page in a Few'**
  String get redirectedText;

  /// Seconds Text
  ///
  /// In en, this message translates to:
  /// **'Seconds.'**
  String get secondsText;

  /// Title for the events categories section.
  ///
  /// In en, this message translates to:
  /// **'Events Categories'**
  String get eventsCategoriesTitle;

  /// Text for the button to see all categories or events.
  ///
  /// In en, this message translates to:
  /// **'SEE ALL'**
  String get seeAllButton;

  /// Text for the button to see search field.
  ///
  /// In en, this message translates to:
  /// **'What you are looking for?'**
  String get searchTitleHome;

  /// Text for the button to see nearest events.
  ///
  /// In en, this message translates to:
  /// **'Nearest Events'**
  String get nearestEvents;

  /// Title for the events for you section.
  ///
  /// In en, this message translates to:
  /// **'Events for you'**
  String get eventsForYouTitle;

  /// Title of the Find Events page.
  ///
  /// In en, this message translates to:
  /// **'Find Events'**
  String get findEventsTitle;

  /// Title for the Around Me events section.
  ///
  /// In en, this message translates to:
  /// **'Around Me'**
  String get aroundMeSectionTitle;

  /// Title for the Most Popular events section.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get mostPopularSectionTitle;

  /// Title for the Last Orders events section.
  ///
  /// In en, this message translates to:
  /// **'Last Orders'**
  String get lastOrdersSectionTitle;

  /// Placeholder text for the search bar.
  ///
  /// In en, this message translates to:
  /// **'Search for...'**
  String get searchBarHint;

  /// Message displayed when no events match the search query.
  ///
  /// In en, this message translates to:
  /// **'No events found.'**
  String get noEventsFoundMessage;

  /// Button label to send a request.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get sendRequest;

  /// Prompt asking the user to choose or pick a location.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get na_selectLocation;

  /// Title of the All Categories page.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get allCategoriesTitle;

  /// Displayed when the user has not marked any events as favorites.
  ///
  /// In en, this message translates to:
  /// **'No favorite events found.'**
  String get na_noFavoriteEventsFound;

  /// Displayed when there are no favorite events saved by the user.
  ///
  /// In en, this message translates to:
  /// **'No fav events found'**
  String get na_noFavEventsFound;

  /// Title for the Scan QR Code page.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQrTitle;

  /// Prompt telling the user to select an order before proceeding.
  ///
  /// In en, this message translates to:
  /// **'Please select an order first'**
  String get na_selectOrderFirst;

  /// Label for the unique identifier of a customer's order.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get na_orderId;

  /// Displayed when there are no orders marked as completed.
  ///
  /// In en, this message translates to:
  /// **'No completed order'**
  String get na_noCompletedOrder;

  /// Displayed when an order has been successfully delivered.
  ///
  /// In en, this message translates to:
  /// **'Order delivered'**
  String get na_orderDelivered;

  /// Title for the Scan QR Code page.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get orderHistory;

  /// Title for the Scan QR Code page.
  ///
  /// In en, this message translates to:
  /// **'Food List'**
  String get foodLists;

  /// Title for the Scan QR Code page.
  ///
  /// In en, this message translates to:
  /// **' QR Code'**
  String get qrTitle;

  /// Title for the Scan QR Code page.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scanQrButton;

  /// Subtitle text explaining how to scan the QR code.
  ///
  /// In en, this message translates to:
  /// **'The QR code will be automatically detected when you position it between the guide lines'**
  String get scanQrSubtitle;

  /// Title for the Contact Us page.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUsTitle;

  /// Label for the Message input field.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageFieldLabel;

  /// Hint text for the Message input field.
  ///
  /// In en, this message translates to:
  /// **'Enter here message...'**
  String get messageFieldHint;

  /// Text for the Submit button.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// Message displayed when the contact form is successfully submitted.
  ///
  /// In en, this message translates to:
  /// **'Message submitted successfully'**
  String get messageSubmittedSnackbar;

  /// Title for the Edit Profile page.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// Text for the Edit Profile button.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileButton;

  /// Title for the Notification page.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notificationTitle;

  /// Label for notifications received today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayLabel;

  /// Label for notifications received yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterdayLabel;

  /// Title for the Profile page.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profilePageTitle;

  /// Title for the general information section.
  ///
  /// In en, this message translates to:
  /// **'General information'**
  String get generalInformationTitle;

  /// Option title for language settings.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageOption;

  /// Option title for deleting the account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountOption;

  /// Option title for viewing transactions.
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get transactionOption;

  /// Option title for terms and conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Condition'**
  String get termsConditionOption;

  /// Option title for logging out.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logoutOption;

  /// Confirmation message for deleting the account.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete?'**
  String get deleteConfirmation;

  /// Confirmation message for logging out.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to logout?'**
  String get logoutConfirmation;

  /// Text for the cancel button.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// Text for the confirm button.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesButton;

  /// Text for the confirm logout button.
  ///
  /// In en, this message translates to:
  /// **'Yes Logout'**
  String get yesLogoutButton;

  /// Section title for user responsibilities.
  ///
  /// In en, this message translates to:
  /// **'User Responsibilities'**
  String get userResponsibilitiesTitle;

  /// Content for the user responsibilities section.
  ///
  /// In en, this message translates to:
  /// **'Users are expected to engage with the app in a respectful and responsible manner. This includes maintaining the confidentiality of account credentials, reporting any suspicious activity, and adhering to community guidelines. Users must not engage in any behavior that disrupts the experience for others or violates any applicable laws.'**
  String get userResponsibilitiesContent;

  /// Section title for data privacy.
  ///
  /// In en, this message translates to:
  /// **'Data Privacy'**
  String get dataPrivacyTitle;

  /// Content for the data privacy section.
  ///
  /// In en, this message translates to:
  /// **'We prioritize your privacy and are committed to protecting your personal information. Our app collects data in accordance with our Privacy Policy, which details how we gather, use, and safeguard your information. By using the app, you consent to our data practices, including the use of cookies and tracking technologies to enhance your user experience.'**
  String get dataPrivacyContent;

  /// Section title for conditions.
  ///
  /// In en, this message translates to:
  /// **'Conditions'**
  String get conditionsTitle;

  /// Content for the conditions section.
  ///
  /// In en, this message translates to:
  /// **'Users are expected to engage with the app in a respectful and responsible manner. This includes maintaining the confidentiality of account credentials, reporting any suspicious activity, and adhering to community guidelines. Users must not engage in any behavior that disrupts the experience for others or violates any applicable laws.'**
  String get conditionsContent;

  /// Title for the recent payments section.
  ///
  /// In en, this message translates to:
  /// **'Recent Payments'**
  String get recentPaymentsTitle;

  /// Title for the Favorites Events page.
  ///
  /// In en, this message translates to:
  /// **'Favorites Events'**
  String get favoritesEventsTitle;

  /// Subtitle for the Favorites Events page.
  ///
  /// In en, this message translates to:
  /// **'It\'s time to buy your favorite dish.'**
  String get favoriteEventsSubtitle;

  /// Label for the description section.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Label for the food list section.
  ///
  /// In en, this message translates to:
  /// **'Food List'**
  String get foodList;

  /// Label for the dishes section.
  ///
  /// In en, this message translates to:
  /// **'Dishes'**
  String get dishes;

  /// Label for the drinks section.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get drinks;

  /// Title for the age verification dialog.
  ///
  /// In en, this message translates to:
  /// **'Age Verification'**
  String get ageVerification;

  /// Message for the age verification dialog.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your age'**
  String get ageVerificationMessage;

  /// Button text for users under 18.
  ///
  /// In en, this message translates to:
  /// **'I am under 18'**
  String get under18Button;

  /// Button text for users 18 and older.
  ///
  /// In en, this message translates to:
  /// **'I am 18 old'**
  String get over18Button;

  /// Label or button for requesting a product to be restocked.
  ///
  /// In en, this message translates to:
  /// **'Bring Back to Stock'**
  String get na_bringBackToStock;

  /// Displayed when an item is not available in inventory.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get na_outOfStock;

  /// Displayed during the token verification process.
  ///
  /// In en, this message translates to:
  /// **'Confirmation Token Verification'**
  String get na_confirmationTokenVerification;

  /// Prompt for users to enter a confirmation code related to their order.
  ///
  /// In en, this message translates to:
  /// **'Please enter the confirmation code for your specific order to complete the process.'**
  String get na_enterConfirmationCode;

  /// Prompt or instruction to scan a QR code or barcode.
  ///
  /// In en, this message translates to:
  /// **'Scan a code'**
  String get na_scanACode;

  /// Button or prompt to confirm the verification code entered by the user.
  ///
  /// In en, this message translates to:
  /// **'Verify confirmation code'**
  String get na_verifyConfirmationCode;

  /// Label for a section displaying different types of food.
  ///
  /// In en, this message translates to:
  /// **'Foods'**
  String get na_foods;

  /// Displayed when no food items are available to show.
  ///
  /// In en, this message translates to:
  /// **'No food item found'**
  String get na_noFoodItemFound;

  /// Displayed as a button or link to reveal additional content.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get na_seeMore;

  /// No description provided for @na_seeLess.
  ///
  /// In en, this message translates to:
  /// **'See Less'**
  String get na_seeLess;

  /// Warning message for age restriction and alcohol.
  ///
  /// In en, this message translates to:
  /// **'You must have to be older than 18yo and abusing alcohol is dangerous for the health'**
  String get ageWarning;

  /// Button text for navigating to the cart.
  ///
  /// In en, this message translates to:
  /// **'Go to Cart'**
  String get goToCart;

  /// Displayed on a button that allows the user to add an item to the shopping cart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get na_addToCart;

  /// Label indicating the number of items in the cart or list.
  ///
  /// In en, this message translates to:
  /// **'Item Count'**
  String get na_itemCount;

  /// Title for the My Cart page.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get myCart;

  /// Displayed when the user's shopping cart is empty.
  ///
  /// In en, this message translates to:
  /// **'No item in cart'**
  String get na_noItemInCart;

  /// Label for the unique identifier of an item.
  ///
  /// In en, this message translates to:
  /// **'Item Id'**
  String get na_itemId;

  /// Label for the subtotal amount in the cart.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// Label for the delivery cost in the cart.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// Label for the total amount in the cart.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Button text for proceeding to checkout from the cart.
  ///
  /// In en, this message translates to:
  /// **'Check Out'**
  String get checkOut;

  /// Title for the Checkout page.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// Label for the information section in the checkout page.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// Placeholder text for the coupon input field.
  ///
  /// In en, this message translates to:
  /// **'Apply Coupon'**
  String get applyCoupon;

  /// Button text for applying a coupon code.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// Message displayed when the coupon is applied successfully.
  ///
  /// In en, this message translates to:
  /// **'Coupon applied successfully'**
  String get applyCouponSuccess;

  /// Button text for proceeding to payment.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// Title for the payment method selection screen.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get selectPaymentMethod;

  /// Label for the option to receive the bill via email.
  ///
  /// In en, this message translates to:
  /// **'Receive the bill by mail'**
  String get receiveBillByEmail;

  /// First part of the success message in the dialog.
  ///
  /// In en, this message translates to:
  /// **'You have successfully placed a party order with friends. Enjoy the event!'**
  String get successMessagePart1;

  /// Displayed when a specific product is not available for purchase.
  ///
  /// In en, this message translates to:
  /// **'This product is out of stock'**
  String get na_productOutOfStock;

  /// Second part of the success message in the dialog.
  ///
  /// In en, this message translates to:
  /// **'with Friends enjoy event!'**
  String get successMessagePart2;

  /// Button text for navigating to the order tracking page.
  ///
  /// In en, this message translates to:
  /// **'Track Order'**
  String get trackOrder;

  /// Button text for navigating to the home page.
  ///
  /// In en, this message translates to:
  /// **'Go to home'**
  String get goToHome;

  /// Button text for adding a new card in the payment method screen.
  ///
  /// In en, this message translates to:
  /// **'Add New Card'**
  String get addNewCard;

  /// Message displayed when the order is successfully placed for a party.
  ///
  /// In en, this message translates to:
  /// **'You Have Successfully Placed order party.'**
  String get orderSuccess;

  /// Message displayed encouraging users to enjoy the event with friends.
  ///
  /// In en, this message translates to:
  /// **'With Friends enjoy event.'**
  String get orderWithFriends;

  /// Label and placeholder for the card number input field.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// Label and placeholder for the card holder name input field.
  ///
  /// In en, this message translates to:
  /// **'Card Holder Name'**
  String get cardHolderName;

  /// Label and placeholder for the expiry date input field.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// Label and placeholder for the CVV input field.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// Button text for adding a new card.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get addCard;

  /// Button text for displaying the QR code dialog.
  ///
  /// In en, this message translates to:
  /// **'Show QR Code'**
  String get showQrCode;

  /// Title for the QR code dialog.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQr;

  /// Instruction text for scanning the QR code.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code for withdraw order'**
  String get qrCodeInstruction;

  /// Warning text for QR code privacy.
  ///
  /// In en, this message translates to:
  /// **'The QR code is personal. Do not share it with anyone. Sharing this code may result in unauthorized access to your order.'**
  String get qrCodeWarning;

  /// Button text for canceling the order.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancelOrder;

  /// Confirmation message that the OTP has been sent successfully for account deletion.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully to delete account'**
  String get na_sendOtpDeleteAccountSuccess;

  /// Displayed when there is an error sending the OTP.
  ///
  /// In en, this message translates to:
  /// **'Error sending OTP'**
  String get na_errorSendOtp;

  /// Title for the My Order page.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrder;

  /// Message indicating that the user has no orders yet.
  ///
  /// In en, this message translates to:
  /// **'No Orders Yet'**
  String get noOrdersYet;

  /// Button text for starting the ordering process.
  ///
  /// In en, this message translates to:
  /// **'Start Ordering'**
  String get startOrdering;

  /// Tab label for viewing all orders.
  ///
  /// In en, this message translates to:
  /// **'All Orders'**
  String get allOrders;

  /// Tab label for viewing completed orders.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Tab label for viewing cancelled orders.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// Button text for leaving a review on an order.
  ///
  /// In en, this message translates to:
  /// **'Leave a review'**
  String get leaveReview;

  /// Button text for reordering a previous order.
  ///
  /// In en, this message translates to:
  /// **'Order Again'**
  String get orderAgain;

  /// Button or prompt encouraging the user to leave a review.
  ///
  /// In en, this message translates to:
  /// **'Write a review'**
  String get na_writeReview;

  /// Indicates that the user's order has been cancelled.
  ///
  /// In en, this message translates to:
  /// **'Order Cancelled'**
  String get na_orderCancel;

  /// Displayed when there are no orders that have been cancelled.
  ///
  /// In en, this message translates to:
  /// **'No cancelled order'**
  String get na_noCancelledOrder;

  /// Title for the recent searches section.
  ///
  /// In en, this message translates to:
  /// **'Recents Search'**
  String get recentsSearch;

  /// Title for the search page.
  ///
  /// In en, this message translates to:
  /// **'Search here'**
  String get searchHere;

  /// Title for the page to create a new pin.
  ///
  /// In en, this message translates to:
  /// **'Create New Pin'**
  String get createNewPin;

  /// Hint text for the confirm new password input field.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// Header text prompting the user to create a new password.
  ///
  /// In en, this message translates to:
  /// **'Create Your New Password'**
  String get createYourNewPassword;

  /// Description text prompting the user to add a PIN for enhanced security.
  ///
  /// In en, this message translates to:
  /// **'Add a Pin Number to Make Your Account\nmore Secure'**
  String get addPinNumber;

  /// Label for the home tab in the seller bottom navigation bar.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottomBarHome;

  /// Label for the stocks tab in the seller bottom navigation bar.
  ///
  /// In en, this message translates to:
  /// **'Stocks'**
  String get bottomBarStocks;

  /// Label for the orders tab in the seller bottom navigation bar.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get bottomBarOrders;

  /// Label for the profile tab in the seller bottom navigation bar.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get bottomBarProfile;

  /// Prompt for seller actions on the Seller Home Page.
  ///
  /// In en, this message translates to:
  /// **'What you wanna \nto do as Seller?'**
  String get sellerHomeActionPrompt;

  /// Label for the switch to enable Responsible Mode.
  ///
  /// In en, this message translates to:
  /// **'Switch to Responsible Mode'**
  String get sellerHomeSwitchToResponsibleMode;

  /// Label for the number of orders taken by the seller.
  ///
  /// In en, this message translates to:
  /// **'Orders Taken'**
  String get sellerHomeOrdersTaken;

  /// Indicates orders taken by the seller.
  ///
  /// In en, this message translates to:
  /// **'by me'**
  String get sellerHomeByMe;

  /// Indicates orders taken by someone else.
  ///
  /// In en, this message translates to:
  /// **'Orders Taken by someone'**
  String get sellerHomeOrdersBySomeone;

  /// Indicates orders currently on hold or waiting.
  ///
  /// In en, this message translates to:
  /// **'Orders on Waiting'**
  String get sellerHomeOrdersOnWaiting;

  /// Section title for pending orders on the Seller Home Page.
  ///
  /// In en, this message translates to:
  /// **'Pending Orders'**
  String get sellerHomePendingOrders;

  /// Button text for finishing an order.
  ///
  /// In en, this message translates to:
  /// **'Finish Order'**
  String get sellerHomeFinishOrder;

  /// Button text for declining an order.
  ///
  /// In en, this message translates to:
  /// **'Decline Order'**
  String get sellerHomeDeclineOrder;

  /// Button text for canceling an order.
  ///
  /// In en, this message translates to:
  /// **'Cancel the Order'**
  String get sellerHomeCancelOrder;

  /// Button text for accepting an order.
  ///
  /// In en, this message translates to:
  /// **'Accept Order'**
  String get sellerHomeAcceptOrder;

  /// Label for the customer section in order details.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get sellerHomeCustomer;

  /// Label for customer contact details in order details.
  ///
  /// In en, this message translates to:
  /// **'contact:'**
  String get sellerHomeContact;

  /// Label for customer address in order details.
  ///
  /// In en, this message translates to:
  /// **'Address:'**
  String get sellerHomeAddress;

  /// Label for a section showing the latest events.
  ///
  /// In en, this message translates to:
  /// **'Most recent events'**
  String get na_mostRecentEvents;

  /// Displayed when there are no recent events to show.
  ///
  /// In en, this message translates to:
  /// **'No recent events'**
  String get na_noRecentEvents;

  /// Displayed when there are no recent orders to show.
  ///
  /// In en, this message translates to:
  /// **'No latest orders available'**
  String get na_noLatestOrdersAvailable;

  /// Displayed when an unexpected error occurs and the user is prompted to retry.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again'**
  String get na_somethingWentWrong;

  /// Displayed when there are no events to show.
  ///
  /// In en, this message translates to:
  /// **'No event available'**
  String get na_noEventAvailable;

  /// Displayed when there are no popular events to show.
  ///
  /// In en, this message translates to:
  /// **'No popular events'**
  String get na_noPopularEvents;

  /// Label for items in order details.
  ///
  /// In en, this message translates to:
  /// **'Items:'**
  String get sellerHomeItems;

  /// Label for the quantity of items in the order details.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get na_sellerHomeQuantity;

  /// Prompt asking the user to input a coupon or discount code.
  ///
  /// In en, this message translates to:
  /// **'Please enter a coupon code'**
  String get na_enterCouponCode;

  /// Label for the price per item in the order details.
  ///
  /// In en, this message translates to:
  /// **'Price/Item'**
  String get na_sellerHomePricePerItem;

  /// Button text for navigating to personal data management.
  ///
  /// In en, this message translates to:
  /// **'Personal Data Management'**
  String get na_personalDataManagement;

  /// Text prompting the user to set up the maximum number of orders they can accept.
  ///
  /// In en, this message translates to:
  /// **'Set up your maximum orders limit..'**
  String get set_up_maximum_orders_limit;

  /// Label for the field where the user sets their maximum order limit.
  ///
  /// In en, this message translates to:
  /// **'Orders Limit'**
  String get orders_limit;

  /// Error message shown when the user doesn't enter a limit for the maximum orders.
  ///
  /// In en, this message translates to:
  /// **'please enter limit'**
  String get please_enter_limit;

  /// Label for the save button.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Title of the page where the seller can create a coupon.
  ///
  /// In en, this message translates to:
  /// **'Generate Coupon'**
  String get generate_coupon;

  /// Label for the discount amount input field.
  ///
  /// In en, this message translates to:
  /// **'Discount Amount'**
  String get discount_amount;

  /// Placeholder text for the discount amount input field.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enter_amount;

  /// Title of the page for creating delivery charges.
  ///
  /// In en, this message translates to:
  /// **'Create Delivery Charges'**
  String get create_delivery_charges;

  /// Label for the base delivery fee input field.
  ///
  /// In en, this message translates to:
  /// **'Base Delivery Fee'**
  String get base_delivery_fee;

  /// Placeholder text for the base delivery fee input field.
  ///
  /// In en, this message translates to:
  /// **'Enter delivery fee'**
  String get enter_delivery_fee;

  /// Label for the delivery fee per kilometer input field.
  ///
  /// In en, this message translates to:
  /// **'Delivery Per Km'**
  String get delivery_per_km;

  /// Placeholder text for the delivery per km input field.
  ///
  /// In en, this message translates to:
  /// **'Enter value'**
  String get enter_value;

  /// Label for the minimum order fee input field.
  ///
  /// In en, this message translates to:
  /// **'Minimum Order Fee'**
  String get minimum_order_fee;

  /// Placeholder text for the minimum order fee input field.
  ///
  /// In en, this message translates to:
  /// **'Order fee'**
  String get order_fee;

  /// Label for the free delivery threshold input field.
  ///
  /// In en, this message translates to:
  /// **'Fee Threshold'**
  String get fee_threshold;

  /// Placeholder text for the fee threshold input field.
  ///
  /// In en, this message translates to:
  /// **'Threshold'**
  String get threshold;

  /// Text on the button to create the delivery charges.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// Label for the discount percentage input field.
  ///
  /// In en, this message translates to:
  /// **'Discount Percentage'**
  String get discount_percentage;

  /// Placeholder text for the discount percentage input field.
  ///
  /// In en, this message translates to:
  /// **'Enter percentage'**
  String get enter_percentage;

  /// Label for the start date input field.
  ///
  /// In en, this message translates to:
  /// **'Valid From'**
  String get valid_from;

  /// Label for the end date input field.
  ///
  /// In en, this message translates to:
  /// **'Valid Until'**
  String get valid_until;

  /// Label for the usage limit input field.
  ///
  /// In en, this message translates to:
  /// **'Usage Limit'**
  String get usage_limit;

  /// Placeholder text for the usage limit input field.
  ///
  /// In en, this message translates to:
  /// **'Enter limit'**
  String get enter_limit;

  /// Text on the button to generate the coupon.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get generate;

  /// Title of the page displaying all coupons.
  ///
  /// In en, this message translates to:
  /// **'All Coupons'**
  String get all_coupons;

  /// Message displayed when no coupons are found.
  ///
  /// In en, this message translates to:
  /// **'No Coupon Found'**
  String get no_coupon_found;

  /// Title of the inbox page for chats
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chats;

  /// Text displayed when no chat is found
  ///
  /// In en, this message translates to:
  /// **'No Chat Found'**
  String get no_chat_found;

  /// Placeholder text for the search bar
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Button text for navigating to application theme settings.
  ///
  /// In en, this message translates to:
  /// **'Application Theme Management'**
  String get na_applicationTheme;

  /// Button text for setting maximum order limits.
  ///
  /// In en, this message translates to:
  /// **'Maximum Order Limits'**
  String get na_maximumOrderLimit;

  /// Button text for navigating to the privacy settings page.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get na_privacy;

  /// Button text for navigating to the FAQs page.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get na_faqs;

  /// Button text for navigating to the help section.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get na_help;

  /// Dialog title for choosing an image source.
  ///
  /// In en, this message translates to:
  /// **'Pick Image'**
  String get na_pickImage;

  /// Option text for selecting the camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get na_pickCamera;

  /// Option text for selecting the gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get na_pickGallery;

  /// Text for the setting option to navigate to the coupons section.
  ///
  /// In en, this message translates to:
  /// **'Coupons'**
  String get coupons;

  /// Text for the setting option to navigate to the delivery charges section.
  ///
  /// In en, this message translates to:
  /// **'Delivery Charges'**
  String get delivery_charges;

  /// Text for the setting option to navigate to the messages section.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// Text for the setting option to navigate to the privacy section.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// Text for the setting option to navigate to the FAQs section.
  ///
  /// In en, this message translates to:
  /// **'FAQS'**
  String get faqs;

  /// Button or label to allow the user to view their profile details.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get na_viewProfile;

  /// Title for the general information section.
  ///
  /// In en, this message translates to:
  /// **'General information'**
  String get general_information;

  /// Text for the setting option to navigate to the help section.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// Text for the setting option to navigate to the language settings.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Text for the button to log out the user.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Text for the option to pick an image.
  ///
  /// In en, this message translates to:
  /// **'Pick Image'**
  String get pick_image;

  /// Text for the camera option to take a photo.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// Text for the gallery option to select an image.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// Heading text for the settings section.
  ///
  /// In en, this message translates to:
  /// **'My Settings'**
  String get na_mySettings;

  /// Heading for the professional account section.
  ///
  /// In en, this message translates to:
  /// **'Professional Account'**
  String get na_professionalAccount;

  /// Subtitle for the professional account section.
  ///
  /// In en, this message translates to:
  /// **'Ask information to manage professional account'**
  String get na_professionalAccountInfo;

  /// Label text for new users prompting to register.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get na_dontHaveAccount;

  /// Button text for navigating to the registration page.
  ///
  /// In en, this message translates to:
  /// **'Register here'**
  String get na_registerHere;

  /// Tagline under the greeting on the homepage.
  ///
  /// In en, this message translates to:
  /// **'Explore things as\nProfessional!'**
  String get explore_responsible;

  /// Label for switching to Seller Mode
  ///
  /// In en, this message translates to:
  /// **'Switch to Seller Mode'**
  String get switch_to_seller_mode;

  /// Label for displaying the registration count for the day.
  ///
  /// In en, this message translates to:
  /// **'Today’s Registrations'**
  String get todays_registrations;

  /// Label for displaying the revenue count for the day.
  ///
  /// In en, this message translates to:
  /// **'Today’s Revenue'**
  String get todays_revenue;

  /// Label for manage catagory
  ///
  /// In en, this message translates to:
  /// **'Manage Catagory'**
  String get manage_catagory;

  /// Title for displaying revenue data of the current week.
  ///
  /// In en, this message translates to:
  /// **'Revenue this week'**
  String get revenue_this_week;

  /// Title for displaying registration data of the current week.
  ///
  /// In en, this message translates to:
  /// **'Registrations this week'**
  String get registrations_this_week;

  /// Hint text for the dropdown input field for selecting an event.
  ///
  /// In en, this message translates to:
  /// **'Select Event'**
  String get switch_toggle_hint;

  /// Title for the support requests page.
  ///
  /// In en, this message translates to:
  /// **'Support Requests'**
  String get support_requests;

  /// Text for the button to initiate a refund.
  ///
  /// In en, this message translates to:
  /// **'Refund Order'**
  String get refund_order;

  /// Hint text for the message input field.
  ///
  /// In en, this message translates to:
  /// **'Enter message...'**
  String get enter_message_hint;

  /// Title of the refund dialog asking what the user wants to refund.
  ///
  /// In en, this message translates to:
  /// **'What You Want to Refund?'**
  String get what_you_want_to_refund;

  /// Text for the cancel button in the refund dialog.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel_button;

  /// Text for the button to proceed with the refund in the refund dialog.
  ///
  /// In en, this message translates to:
  /// **'Refund Item'**
  String get refund_item_button;

  /// Text for the button to proceed with the refund in the refund dialog.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get add_item;

  /// Label for the item name input field.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get item_name;

  /// Label for the item price input field.
  ///
  /// In en, this message translates to:
  /// **'Item Price'**
  String get item_price;

  /// Label for the dropdown to select food category.
  ///
  /// In en, this message translates to:
  /// **'Select Food Category'**
  String get select_food_category;

  /// Label for the dropdown to select event.
  ///
  /// In en, this message translates to:
  /// **'Select Event'**
  String get select_event;

  /// Label for the alcoholic option.
  ///
  /// In en, this message translates to:
  /// **'Alcoholic'**
  String get alcoholic;

  /// Label for the non-alcoholic option.
  ///
  /// In en, this message translates to:
  /// **'Non-Alcoholic'**
  String get non_alcoholic;

  /// Label for the item description input field.
  ///
  /// In en, this message translates to:
  /// **'Item Description'**
  String get item_description;

  /// Label for the start time input field.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get start_time;

  /// Label for the end time input field.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get end_time;

  /// Text for the button to create a new item.
  ///
  /// In en, this message translates to:
  /// **'Create Item'**
  String get create_item;

  /// Label for the menu item that links to the all delivery charges page.
  ///
  /// In en, this message translates to:
  /// **'All Delivery Charges'**
  String get all_delivery_charges;

  /// Label for the menu item that links to the manage events page.
  ///
  /// In en, this message translates to:
  /// **'Manage Events'**
  String get manage_events;

  /// Label for the menu item that links to the sales report page.
  ///
  /// In en, this message translates to:
  /// **'Sales report'**
  String get sales_report;

  /// Label for the menu item that links to the orders page.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// Label for the menu item that links to the add events page.
  ///
  /// In en, this message translates to:
  /// **'Add Events'**
  String get add_events;

  /// Label for the menu item that links to the add seller bank account page.
  ///
  /// In en, this message translates to:
  /// **'Add Seller Bank Account'**
  String get add_seller_bank_account;

  /// Label for the menu item that links to the change password page.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// Label for the menu item that links to the add event category page.
  ///
  /// In en, this message translates to:
  /// **'Add Event Category'**
  String get add_event_category;

  /// Title for the order list page.
  ///
  /// In en, this message translates to:
  /// **'Order List'**
  String get order_list;

  /// Title for the manage food items page.
  ///
  /// In en, this message translates to:
  /// **'Manage Food Items'**
  String get manage_food_items;

  /// Title for the app language page.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get app_language;

  /// Text for selecting a language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// Text for updating an item.
  ///
  /// In en, this message translates to:
  /// **'Update Item'**
  String get update_item;

  /// Text for editing an item.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get edit_item;

  /// Label or title for the process or option to change the user's email address.
  ///
  /// In en, this message translates to:
  /// **'Email Change'**
  String get na_emailChange;

  /// Warning message prompting the user to complete all required input fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all inputs'**
  String get na_fillAllInputs;

  /// Instructional text asking the user to input the email address they want to change.
  ///
  /// In en, this message translates to:
  /// **'Enter email to change'**
  String get na_enterEmailToChange;

  /// Prompt asking the user to enter an email address that has been verified.
  ///
  /// In en, this message translates to:
  /// **'Please enter verified email'**
  String get na_enterVerifiedEmail;

  /// Message shown when the item is created successfully.
  ///
  /// In en, this message translates to:
  /// **'Item created successfully'**
  String get item_created_successfully;

  /// Message shown to congratulate the user for creating an item.
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congratulations;

  /// Message shown after the item creation confirmation.
  ///
  /// In en, this message translates to:
  /// **'You Have Successfully Created a New Item'**
  String get item_created_message;

  /// Button text to view the created item.
  ///
  /// In en, this message translates to:
  /// **'View Item'**
  String get view_item;

  /// Button text for disconnecting the account.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get na_disconnect;

  /// Menu item text for navigating to account management.
  ///
  /// In en, this message translates to:
  /// **'Manage Account'**
  String get na_manageAccount;

  /// Menu item text for modifying the establishment details.
  ///
  /// In en, this message translates to:
  /// **'Modify the establishment'**
  String get na_modifyEstablishment;

  /// Menu item text for managing events.
  ///
  /// In en, this message translates to:
  /// **'Manage Events'**
  String get na_manageEvents;

  /// Menu item text for viewing the sales report.
  ///
  /// In en, this message translates to:
  /// **'Sales report'**
  String get na_salesReport;

  /// Menu item text for accessing app settings.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get na_settings;

  /// Menu item text for managing payment methods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get na_paymentMethods;

  /// Menu item text for transferring money.
  ///
  /// In en, this message translates to:
  /// **'Transfer Money'**
  String get na_transferMoney;

  /// Menu item text for viewing orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get na_orders;

  /// Menu item text for adding new events.
  ///
  /// In en, this message translates to:
  /// **'Add Events'**
  String get na_addEvents;

  /// Section title for seller accounts in the manage accounts page.
  ///
  /// In en, this message translates to:
  /// **'Seller Accounts'**
  String get na_sellerAccounts;

  /// Section title for responsible accounts in the manage accounts page.
  ///
  /// In en, this message translates to:
  /// **'Responsible Accounts'**
  String get na_responsibleAccounts;

  /// Button text for adding a new seller account.
  ///
  /// In en, this message translates to:
  /// **'Add Seller Account'**
  String get na_addSellerAccount;

  /// Title for the page where a seller account is created.
  ///
  /// In en, this message translates to:
  /// **'Create Seller Account'**
  String get na_createSellerAccount;

  /// Description of the purpose of the form to create a seller account.
  ///
  /// In en, this message translates to:
  /// **'Ask information to manage seller account'**
  String get na_askInformationToManageSellerAccount;

  /// Label for the attributed event field in the seller account form.
  ///
  /// In en, this message translates to:
  /// **'Attributed Event'**
  String get na_attributedEvent;

  /// Message displayed after a seller account is successfully created.
  ///
  /// In en, this message translates to:
  /// **'Seller account has been created'**
  String get na_sellerAccountCreated;

  /// Message select event catagory.
  ///
  /// In en, this message translates to:
  /// **'Select Event Catagory'**
  String get select_event_catagory;

  /// Text on the button to create a new seller account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get na_createAccount;

  /// Title for the edit seller profile page.
  ///
  /// In en, this message translates to:
  /// **'Edit Seller Profile'**
  String get na_editSellerProfile;

  /// Button text for saving the changes made to the seller profile.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get na_saveChanges;

  /// Label for the total sales amount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get na_totalAmount;

  /// Button text for withdrawing the total amount.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get na_withdraw;

  /// Label for the section showing items sold.
  ///
  /// In en, this message translates to:
  /// **'Items Sold'**
  String get na_itemsSold;

  /// Label for the sales category breakdown.
  ///
  /// In en, this message translates to:
  /// **'By Category'**
  String get na_byCategory;

  /// Label for the most sold item section.
  ///
  /// In en, this message translates to:
  /// **'Most Sold Item'**
  String get na_mostSoldItem;

  /// Label for the seller's activity section.
  ///
  /// In en, this message translates to:
  /// **'Seller\'s Activity'**
  String get na_sellersActivity;

  /// Section label for the top products in the sales report.
  ///
  /// In en, this message translates to:
  /// **'Top Products'**
  String get na_topProducts;

  /// Title for the page where a new event can be added.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get na_addEvent;

  /// Label for uploading event photos.
  ///
  /// In en, this message translates to:
  /// **'Upload Photos'**
  String get na_uploadPhotos;

  /// Label for the event name input field.
  ///
  /// In en, this message translates to:
  /// **'Event Name'**
  String get na_eventName;

  /// Label for the event category input field.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get na_eventCategory;

  /// Label for the event address input field.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get na_eventAddress;

  /// Label for the event opening days input field.
  ///
  /// In en, this message translates to:
  /// **'Opening Days'**
  String get na_openingDays;

  /// Label for the event description input field.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get na_eventDescription;

  /// Button text for creating a new event.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get na_createEvent;

  /// Title for the add bank account page.
  ///
  /// In en, this message translates to:
  /// **'Add Bank Account'**
  String get add_bank_account;

  /// Label for the bank name field.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bank_name;

  /// Label for the account number field.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get account_number;

  /// Label for the account type field.
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get account_type;

  /// Label for the account holder name field.
  ///
  /// In en, this message translates to:
  /// **'Account Holder Name'**
  String get account_holder_name;

  /// Label for the email address field.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email_address;

  /// Title for the all events page.
  ///
  /// In en, this message translates to:
  /// **'All Events'**
  String get all_events;

  /// Title for the event details page.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get event_details;

  /// Button text to edit the event details.
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get edit_event;

  /// Title for the page where the user can add a payment method.
  ///
  /// In en, this message translates to:
  /// **'Add Payment method'**
  String get na_addPaymentMethod;

  /// Message displayed when no payment methods are found.
  ///
  /// In en, this message translates to:
  /// **'No Payment Found'**
  String get na_noPaymentFound;

  /// Instruction text informing the user that they can add or edit payment methods during checkout.
  ///
  /// In en, this message translates to:
  /// **'You can add and edit payments during checkout'**
  String get na_addAndEditPayments;

  /// Button text for adding a payment method.
  ///
  /// In en, this message translates to:
  /// **'Add Payment Method'**
  String get na_addPaymentMethodButton;

  /// Label for the name field on the payment card.
  ///
  /// In en, this message translates to:
  /// **'Name on Card'**
  String get na_nameOnCard;

  /// Label for the card number field.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get na_cardNumber;

  /// Label for the CVC field on the payment card.
  ///
  /// In en, this message translates to:
  /// **'CVC'**
  String get na_cvc;

  /// Button text to add the payment method.
  ///
  /// In en, this message translates to:
  /// **'Add now'**
  String get na_addNow;

  /// Description of the CVC field.
  ///
  /// In en, this message translates to:
  /// **'3 or 4 digits usually found on the signature strip'**
  String get na_cvcInfo;

  /// Message displayed when the payment method is successfully added.
  ///
  /// In en, this message translates to:
  /// **'Payment method added successfully'**
  String get na_paymentMethodAdded;

  /// Title for the money transfer page.
  ///
  /// In en, this message translates to:
  /// **'Money Transfer'**
  String get na_moneyTransfer;

  /// Label for the account number input field.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get na_accountNumber;

  /// Title for the page where the user selects a card.
  ///
  /// In en, this message translates to:
  /// **'Select a Card'**
  String get na_selectCard;

  /// Label for the amount input field in the card selection page.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get na_enterAmount;

  /// Description text prompting the user to enter the amount for money transfer.
  ///
  /// In en, this message translates to:
  /// **'Please, enter the amount of money transfer in below field.'**
  String get na_descriptionText;

  /// Button text for proceeding to the next step.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get na_next;

  /// Message indicating that the order is being processed, followed by a list of ordered items.
  ///
  /// In en, this message translates to:
  /// **'is being processed. You’ve ordered:'**
  String get na_orderBeingProcessed;

  /// Indicates that the user's order is prepared and ready for pickup or delivery.
  ///
  /// In en, this message translates to:
  /// **'Order Ready'**
  String get na_orderReady;

  /// Phrase used to indicate the total amount or cost.
  ///
  /// In en, this message translates to:
  /// **'for a total of'**
  String get na_forTotalOf;

  /// Title for the page where the user selects a bank for money transfer.
  ///
  /// In en, this message translates to:
  /// **'Select a Bank'**
  String get na_selectBank;

  /// Description text prompting the user to select a bank for transferring money.
  ///
  /// In en, this message translates to:
  /// **'Please, select a bank from which you want to do the money transfer.'**
  String get na_selectBankDescription;

  /// Used to indicate the starting point of a range, such as a price or date.
  ///
  /// In en, this message translates to:
  /// **'from'**
  String get na_from;

  /// Title for the page where the user verifies their phone number.
  ///
  /// In en, this message translates to:
  /// **'Verify your Number'**
  String get na_verifyNumber;

  /// Description prompting the user to verify their phone number.
  ///
  /// In en, this message translates to:
  /// **'Please verify your\nPhone Number'**
  String get na_verifyPhoneNumber;

  /// Label for the field where the user enters the 5-digit verification code.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code (5-digit)'**
  String get na_enterVerificationCode;

  /// Title for the page where the user tops up their SIM card.
  ///
  /// In en, this message translates to:
  /// **'Top-up Sim Card'**
  String get na_topUpSimCard;

  /// Label for the mobile phone number field.
  ///
  /// In en, this message translates to:
  /// **'Mobile Phone No.'**
  String get na_mobilePhoneNumber;

  /// Description prompting the user to enter the mobile phone number.
  ///
  /// In en, this message translates to:
  /// **'Please, enter the Sim Card Number in below field.'**
  String get na_enterMobileNumber;

  /// Validation message when the mobile phone number field is empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your mobile number'**
  String get na_mobileNumberValidation;

  /// Title for the page where the user enters the top-up amount.
  ///
  /// In en, this message translates to:
  /// **'Top-up Amount'**
  String get na_topUpAmount;

  /// Description prompting the user to enter the top-up amount.
  ///
  /// In en, this message translates to:
  /// **'Please, enter the amount of Sim Card Number Top-up in below field.'**
  String get na_topUpAmountDescription;

  /// Displayed when there are no upcoming or nearby events to show.
  ///
  /// In en, this message translates to:
  /// **'No nearest event found'**
  String get na_noNearestEventFound;

  /// Description prompting the user to select a SIM card service for the top-up.
  ///
  /// In en, this message translates to:
  /// **'Please, select a Sim Card Service on which you want to Top-up.'**
  String get na_selectSimCardService;

  /// Error message shown when the user attempts to proceed without selecting a SIM card.
  ///
  /// In en, this message translates to:
  /// **'Please select a SIM card'**
  String get na_selectSimError;

  /// Title for the page where the user can dd a new category.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get na_addCategory;

  /// Prompt to let the user choose the source of an image (camera, gallery, etc.).
  ///
  /// In en, this message translates to:
  /// **'Select Image Source'**
  String get na_selectImageSource;

  /// Displayed when there are no categories available to show.
  ///
  /// In en, this message translates to:
  /// **'No category found'**
  String get na_noCategoryFound;

  /// Text prompting the user to upload an icon for the category.
  ///
  /// In en, this message translates to:
  /// **'Upload Icon'**
  String get na_uploadIcon;

  /// Label for the input field where the user enters the category name.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get na_categoryName;

  /// Title for the all event categories page.
  ///
  /// In en, this message translates to:
  /// **'All Event Categories'**
  String get all_event_categories;

  /// Validation message when the category name field is empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter a category name'**
  String get na_categoryNameValidation;

  /// Message displayed when a category is successfully added.
  ///
  /// In en, this message translates to:
  /// **'Category added successfully'**
  String get na_categoryAdded;

  /// Prompt asking the user to select an image for the category.
  ///
  /// In en, this message translates to:
  /// **'Please select an image for the category'**
  String get na_selectCategoryImage;

  /// Title for the page where the user creates a new item.
  ///
  /// In en, this message translates to:
  /// **'Create Item'**
  String get na_createItem;

  /// Label for the input field where the user enters the item name.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get na_itemName;

  /// Label for the input field where the user enters the item price.
  ///
  /// In en, this message translates to:
  /// **'Item Price'**
  String get na_itemPrice;

  /// Label for the input field where the user selects the item category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get na_itemCategory;

  /// Label for the input field where the user specifies if the item contains alcohol.
  ///
  /// In en, this message translates to:
  /// **'Type of Alcohol or not?'**
  String get na_alcoholType;

  /// Label for the input field where the user enters the item description.
  ///
  /// In en, this message translates to:
  /// **'Item Description'**
  String get na_itemDescription;

  /// Label for the input field where the user specifies the item's timings.
  ///
  /// In en, this message translates to:
  /// **'Timings'**
  String get na_itemTimings;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
