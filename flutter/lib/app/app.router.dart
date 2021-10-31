// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../models/prediction_file_history_model.dart';
import '../views/ui/about%20businesses/about_businesses_view.dart';
import '../views/ui/about%20developers/about_developers_view.dart';
import '../views/ui/add%20file/add_file_view.dart';
import '../views/ui/home/home_view.dart';
import '../views/ui/landing/landing_view.dart';
import '../views/ui/login/login_view.dart';
import '../views/ui/prediction/prediction_view.dart';
import '../views/ui/signup/signup_view.dart';

class Routes {
  static const String about_business = '/about-businesses-view';
  static const String about_developers = '/about-developers-view';
  static const String add_file = '/add-file-view';
  static const String home = '/home-view';
  static const String landing = '/';
  static const String login = '/login-view';
  static const String prediction = '/prediction-view';
  static const String signup = '/signup-view';
  static const all = <String>{
    about_business,
    about_developers,
    add_file,
    home,
    landing,
    login,
    prediction,
    signup,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.about_business, page: AboutBusinessesView),
    RouteDef(Routes.about_developers, page: AboutDevelopersView),
    RouteDef(Routes.add_file, page: AddFileView),
    RouteDef(Routes.home, page: HomeView),
    RouteDef(Routes.landing, page: LandingView),
    RouteDef(Routes.login, page: LoginView),
    RouteDef(Routes.prediction, page: PredictionView),
    RouteDef(Routes.signup, page: SignupView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    AboutBusinessesView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AboutBusinessesView(),
        settings: data,
      );
    },
    AboutDevelopersView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AboutDevelopersView(),
        settings: data,
      );
    },
    AddFileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddFileView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    LandingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LandingView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    PredictionView: (data) {
      var args = data.getArgs<PredictionViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PredictionView(
          key: args.key,
          history: args.history,
        ),
        settings: data,
      );
    },
    SignupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SignupView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// PredictionView arguments holder class
class PredictionViewArguments {
  final Key? key;
  final History history;
  PredictionViewArguments({this.key, required this.history});
}
