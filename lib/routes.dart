import 'package:flutter/widgets.dart';
import 'package:tu_pension/ui/screens/favorite/favorite_screen.dart';
import 'package:tu_pension/ui/screens/chat/chat_list_screen.dart';
import 'package:tu_pension/ui/screens/complete_profile/complete_profile_screen.dart';
import 'package:tu_pension/ui/screens/details/details_screen.dart';
import 'package:tu_pension/ui/screens/home/components/random_pension.dart';
import 'package:tu_pension/ui/screens/new_pension_details/details_screen.dart';
import 'package:tu_pension/ui/screens/error/error_screen.dart';
import 'package:tu_pension/ui/screens/forgot_password/forgot_password_screen.dart';
import 'package:tu_pension/ui/screens/home/home_screen.dart';
import 'package:tu_pension/ui/screens/login_success/login_success_screen.dart';
import 'package:tu_pension/ui/screens/otp/otp_screen.dart';
import 'package:tu_pension/ui/screens/pension_details/details_screen.dart';
import 'package:tu_pension/ui/screens/profile/profile_screen.dart';
import 'package:tu_pension/ui/screens/register_success/register_success_screen.dart';
import 'package:tu_pension/ui/screens/sign_in/sign_in_screen.dart';
import 'package:tu_pension/ui/screens/sign_up/sign_up_screen.dart';
import 'package:tu_pension/ui/screens/splash/splash_screen.dart';
import 'package:tu_pension/ui/screens/user_pension_list/user_pension_list_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  RegisterSuccessScreen.routeName: (context) => RegisterSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  FavoriteScreen.routeName: (context) => FavoriteScreen(),
  CreatePensionDetailScreen.routeName: (context) => CreatePensionDetailScreen(),
  UserPensionListScreen.routeName: (context) => UserPensionListScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ErrorScreen.routeName: (context) => ErrorScreen(),
  ChatListScreen.routeName: (context) => ChatListScreen(),
  RandomPensions.routeName: (context) => RandomPensions(),
  PensionDetailsScreen.routeName: (context) => PensionDetailsScreen(),
};
