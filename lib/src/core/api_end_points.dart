class ApiEndpoints {
  static const String baseUrl = 'https://copcup.miftatech.com/api';

  static const String baseImageUrl = 'https://copcup.miftatech.com/public/';
  static const int id = 1;

  /// ############################# [Auth] #############################
  static const String sendOtp = '$baseUrl/send-otp';
  static const String verifyOtp = '$baseUrl/verify-otp';
  static const String register = '$baseUrl/register';
  static const String login = '$baseUrl/login';
  static const String forgotPassword = '$baseUrl/forgot-password';
  static const String passwordReset = '$baseUrl/password/reset';
  static const String verifyResetOtp = '$baseUrl//verify-reset-otp';
  static const String verifyOtpforResetPassword = '$baseUrl/verify-reset-otp';
  static const String firebaseLogin = '$baseUrl/firebase-login';
  static const String updateProfile = '$baseUrl/updateProfile';
  static const String requestOtpForDelete = '$baseUrl/request-otp';
  static const String deleteProfile = '$baseUrl/delete-account';

  /// ############################# [food catgory] #############################
  static const String createFoodCatagory = '$baseUrl/create-food-category';
  static const String allFoodCategory = '$baseUrl/all-food-categories';
  static const String responsibleFoodCategory =
      '$baseUrl/professional-food-categories';

  static const String deleteFoodCategory = '$baseUrl/delete-food-category';
  static const String updateFoodCategory = '$baseUrl/update-food-category';

  /// ############################# [food Item] #############################
  static const String createFoodItem = '$baseUrl/create-food-item';
  static const String allFoodItem = '$baseUrl/all-food-items';
  static const String professionalFoodItem = '$baseUrl/professional-food-items';

  static const String professionalFoodcategory =
      '$baseUrl/professional-food-categories';

  static const String deleteFoodItem = '$baseUrl/delete-food-item';
  static const String updateFoodItem = '$baseUrl/update-food-item';
  static const String searchFoodItem = '$baseUrl/search/food';
  static const String foodItemss = '$baseUrl/food-item';

  static const String outOfStockFoodItem = '/out-of-stock';
  static const String InStockFoodItem = '/in-stock';

  /// ############################# [Event Categories] #############################
  static const String allEventsCategory = '$baseUrl/all-event-categories';
  static const String deleteEventCategory = '$baseUrl/delete-event-category';
  static const String addEventCategory = '$baseUrl/create-event-category';
  static const String updateEventCategory = '$baseUrl/update-event-category';
  static const String userEventCatagory =
      '$baseUrl/event-category/userEventCategories';

  /// ############################# [Event] #############################
  static const String allEvents = '$baseUrl/allEvents';
  static const String userEvents = '$baseUrl/events/user_events';
  static const String userEventsNearby = '$baseUrl/events/nearby';

  static const String addEvent = '$baseUrl/createEvent';
  static const String updateEvent = '$baseUrl/updateEvent';
  static const String deleteEvent = '$baseUrl/deleteEvent/';
  static const String searchEvent = '$baseUrl/searchEvents';
  static const String searchprofessionalFoodItem =
      '$baseUrl/search/professionalfood';

  static const String getRecentSearches = '$baseUrl/getRecentSearches';
  static const String professionalRecentSearch =
      '$baseUrl/search/foodsearchHistory';
  static const String deleteRecentSearches = '$baseUrl/deleteRecentSearches';
  static const String deleteProfessionalSearch =
      '$baseUrl/search/deleteRecentSearches';
  static const String getAllRecentSearches = '$baseUrl/allRecentSearches';
  static const String getMostPopularEvent = '$baseUrl/getMostPopularEvents';
  static const String getMostRecentEvents = '$baseUrl/getMostRecentEvents';
  static const String getlatestOrders = '$baseUrl/latestOrder';
  static const String cartOrderStatus = '$baseUrl/getCartStatus';

  static const String details = 'details';
  static const String events = '$baseUrl/events/';
  static const String favorite = '/favorite';
  static const String favourite = 'favorites';
  static const String setUserLocation = '$baseUrl/setLocation';
  static const String nearbyEvents = 'nearby';
  static const String getUserAllOrders = '$baseUrl/user_all_Orders';
  static const String professionalOrders = '$baseUrl/professionalOrders';

  static const String singleEventDetail = '$baseUrl/singleEvent';
  static const String foodCatgory = '$baseUrl/food-category';
  static const String foodItem = 'items';
  static const String user = '$baseUrl/user/';
  static const String deleteUser = '$baseUrl/deleteUser';
  static const String specificCatagoryEvents =
      '$baseUrl/categoryWithSpecifiedEvents';
  static const String associateEstablishmentWithEvent =
      '$baseUrl/associate-establishment-with-event';
  static const String professionalEvents = '$baseUrl/professionalEvents';
  static const String professionalUnAssignedEvents =
      '$baseUrl/unassignedEvents';

  /// ############################# [Contact Us] #############################
  static const String contactUs = '$baseUrl/contactUs';
  static const String sellerCreateBankAccount =
      '$baseUrl/Accounts/storeAccount';
  static const String getAllUserMessages = '$baseUrl/getAllUserMessages';

  /// ############################# [ Responsible Auth] #############################

  static const String addProfessionalAccount =
      '$baseUrl/add-professional-account';
  static const String professionalVerifyPin =
      '$baseUrl/verify-professional-pin';
  static const String allSellers = '$baseUrl/allSellers';
  static const String allProfessionals = '$baseUrl/allprofessionals';
  static const String professionalDetails = '$baseUrl/professionalDetail';
  static const String changeEmail = '$baseUrl/email/change-request';
  static const String verifyEmail = '$baseUrl/email/verify';
  static const String editProfessionalAccount =
      '$baseUrl/edit-professional-account';

  /// ############################# [Cart] #############################
  static const String addToCart = '$baseUrl/addToCart';
  static const String getAllCarts = '$baseUrl/allCarts';
  static const String removeFromCart = '$baseUrl/removeFromCart';

  /// ############################# [LogOut] #############################
  static const String logOut = '$baseUrl/logout';

  /// ############################# [GetUser] #############################
  static const String getUser = '$baseUrl/getUser';

  /// ############################# [Seller] #############################
  static const String addSellerAccount = '$baseUrl/add-seller-account';
  static const String verifySellerPin = '$baseUrl/verify-seller-pin';
  static const String editSellerProfile = '$baseUrl/edit-seller-account';
  // static const String removeFromCart = '$baseUrl/removeFromCart';

  /// ############################# [Payment] #############################
  static const String makePayment = '$baseUrl/payment-intent/create';
  static const String paymentSuccess = '$baseUrl/payment';
  static const String finalizeOrder = '$baseUrl/finalize-order';

  /// ############################# [Order] #############################
  static const String allOrders = '$baseUrl/allOrders';
  static const String confirmOrder = '$baseUrl/order/confirm';
  static const String declineOrder = '$baseUrl/order/decline';
  static const String orderReady = '$baseUrl/order/ready';
  static const String orderLimit = '$baseUrl/order/setOrderLimit';
  static const String targetOrder = '$baseUrl/order';
  static const String cancelOrder = '$baseUrl/order';
  static const String verifyQrCode = '$baseUrl/order/verify-qr-code';
  static const String userTransaction = '$baseUrl/user/transactions';

  /// ############################# [Coupons] #############################
  static const String generateCoupon = '$baseUrl/coupons/generate';
  static const String validateCoupon = '$baseUrl/coupons/validate';
  static const String allCouponsOfSeller = '$baseUrl/coupons/seller';

  /// ############################# [DeliveryCharges] #############################
  static const String createDeliveryCharges = '$baseUrl/delivery-charges';
  static const String deliveryCharges = '$baseUrl/delivery-charges';
  static const String deleteDeliveryCharges = '$baseUrl/delivery-charges/';

  /// ############################# [Chats] #############################
  static const String createChatRoom = '$baseUrl/createChatRoom';
  static const String listChatRooms = '$baseUrl/listChatRooms';
  static const String archiveChatRoom = '$baseUrl/archiveChatRoom';
  static const String sendMessage = '$baseUrl/sendMessage';
  static const String listMessages = '$baseUrl/listMessages';
  static const String deleteMessage = '$baseUrl/deleteMessage';
  static const String markAsRead = '$baseUrl/markAsRead';

  /// ############################# [ Admin Auth] #############################
  static const String adminLogin = '$baseUrl/adminLogin';
  static const String verifyAdminOtp = '$baseUrl/verify-admin-otp';

  /// ############################# [User Management] #############################
  static const String getAllUsers = '$baseUrl/allUsers';
  static const String incomingRequestProfessional = '$baseUrl/IncomingRequest';
  static const String approveRequestProfessional =
      '$baseUrl/approveProfessionalRequest';
  static const String rejectRequestProfessional =
      '$baseUrl/rejectProfessionalRequest';
  static const String createUser = '$baseUrl/createUser';
  static const String updateUser = '$baseUrl/updateProfile';
  static const String deleteUsers = '$baseUrl/deleteUser';

  /// ############################# [Promo Codes] #############################
  static const String createPromoCodes = '$baseUrl/promocodes/create';
  static const String allPromoCodes = '$baseUrl/promocodes';

  static const String logoutAdmin = '$baseUrl/logout';
  static const String changePassword = '$baseUrl/change-password';

  /// ############################  [ create event category] #########################
  static const String createCategory = '$baseUrl/create-event-category';
  static const String getCategory = '$baseUrl/all-event-categories';

  ///############################## [ professional renevue ] ########################
  static const String professionalRenevue =
      '$baseUrl/professional-dashboard/establishment-trend';

  static const String allProfessionalIncome =
      '$baseUrl/total-establishment-revenue-across-events';

  static const String delteAllChatHistory =
      '$baseUrl/search/deleteCurrentUserHistory';
  static const String professionalweeklyGraph =
      '$baseUrl/professional-dashboard/weekgraph';
  static const String createStripAccount = '$baseUrl/create-stripe-account';

//##############################[  responsible create pin code    ]

  static const createPinCode = '$baseUrl/set-pin';
  static const loginPinCode = '$baseUrl/verify-pin';
}
