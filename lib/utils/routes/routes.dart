import 'package:flutter/material.dart';
import '../../view/auth_view/login_screen.dart';
import '../../view/auth_view/register_screen.dart';
import '../../view/navigation_view/navigationbar.dart';
import '../../view/notification_view/guest_info_screen.dart';
import '../../view/onbording_view/onboarding_screen.dart';
import '../../view/splash_view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RoutesName.onboarding:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RoutesName.forgotPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
      case RoutesName.checkMailScreen:
        return MaterialPageRoute(
          builder: (context) => const CheckMailScreen(),
        );
      case RoutesName.changePasswordScreen:
        return MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(
            isForget: false,
          ),
        );
      case RoutesName.changePasswordScreenWithBackBtn:
        return MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(
            isForget: true,
          ),
        );
      case RoutesName.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case RoutesName.findMyBookingScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final isexpired = args['isexpired'];
        return MaterialPageRoute(
          builder: (context) => FindMyBookingScreen(
            isBackButton: false,
            isexpired: isexpired,
          ),
        );
      case RoutesName.findMyBookingScreenWithBackBtn:
        return MaterialPageRoute(
          builder: (context) => FindMyBookingScreen(
            isBackButton: true,
            isexpired: true,
          ),
        );
      case RoutesName.foundGuestScreen:
        return MaterialPageRoute(
          builder: (context) => const FoundGuestScreen(),
        );
      case RoutesName.yourInterestsScreen:
        return MaterialPageRoute(
          builder: (context) => const YourInterestsScreen(),
        );
      case RoutesName.navigation:
        return MaterialPageRoute(
          builder: (context) => CustomNavigationBar(
            selectedIndex: 0,
          ),
        );
      case RoutesName.orderNavigation:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['order_id'];
        return MaterialPageRoute(
          builder: (context) => CustomNavigationBar(
            selectedIndex: 2,
            orderId: id,
          ),
        );
      case RoutesName.seeAllScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final serviceListDetails =
            args['serviceListDetails'] as GetServiceListModel;
        return MaterialPageRoute(
          builder: (context) => SeeAllScreen(
            serviceListDetails: serviceListDetails,
          ),
        );
      case RoutesName.checkInViewScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final ischeckIn = args['ischeckin'];
        return MaterialPageRoute(
          builder: (context) => CheckView(
            isCheckInFlow: ischeckIn,
          ),
        );
      case RoutesName.serviceScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final propertyId = args['propertyid'];
        final id = args['id'];
        final name = args['name'];
        final isNotification = args['isnotification'];
        final status = args['status'];
        return MaterialPageRoute(
          builder: (context) => TransportScreen(
            propertyId: propertyId,
            id: id.toString(),
            name: name,
            isFromNotification: isNotification,
            status: status,
          ),
        );
      case RoutesName.bookServiceScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'];
        return MaterialPageRoute(
          builder: (context) => BookServices(id: id),
        );
      case RoutesName.damageScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final orderId = args['orderid'];
        final isDamage = args['isdamage'];
        return MaterialPageRoute(
          builder: (context) => DamageScreen(
            orderId: orderId,
            isDamagePage: isDamage,
          ),
        );
      case RoutesName.subserviceScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'];
        return MaterialPageRoute(
          builder: (context) => TransportServices(
            id: id,
          ),
        );
      case RoutesName.notificationScreen:
        return MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        );
      case RoutesName.chatScreen:
        return MaterialPageRoute(
          builder: (context) => ChatScreen(),
        );
      case RoutesName.serviceFeedbackScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final orderList = args['orderlist'];
        final index = args['index'];
        return MaterialPageRoute(
          builder: (context) =>
              ServicesFeedback(getOrderListModel: orderList, index: index),
        );
      case RoutesName.serviceFeedbackInNotificationScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final orderList = args['orderlist'];
        return MaterialPageRoute(
          builder: (context) =>
              ServicesFeedbackInNotification(getOrderListModel: orderList),
        );
      case RoutesName.chatDetailScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final name = args['name'];
        final profilePic = args['profilepic'];
        return MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
                  name: name,
                  image: profilePic,
                ));
      case RoutesName.paymentServiceScreen:
        return MaterialPageRoute(
          builder: (context) => const PaymentServices(),
        );
      case RoutesName.paymentServiceScreenWithPayment:
        return MaterialPageRoute(
          builder: (context) => PaymentSettings(isPay: true),
        );
      case RoutesName.checkoutScreen:
        return MaterialPageRoute(
          builder: (context) => const CheckoutScreen(),
        );
      case RoutesName.satisfactoryQuestionaireScreen:
        return MaterialPageRoute(
          builder: (context) => const SatisfactionaryQuestion(),
        );
      case RoutesName.paymentSettingScreen:
        return MaterialPageRoute(
          builder: (context) => PaymentSettings(isPay: false),
        );
      case RoutesName.orderCompleteScreen:
        return MaterialPageRoute(
          builder: (context) => const OrderComplete(),
        );
      case RoutesName.pdfviewScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final urlPDFPath = args['urlPDFPath'];
        return MaterialPageRoute(
            builder: (context) => PdfViewPage(url: urlPDFPath));
      case RoutesName.completeFeedbackScreen:
        return MaterialPageRoute(
          builder: (context) => CompleteFeedback(),
        );
      case RoutesName.guestInfoScreen:
        Map<String, String> emptyMap = {};
        return MaterialPageRoute(
          builder: (context) => GuestInfoScreen(
            isBasket: false,
            data: emptyMap,
          ),
        );
      case RoutesName.guestInfoScreenWithBasket:
        final args = settings.arguments as Map<String, dynamic>;
        final data = args['data'];
        return MaterialPageRoute(
          builder: (context) => GuestInfoScreen(
            isBasket: true,
            data: data,
          ),
        );
      case RoutesName.thankYouContactScreen:
        return MaterialPageRoute(
          builder: (context) => const ContactUs2(),
        );
      case RoutesName.addNewCardScreen:
        return MaterialPageRoute(
          builder: (context) => const AddNewCard(),
        );
      case RoutesName.editProfileScreen:
        Map<String, String> emptyMap = {};
        return MaterialPageRoute(
          builder: (context) => EditProfile(
            isBasket: false,
            data: emptyMap,
          ),
        );
      case RoutesName.editProfileScreenWithBasket:
        final args = settings.arguments as Map<String, dynamic>;
        final data = args['data'];
        return MaterialPageRoute(
          builder: (context) => EditProfile(
            isBasket: true,
            data: data,
          ),
        );
      case RoutesName.favouriteScreen:
        return MaterialPageRoute(
          builder: (context) => const FavouriteScreen(),
        );
      case RoutesName.contactUsScreen:
        return MaterialPageRoute(
          builder: (context) => ContactUs(),
        );
      case RoutesName.faqScreen:
        return MaterialPageRoute(
          builder: (context) => const FAQsScreen(),
        );
      case RoutesName.tncScreen:
        return MaterialPageRoute(
          builder: (context) => const TermAndCondition(),
        );
      case RoutesName.feedbackScreen:
        return MaterialPageRoute(
          builder: (context) => FeedbackScreen(),
        );
      case RoutesName.privacyPolicyScreen:
        return MaterialPageRoute(
          builder: (context) => const PrivacyPolicy(),
        );
      case RoutesName.checkCompleteScreen:
        return MaterialPageRoute(
          builder: (context) => const CheckComplete(),
        );
      case RoutesName.searchScreen:
        return MaterialPageRoute(
          builder: (context) => SearchScreen(),
        );
      case RoutesName.myOrderScreen:
        return MaterialPageRoute(
          builder: (context) => MyOrderScreen(
            isNext: true,
            orderId: '0',
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
    }
  }
}
