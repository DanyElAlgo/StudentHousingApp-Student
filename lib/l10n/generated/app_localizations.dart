import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Student Housing'**
  String get appTitle;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClear;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonOr.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get commonOr;

  /// No description provided for @commonNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get commonNotSet;

  /// No description provided for @commonUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get commonUnknown;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get navChat;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @navBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get navBookings;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @authWelcomeBackTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authWelcomeBackTitle;

  /// No description provided for @authWelcomeBackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to find your next student home.'**
  String get authWelcomeBackSubtitle;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get authEmailHint;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @authLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get authLoginButton;

  /// No description provided for @authNoAccountQuestion.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get authNoAccountQuestion;

  /// No description provided for @authRegisterButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get authRegisterButton;

  /// No description provided for @authCreateAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authCreateAccountTitle;

  /// No description provided for @authRegisterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join as a student to browse and book rooms.'**
  String get authRegisterSubtitle;

  /// No description provided for @authFirstNameLabel.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get authFirstNameLabel;

  /// No description provided for @authLastNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get authLastNameLabel;

  /// No description provided for @authPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get authPhoneLabel;

  /// No description provided for @authNationalityLabel.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get authNationalityLabel;

  /// No description provided for @authGenderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get authGenderLabel;

  /// No description provided for @authGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get authGenderMale;

  /// No description provided for @authGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get authGenderFemale;

  /// No description provided for @authGenderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get authGenderOther;

  /// No description provided for @authSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Select your gender'**
  String get authSelectGender;

  /// No description provided for @authBirthDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get authBirthDateLabel;

  /// No description provided for @authBirthDateHint.
  ///
  /// In en, this message translates to:
  /// **'yyyy-mm-dd'**
  String get authBirthDateHint;

  /// No description provided for @authSelectBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Select your birth date'**
  String get authSelectBirthDate;

  /// No description provided for @authConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get authConfirmPasswordLabel;

  /// No description provided for @authPasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get authPasswordsDoNotMatch;

  /// No description provided for @authCreateAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authCreateAccountButton;

  /// No description provided for @authAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authAlreadyHaveAccount;

  /// No description provided for @authContinueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authContinueWithGoogle;

  /// No description provided for @authAccountCreatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Account created'**
  String get authAccountCreatedTitle;

  /// No description provided for @authAccountCreatedBody.
  ///
  /// In en, this message translates to:
  /// **'Check your email to confirm your account, then log in.'**
  String get authAccountCreatedBody;

  /// No description provided for @authValidatorEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get authValidatorEmailRequired;

  /// No description provided for @authValidatorEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get authValidatorEmailInvalid;

  /// No description provided for @authValidatorFirstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get authValidatorFirstNameRequired;

  /// No description provided for @authValidatorLastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get authValidatorLastNameRequired;

  /// No description provided for @authValidatorNationalityRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your nationality'**
  String get authValidatorNationalityRequired;

  /// No description provided for @authValidatorPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get authValidatorPhoneRequired;

  /// No description provided for @authValidatorPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use 7–15 digits'**
  String get authValidatorPhoneInvalid;

  /// No description provided for @authValidatorPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a password'**
  String get authValidatorPasswordRequired;

  /// No description provided for @authValidatorPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get authValidatorPasswordMinLength;

  /// No description provided for @authValidatorPasswordUppercase.
  ///
  /// In en, this message translates to:
  /// **'Add an uppercase letter'**
  String get authValidatorPasswordUppercase;

  /// No description provided for @authValidatorPasswordLowercase.
  ///
  /// In en, this message translates to:
  /// **'Add a lowercase letter'**
  String get authValidatorPasswordLowercase;

  /// No description provided for @authValidatorPasswordNumber.
  ///
  /// In en, this message translates to:
  /// **'Add a number'**
  String get authValidatorPasswordNumber;

  /// No description provided for @authValidatorPasswordSpecial.
  ///
  /// In en, this message translates to:
  /// **'Add a special character'**
  String get authValidatorPasswordSpecial;

  /// No description provided for @authValidatorLoginPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get authValidatorLoginPasswordRequired;

  /// No description provided for @homeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, student!'**
  String get homeWelcome;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find your next room quickly.'**
  String get homeSubtitle;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search rooms by name'**
  String get homeSearchHint;

  /// No description provided for @homeFeaturedRooms.
  ///
  /// In en, this message translates to:
  /// **'Featured rooms'**
  String get homeFeaturedRooms;

  /// No description provided for @homeShowMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get homeShowMore;

  /// No description provided for @homeNoRooms.
  ///
  /// In en, this message translates to:
  /// **'No rooms available right now.'**
  String get homeNoRooms;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Find a room'**
  String get searchTitle;

  /// No description provided for @searchMinPrice.
  ///
  /// In en, this message translates to:
  /// **'Min price'**
  String get searchMinPrice;

  /// No description provided for @searchMaxPrice.
  ///
  /// In en, this message translates to:
  /// **'Max price'**
  String get searchMaxPrice;

  /// No description provided for @searchMaxPriceHintAny.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get searchMaxPriceHintAny;

  /// No description provided for @servicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get servicesTitle;

  /// No description provided for @searchButton.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchButton;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No rooms match your filters.'**
  String get searchNoResults;

  /// No description provided for @searchResultsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 room found} other{{count} rooms found}}'**
  String searchResultsCount(int count);

  /// No description provided for @sortByLabel.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortByLabel;

  /// No description provided for @sortPriceAsc.
  ///
  /// In en, this message translates to:
  /// **'Price (low to high)'**
  String get sortPriceAsc;

  /// No description provided for @sortPriceDesc.
  ///
  /// In en, this message translates to:
  /// **'Price (high to low)'**
  String get sortPriceDesc;

  /// No description provided for @sortNameAsc.
  ///
  /// In en, this message translates to:
  /// **'Name (A–Z)'**
  String get sortNameAsc;

  /// No description provided for @sortNameDesc.
  ///
  /// In en, this message translates to:
  /// **'Name (Z–A)'**
  String get sortNameDesc;

  /// No description provided for @serviceWifi.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get serviceWifi;

  /// No description provided for @serviceKitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get serviceKitchen;

  /// No description provided for @serviceTv.
  ///
  /// In en, this message translates to:
  /// **'TV'**
  String get serviceTv;

  /// No description provided for @serviceAirConditioner.
  ///
  /// In en, this message translates to:
  /// **'Air conditioner'**
  String get serviceAirConditioner;

  /// No description provided for @serviceGymEquipment.
  ///
  /// In en, this message translates to:
  /// **'Gym equipment'**
  String get serviceGymEquipment;

  /// No description provided for @roomStatusAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get roomStatusAvailable;

  /// No description provided for @roomStatusBooked.
  ///
  /// In en, this message translates to:
  /// **'Booked'**
  String get roomStatusBooked;

  /// No description provided for @roomStatusUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get roomStatusUnavailable;

  /// No description provided for @detailsPerMonth.
  ///
  /// In en, this message translates to:
  /// **'/ month'**
  String get detailsPerMonth;

  /// No description provided for @detailsDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get detailsDescription;

  /// No description provided for @detailsNoDescription.
  ///
  /// In en, this message translates to:
  /// **'No description provided.'**
  String get detailsNoDescription;

  /// No description provided for @detailsLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get detailsLocation;

  /// No description provided for @detailsNoServices.
  ///
  /// In en, this message translates to:
  /// **'No services listed.'**
  String get detailsNoServices;

  /// No description provided for @detailsPolicies.
  ///
  /// In en, this message translates to:
  /// **'Policies'**
  String get detailsPolicies;

  /// No description provided for @detailsNoPolicies.
  ///
  /// In en, this message translates to:
  /// **'No policies listed.'**
  String get detailsNoPolicies;

  /// No description provided for @detailsOwner.
  ///
  /// In en, this message translates to:
  /// **'Property owner'**
  String get detailsOwner;

  /// No description provided for @detailsBookRoom.
  ///
  /// In en, this message translates to:
  /// **'Book room'**
  String get detailsBookRoom;

  /// No description provided for @detailsBookingUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Booking unavailable'**
  String get detailsBookingUnavailable;

  /// No description provided for @detailsCancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel request'**
  String get detailsCancelRequest;

  /// No description provided for @detailsChatButton.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get detailsChatButton;

  /// No description provided for @detailsShareButton.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get detailsShareButton;

  /// No description provided for @detailsShareMessage.
  ///
  /// In en, this message translates to:
  /// **'Check out \"{roomName}\" on Student Lib: {url}'**
  String detailsShareMessage(String roomName, String url);

  /// No description provided for @detailsBookingSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Room booked'**
  String get detailsBookingSuccessTitle;

  /// No description provided for @detailsBookingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Booking made successfully.'**
  String get detailsBookingSuccess;

  /// No description provided for @detailsRequestCancelled.
  ///
  /// In en, this message translates to:
  /// **'Request cancelled.'**
  String get detailsRequestCancelled;

  /// No description provided for @chatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chatsTitle;

  /// No description provided for @chatEmpty.
  ///
  /// In en, this message translates to:
  /// **'No chats yet.\nStart one from a room to contact its owner.'**
  String get chatEmpty;

  /// No description provided for @chatThreadTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatThreadTitle;

  /// No description provided for @chatReconnecting.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting…'**
  String get chatReconnecting;

  /// No description provided for @chatMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Message…'**
  String get chatMessageHint;

  /// No description provided for @chatNoMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet.\nSay hello!'**
  String get chatNoMessages;

  /// No description provided for @chatCouldNotStart.
  ///
  /// In en, this message translates to:
  /// **'Could not start the chat.'**
  String get chatCouldNotStart;

  /// No description provided for @chatYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get chatYesterday;

  /// No description provided for @chatWeekdayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get chatWeekdayMon;

  /// No description provided for @chatWeekdayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get chatWeekdayTue;

  /// No description provided for @chatWeekdayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get chatWeekdayWed;

  /// No description provided for @chatWeekdayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get chatWeekdayThu;

  /// No description provided for @chatWeekdayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get chatWeekdayFri;

  /// No description provided for @chatWeekdaySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get chatWeekdaySat;

  /// No description provided for @chatWeekdaySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get chatWeekdaySun;

  /// No description provided for @bookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'My bookings'**
  String get bookingsTitle;

  /// No description provided for @bookingsEmpty.
  ///
  /// In en, this message translates to:
  /// **'You have no bookings yet.'**
  String get bookingsEmpty;

  /// No description provided for @bookingStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get bookingStatusPending;

  /// No description provided for @bookingStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get bookingStatusApproved;

  /// No description provided for @bookingStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get bookingStatusRejected;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get profileYourProfile;

  /// No description provided for @profileBirthdateLabel.
  ///
  /// In en, this message translates to:
  /// **'Birthdate'**
  String get profileBirthdateLabel;

  /// No description provided for @profileEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profileEditButton;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogout;

  /// No description provided for @profileLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguageLabel;

  /// No description provided for @profileSelectNationality.
  ///
  /// In en, this message translates to:
  /// **'Select your nationality'**
  String get profileSelectNationality;

  /// No description provided for @profileSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get profileSaveChanges;

  /// No description provided for @profileFirstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required.'**
  String get profileFirstNameRequired;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated.'**
  String get profileUpdated;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
