// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Student Housing';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOr => 'or';

  @override
  String get commonNotSet => 'Not set';

  @override
  String get commonUnknown => 'Unknown';

  @override
  String get navHome => 'Home';

  @override
  String get navChat => 'Chat';

  @override
  String get navSearch => 'Search';

  @override
  String get navBookings => 'Bookings';

  @override
  String get navProfile => 'Profile';

  @override
  String get authWelcomeBackTitle => 'Welcome back';

  @override
  String get authWelcomeBackSubtitle =>
      'Log in to find your next student home.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'you@example.com';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authLoginButton => 'Log in';

  @override
  String get authNoAccountQuestion => 'Don\'t have an account?';

  @override
  String get authRegisterButton => 'Register';

  @override
  String get authCreateAccountTitle => 'Create account';

  @override
  String get authRegisterSubtitle =>
      'Join as a student to browse and book rooms.';

  @override
  String get authFirstNameLabel => 'First name';

  @override
  String get authLastNameLabel => 'Last name';

  @override
  String get authPhoneLabel => 'Phone number';

  @override
  String get authNationalityLabel => 'Nationality';

  @override
  String get authGenderLabel => 'Gender';

  @override
  String get authGenderMale => 'Male';

  @override
  String get authGenderFemale => 'Female';

  @override
  String get authGenderOther => 'Other';

  @override
  String get authSelectGender => 'Select your gender';

  @override
  String get authBirthDateLabel => 'Birth date';

  @override
  String get authBirthDateHint => 'yyyy-mm-dd';

  @override
  String get authSelectBirthDate => 'Select your birth date';

  @override
  String get authConfirmPasswordLabel => 'Confirm password';

  @override
  String get authPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get authCreateAccountButton => 'Create account';

  @override
  String get authAlreadyHaveAccount => 'Already have an account?';

  @override
  String get authContinueWithGoogle => 'Continue with Google';

  @override
  String get authAccountCreatedTitle => 'Account created';

  @override
  String get authAccountCreatedBody =>
      'Check your email to confirm your account, then log in.';

  @override
  String get authValidatorEmailRequired => 'Enter your email';

  @override
  String get authValidatorEmailInvalid => 'Enter a valid email';

  @override
  String get authValidatorFirstNameRequired => 'Enter your first name';

  @override
  String get authValidatorLastNameRequired => 'Enter your last name';

  @override
  String get authValidatorNationalityRequired => 'Enter your nationality';

  @override
  String get authValidatorPhoneRequired => 'Enter your phone number';

  @override
  String get authValidatorPhoneInvalid => 'Use 7–15 digits';

  @override
  String get authValidatorPasswordRequired => 'Enter a password';

  @override
  String get authValidatorPasswordMinLength => 'At least 8 characters';

  @override
  String get authValidatorPasswordUppercase => 'Add an uppercase letter';

  @override
  String get authValidatorPasswordLowercase => 'Add a lowercase letter';

  @override
  String get authValidatorPasswordNumber => 'Add a number';

  @override
  String get authValidatorPasswordSpecial => 'Add a special character';

  @override
  String get authValidatorLoginPasswordRequired => 'Enter your password';

  @override
  String get homeWelcome => 'Welcome, student!';

  @override
  String get homeSubtitle => 'Find your next room quickly.';

  @override
  String get homeSearchHint => 'Search rooms by name';

  @override
  String get homeFeaturedRooms => 'Featured rooms';

  @override
  String get homeShowMore => 'Show more';

  @override
  String get homeNoRooms => 'No rooms available right now.';

  @override
  String get searchTitle => 'Find a room';

  @override
  String get searchMinPrice => 'Min price';

  @override
  String get searchMaxPrice => 'Max price';

  @override
  String get searchMaxPriceHintAny => 'Any';

  @override
  String get servicesTitle => 'Services';

  @override
  String get searchButton => 'Search';

  @override
  String get searchNoResults => 'No rooms match your filters.';

  @override
  String searchResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rooms found',
      one: '1 room found',
    );
    return '$_temp0';
  }

  @override
  String get sortByLabel => 'Sort by';

  @override
  String get sortPriceAsc => 'Price (low to high)';

  @override
  String get sortPriceDesc => 'Price (high to low)';

  @override
  String get sortNameAsc => 'Name (A–Z)';

  @override
  String get sortNameDesc => 'Name (Z–A)';

  @override
  String get serviceWifi => 'WiFi';

  @override
  String get serviceKitchen => 'Kitchen';

  @override
  String get serviceTv => 'TV';

  @override
  String get serviceAirConditioner => 'Air conditioner';

  @override
  String get serviceGymEquipment => 'Gym equipment';

  @override
  String get roomStatusAvailable => 'Available';

  @override
  String get roomStatusBooked => 'Booked';

  @override
  String get roomStatusUnavailable => 'Unavailable';

  @override
  String get detailsPerMonth => '/ month';

  @override
  String get detailsDescription => 'Description';

  @override
  String get detailsNoDescription => 'No description provided.';

  @override
  String get detailsLocation => 'Location';

  @override
  String get detailsNoServices => 'No services listed.';

  @override
  String get detailsPolicies => 'Policies';

  @override
  String get detailsNoPolicies => 'No policies listed.';

  @override
  String get detailsOwner => 'Property owner';

  @override
  String get detailsBookRoom => 'Book room';

  @override
  String get detailsBookingUnavailable => 'Booking unavailable';

  @override
  String get detailsCancelRequest => 'Cancel request';

  @override
  String get detailsChatButton => 'Chat';

  @override
  String get detailsBookingSuccess => 'Booking made successfully.';

  @override
  String get detailsRequestCancelled => 'Request cancelled.';

  @override
  String get chatsTitle => 'Chats';

  @override
  String get chatEmpty =>
      'No chats yet.\nStart one from a room to contact its owner.';

  @override
  String get chatThreadTitle => 'Chat';

  @override
  String get chatReconnecting => 'Reconnecting…';

  @override
  String get chatMessageHint => 'Message…';

  @override
  String get chatNoMessages => 'No messages yet.\nSay hello!';

  @override
  String get chatCouldNotStart => 'Could not start the chat.';

  @override
  String get chatYesterday => 'Yesterday';

  @override
  String get chatWeekdayMon => 'Mon';

  @override
  String get chatWeekdayTue => 'Tue';

  @override
  String get chatWeekdayWed => 'Wed';

  @override
  String get chatWeekdayThu => 'Thu';

  @override
  String get chatWeekdayFri => 'Fri';

  @override
  String get chatWeekdaySat => 'Sat';

  @override
  String get chatWeekdaySun => 'Sun';

  @override
  String get bookingsTitle => 'My bookings';

  @override
  String get bookingsEmpty => 'You have no bookings yet.';

  @override
  String get bookingStatusPending => 'Pending';

  @override
  String get bookingStatusApproved => 'Approved';

  @override
  String get bookingStatusRejected => 'Rejected';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileYourProfile => 'Your profile';

  @override
  String get profileBirthdateLabel => 'Birthdate';

  @override
  String get profileEditButton => 'Edit profile';

  @override
  String get profileLogout => 'Log out';

  @override
  String get profileLanguageLabel => 'Language';

  @override
  String get profileSelectNationality => 'Select your nationality';

  @override
  String get profileSaveChanges => 'Save changes';

  @override
  String get profileFirstNameRequired => 'First name is required.';

  @override
  String get profileUpdated => 'Profile updated.';
}
