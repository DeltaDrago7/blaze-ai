import 'package:flutter/material.dart';


import 'package:blazemobile/screens/chatbot/chatbot-general.dart';
import 'package:blazemobile/screens/education-screens/education-module-progress.dart';
import 'package:blazemobile/screens/education-screens/education-questions.dart';
import 'package:blazemobile/screens/education-screens/education-lesson.dart';
import 'package:blazemobile/screens/main-screens/discover-playlist.dart';
import 'package:blazemobile/screens/main-screens/learn.dart';
import 'package:blazemobile/screens/main-screens/home.dart';
import 'package:blazemobile/screens/main-screens/charts.dart';
import 'package:blazemobile/screens/main-screens/playlists.dart';
import 'package:blazemobile/screens/onboarding/achieve-goals.dart';
import 'package:blazemobile/screens/main-screens/discover.dart';
import 'package:blazemobile/screens/education-screens/education-module-complete.dart';
import 'package:blazemobile/screens/initial-screen.dart';
import 'package:blazemobile/screens/login.dart';
import 'package:blazemobile/screens/onboarding/finalizing-investing-plan.dart';
import 'package:blazemobile/screens/onboarding/how-did-you-find-us.dart';
import 'package:blazemobile/screens/onboarding/how-long-to-invest.dart';
import 'package:blazemobile/screens/onboarding/how-to-achieve-goals.dart';
import 'package:blazemobile/screens/onboarding/investing-or-saving.dart';
import 'package:blazemobile/screens/onboarding/investing-plan-summary.dart';
import 'package:blazemobile/screens/onboarding/make-more-by-investing.dart';
import 'package:blazemobile/screens/onboarding/otp-screen.dart';
import 'package:blazemobile/screens/onboarding/phone-authentication.dart';
import 'package:blazemobile/screens/onboarding/plan-finalized.dart';
import 'package:blazemobile/screens/onboarding/risk-profile.dart';
import 'package:blazemobile/screens/onboarding/signup-credentials.dart';
import 'package:blazemobile/screens/onboarding/stressed-about-money.dart';
import 'package:blazemobile/screens/onboarding/whats-your-name.dart';
import 'package:blazemobile/screens/solo-playlist-screens/add-stocks.dart';
import 'package:blazemobile/screens/solo-playlist-screens/create-solo-playlist-intro.dart';
import 'package:blazemobile/screens/solo-playlist-screens/created-playlist.dart';
import 'package:blazemobile/screens/solo-playlist-screens/playlist-name.dart';
import 'package:blazemobile/screens/solo-playlist-screens/stock-weights.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/company-interests.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/company-size-preference.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/create-tailored-playlist-intro.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/diversification-preference.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/dividend-preference.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/generating-portfolio.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/playlist-duration.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/playlist-goal.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/playlist-sectors.dart';
import 'package:blazemobile/screens/stock.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/risk-calculation.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/risk-scoring.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/weight_preferences.dart';

import 'AuthWrapper.dart';


class RouteGenerator {

  //---screens that are safe to use without being authenticated---///
  static Map<String, WidgetBuilder> authNotRequiredPages = {
    '/': (context) => InitialScreen(),

    //login path
    '/login': (context) => Login(),

    //create account path
    '/whats-your-name': (context) => WhatsYourName(),
    '/achieve-goals': (context) => AchieveGoals(),
    '/how-to-achieve-goals': (context) => HowToAchieveGoals(),
    '/investing-or-saving': (context) => InvestingOrSaving(),
    '/make-more-by-investing': (context) => MakeMoreByInvesting(),
    '/how-long-to-invest': (context) => HowLongToInvest(),
    '/stressed-about-money': (context) => StressedAboutMoney(),
    '/how-did-you-find-us': (context) => HowDidYouFindUs(),
    '/phone-authentication': (context) => PhoneAuthentication(),
    '/signup-credentials': (context) => SignupCredentials(),


    '/otp-screen': (context) => OTPScreen(),
  };

  //---screens that require authentication to access (wrapper required)---//
  static Map<String, WidgetBuilder> authRequiredPages = {
    '/plan-finalized': (context) => PlanFinalized(),
    '/home': (context) => Home(),
    '/market': (context) => Market(),
    '/discover': (context) => Discover(),
    '/discover-playlist': (context) => DiscoverPlaylist(),
    '/learn': (context) => Learn(),
    '/playlists': (context) => Playlists(),
    '/education-module-progress': (context) => EducationModuleProgress(),
    '/education-lesson': (context) => EducationLesson(),
    '/education-questions': (context) => EducationQuestions(),
    '/education-module-complete': (context) => EducationModuleComplete(),
    '/create-tailored-playlist-intro': (context) => CreateTailoredPlaylistIntro(),
    '/weight_preferences': (context) => WeightPreferences(),
    '/playlist-interests': (context) => PlayListInterests(),
    '/company-interests': (context) => CompanyInterests(),
    '/risk-scoring': (context) => RiskScoring(qIndex: 0,),
    '/risk-calculation': (context) => RiskCalculation(),
    '/playlist-duration': (context) => PlaylistDuration(),
    '/diversification-preference': (context) => DiversificationPreference(),
    '/company-size-preference': (context) => CompanySizePreference(),
    '/dividend-preference': (context) => DividendPreference(),
    '/playlist-goal': (context) => PlaylistGoal(),
    '/generating-portfolio': (context) => GeneratingPortfolio(),
    '/create-solo-playlist-intro': (context) => CreateSoloPlaylistIntro(),
    '/playlist-name': (context) => PlaylistName(),
    '/created-playlist': (context) => CreatedPlaylist(),
    '/add-stocks': (context) => AddStocks(),
    '/stock-weights': (context) => StockWeights(stockWeightsPassed: [],descriptionPassed: '',editing: false,),
    '/chatbot-general': (context) => ChatbotGeneral(),
    '/stock': (context) => Stock(),

    //risk profiling
    '/risk-profile': (context) => RiskProfile(qIndex: 0,),
    '/finalizing-investing-plan': (context) => FinalizingInvestingPlan(),
    '/investing-plan-summary': (context) => InvestingPlanSummary(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments; //this var is used when u want to pass in data to the page through the navigator
    final routeName = settings.name;
    print('==== Route: $routeName ====');
    if(authNotRequiredPages.containsKey(routeName)){
      //---don't need wrapper---//
      return MaterialPageRoute(builder: (context) => authNotRequiredPages[routeName]!(context));
    }
    else if(authRequiredPages.containsKey(routeName)){
      //---need wrapper---//
      return MaterialPageRoute(
        builder: (context) => AuthWrapper(
          child: authRequiredPages[routeName]!(context),
          fallBack: InitialScreen()
        ),
      );
    }

    //---in case of incorrect route---//
    return MaterialPageRoute(builder: (context) => InitialScreen());
  }

}