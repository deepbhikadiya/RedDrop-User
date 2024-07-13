// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter First Name`
  String get enter_first_name {
    return Intl.message(
      'Enter First Name',
      name: 'enter_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter Middle Name`
  String get enter_middle_name {
    return Intl.message(
      'Enter Middle Name',
      name: 'enter_middle_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter Last Name`
  String get enter_last_name {
    return Intl.message(
      'Enter Last Name',
      name: 'enter_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your AADHAAR No.`
  String get enter_national_id_no {
    return Intl.message(
      'Enter Your AADHAAR No.',
      name: 'enter_national_id_no',
      desc: '',
      args: [],
    );
  }

  /// `Enter Phone Number`
  String get enter_phone_number {
    return Intl.message(
      'Enter Phone Number',
      name: 'enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enter_password {
    return Intl.message(
      'Enter Password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Your Password`
  String get enter_confirm_password {
    return Intl.message(
      'Confirm Your Password',
      name: 'enter_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Your Blood Group`
  String get your_blood_group {
    return Intl.message(
      'Your Blood Group',
      name: 'your_blood_group',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account ?`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account ?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Login Here`
  String get login_here {
    return Intl.message(
      'Login Here',
      name: 'login_here',
      desc: '',
      args: [],
    );
  }

  /// `We have just sent you a 6 digit code via your Mobile Number.`
  String get we_have_just_sent_you_code {
    return Intl.message(
      'We have just sent you a 6 digit code via your Mobile Number.',
      name: 'we_have_just_sent_you_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resend_code {
    return Intl.message(
      'Resend Code',
      name: 'resend_code',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_ {
    return Intl.message(
      'Continue',
      name: 'continue_',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Please fill up and login to your account`
  String get please_fill_up_and_login_to_your_account {
    return Intl.message(
      'Please fill up and login to your account',
      name: 'please_fill_up_and_login_to_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password ?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password ?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get don_have_an_account {
    return Intl.message(
      'Don’t have an account?',
      name: 'don_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Don't worry! it happens. Please enter the mobile number associated with your account.`
  String get don_worry_it_happen {
    return Intl.message(
      'Don\'t worry! it happens. Please enter the mobile number associated with your account.',
      name: 'don_worry_it_happen',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get enter_otp {
    return Intl.message(
      'Enter OTP',
      name: 'enter_otp',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get okay {
    return Intl.message(
      'Okay',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `Select Gender`
  String get select_gender {
    return Intl.message(
      'Select Gender',
      name: 'select_gender',
      desc: '',
      args: [],
    );
  }

  /// `Select City`
  String get select_city {
    return Intl.message(
      'Select City',
      name: 'select_city',
      desc: '',
      args: [],
    );
  }

  /// `Select Area`
  String get select_area {
    return Intl.message(
      'Select Area',
      name: 'select_area',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Selected birthdate is not eligible for donating blood.`
  String get select_birthdate_is_not_eligible_to_donate_blood {
    return Intl.message(
      'Selected birthdate is not eligible for donating blood.',
      name: 'select_birthdate_is_not_eligible_to_donate_blood',
      desc: '',
      args: [],
    );
  }

  /// `Camera Roll`
  String get camera_roll {
    return Intl.message(
      'Camera Roll',
      name: 'camera_roll',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Search City`
  String get search_city {
    return Intl.message(
      'Search City',
      name: 'search_city',
      desc: '',
      args: [],
    );
  }

  /// `Search Area`
  String get search_area {
    return Intl.message(
      'Search Area',
      name: 'search_area',
      desc: '',
      args: [],
    );
  }

  /// `I accept the`
  String get i_accept_the {
    return Intl.message(
      'I accept the',
      name: 'i_accept_the',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get terms_and_condition {
    return Intl.message(
      'Terms & Conditions',
      name: 'terms_and_condition',
      desc: '',
      args: [],
    );
  }

  /// `of`
  String get oof {
    return Intl.message(
      'of',
      name: 'oof',
      desc: '',
      args: [],
    );
  }

  /// `No more data`
  String get no_more_data {
    return Intl.message(
      'No more data',
      name: 'no_more_data',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Enter Referral Code(optional)`
  String get enter_referral_code {
    return Intl.message(
      'Enter Referral Code(optional)',
      name: 'enter_referral_code',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `(optional)`
  String get option {
    return Intl.message(
      '(optional)',
      name: 'option',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for joining us on our mission to save lives`
  String get mission_to_save_life {
    return Intl.message(
      'Thanks for joining us on our mission to save lives',
      name: 'mission_to_save_life',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get welcome_back {
    return Intl.message(
      'Welcome Back!',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Select Birthdate`
  String get select_birthdate {
    return Intl.message(
      'Select Birthdate',
      name: 'select_birthdate',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get request {
    return Intl.message(
      'Request',
      name: 'request',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning`
  String get good_morning {
    return Intl.message(
      'Good Morning',
      name: 'good_morning',
      desc: '',
      args: [],
    );
  }

  /// `Good Afternoon`
  String get good_afternoon {
    return Intl.message(
      'Good Afternoon',
      name: 'good_afternoon',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening`
  String get good_evening {
    return Intl.message(
      'Good Evening',
      name: 'good_evening',
      desc: '',
      args: [],
    );
  }

  /// `Good Night`
  String get good_night {
    return Intl.message(
      'Good Night',
      name: 'good_night',
      desc: '',
      args: [],
    );
  }

  /// `Questionnaires`
  String get questionnaires {
    return Intl.message(
      'Questionnaires',
      name: 'questionnaires',
      desc: '',
      args: [],
    );
  }

  /// `Fill up the following questionnaires and become a donor`
  String get fill_up_the_questionnaires {
    return Intl.message(
      'Fill up the following questionnaires and become a donor',
      name: 'fill_up_the_questionnaires',
      desc: '',
      args: [],
    );
  }

  /// `Do you have diabetes?`
  String get do_you_have_diabetes {
    return Intl.message(
      'Do you have diabetes?',
      name: 'do_you_have_diabetes',
      desc: '',
      args: [],
    );
  }

  /// `Had you ever had problems with your heart or lungs?`
  String get ever_have_lung_problem {
    return Intl.message(
      'Had you ever had problems with your heart or lungs?',
      name: 'ever_have_lung_problem',
      desc: '',
      args: [],
    );
  }

  /// `In the last 28 days do you have COVID-19?`
  String get last_28_day_have_covid {
    return Intl.message(
      'In the last 28 days do you have COVID-19?',
      name: 'last_28_day_have_covid',
      desc: '',
      args: [],
    );
  }

  /// `Have you ever had a positive test for the HIV/AIDS virus?`
  String get have_you_ever_positive_aids {
    return Intl.message(
      'Have you ever had a positive test for the HIV/AIDS virus?',
      name: 'have_you_ever_positive_aids',
      desc: '',
      args: [],
    );
  }

  /// `Have you ever had cancer?`
  String get have_cancer {
    return Intl.message(
      'Have you ever had cancer?',
      name: 'have_cancer',
      desc: '',
      args: [],
    );
  }

  /// `In the last 3 months have you ever had vaccination?`
  String get last_3_month_vaccine {
    return Intl.message(
      'In the last 3 months have you ever had vaccination?',
      name: 'last_3_month_vaccine',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Donation\nRequest`
  String get donation_request {
    return Intl.message(
      'Donation\nRequest',
      name: 'donation_request',
      desc: '',
      args: [],
    );
  }

  /// `Your\nRequest`
  String get your_request {
    return Intl.message(
      'Your\nRequest',
      name: 'your_request',
      desc: '',
      args: [],
    );
  }

  /// `Decline`
  String get decline {
    return Intl.message(
      'Decline',
      name: 'decline',
      desc: '',
      args: [],
    );
  }

  /// `Donate Now`
  String get donate_now {
    return Intl.message(
      'Donate Now',
      name: 'donate_now',
      desc: '',
      args: [],
    );
  }

  /// `Create a Request`
  String get create_a_request {
    return Intl.message(
      'Create a Request',
      name: 'create_a_request',
      desc: '',
      args: [],
    );
  }

  /// `Enter location`
  String get enter_location {
    return Intl.message(
      'Enter location',
      name: 'enter_location',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Blood Group`
  String get blood_group {
    return Intl.message(
      'Blood Group',
      name: 'blood_group',
      desc: '',
      args: [],
    );
  }

  /// `View details`
  String get view_details {
    return Intl.message(
      'View details',
      name: 'view_details',
      desc: '',
      args: [],
    );
  }

  /// `Feed`
  String get feed {
    return Intl.message(
      'Feed',
      name: 'feed',
      desc: '',
      args: [],
    );
  }

  /// `Rewards`
  String get rewards {
    return Intl.message(
      'Rewards',
      name: 'rewards',
      desc: '',
      args: [],
    );
  }

  /// `Donation Details`
  String get donation_detail {
    return Intl.message(
      'Donation Details',
      name: 'donation_detail',
      desc: '',
      args: [],
    );
  }

  /// `Blood is successfully requested.`
  String get blood_successfully_requested {
    return Intl.message(
      'Blood is successfully requested.',
      name: 'blood_successfully_requested',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for accepting the request.`
  String get thanks_for_accepting_request {
    return Intl.message(
      'Thanks for accepting the request.',
      name: 'thanks_for_accepting_request',
      desc: '',
      args: [],
    );
  }

  /// `Swipe up for more`
  String get swipe_up_for_more {
    return Intl.message(
      'Swipe up for more',
      name: 'swipe_up_for_more',
      desc: '',
      args: [],
    );
  }

  /// `Last donation date`
  String get last_donated_date {
    return Intl.message(
      'Last donation date',
      name: 'last_donated_date',
      desc: '',
      args: [],
    );
  }

  /// `Life saved`
  String get life_saved {
    return Intl.message(
      'Life saved',
      name: 'life_saved',
      desc: '',
      args: [],
    );
  }

  /// `Top Rated`
  String get top_rated {
    return Intl.message(
      'Top Rated',
      name: 'top_rated',
      desc: '',
      args: [],
    );
  }

  /// `Good Behavior`
  String get good_behaviour {
    return Intl.message(
      'Good Behavior',
      name: 'good_behaviour',
      desc: '',
      args: [],
    );
  }

  /// `Send Request`
  String get send_request {
    return Intl.message(
      'Send Request',
      name: 'send_request',
      desc: '',
      args: [],
    );
  }

  /// `Rewards Points`
  String get rewards_points {
    return Intl.message(
      'Rewards Points',
      name: 'rewards_points',
      desc: '',
      args: [],
    );
  }

  /// `Badge`
  String get badge {
    return Intl.message(
      'Badge',
      name: 'badge',
      desc: '',
      args: [],
    );
  }

  /// `Donator`
  String get donator {
    return Intl.message(
      'Donator',
      name: 'donator',
      desc: '',
      args: [],
    );
  }

  /// `Life Savior`
  String get life_savior {
    return Intl.message(
      'Life Savior',
      name: 'life_savior',
      desc: '',
      args: [],
    );
  }

  /// `Superhero`
  String get superhero {
    return Intl.message(
      'Superhero',
      name: 'superhero',
      desc: '',
      args: [],
    );
  }

  /// `You have to save`
  String get you_have_to_save {
    return Intl.message(
      'You have to save',
      name: 'you_have_to_save',
      desc: '',
      args: [],
    );
  }

  /// `life to get this badge`
  String get life_to_get_badge {
    return Intl.message(
      'life to get this badge',
      name: 'life_to_get_badge',
      desc: '',
      args: [],
    );
  }

  /// `You have saved`
  String get you_have_saved {
    return Intl.message(
      'You have saved',
      name: 'you_have_saved',
      desc: '',
      args: [],
    );
  }

  /// `valuable life till now`
  String get valuable_life_till_now {
    return Intl.message(
      'valuable life till now',
      name: 'valuable_life_till_now',
      desc: '',
      args: [],
    );
  }

  /// `Donate blood to save life and become a super hero`
  String get donate_blood_to_save_life_and_become_superhero {
    return Intl.message(
      'Donate blood to save life and become a super hero',
      name: 'donate_blood_to_save_life_and_become_superhero',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get group {
    return Intl.message(
      'Group',
      name: 'group',
      desc: '',
      args: [],
    );
  }

  /// `Next donation`
  String get next_donation {
    return Intl.message(
      'Next donation',
      name: 'next_donation',
      desc: '',
      args: [],
    );
  }

  /// `Available To Donate`
  String get available_to_donate {
    return Intl.message(
      'Available To Donate',
      name: 'available_to_donate',
      desc: '',
      args: [],
    );
  }

  /// `Manage Address`
  String get manage_address {
    return Intl.message(
      'Manage Address',
      name: 'manage_address',
      desc: '',
      args: [],
    );
  }

  /// `Available Donors`
  String get available_donors {
    return Intl.message(
      'Available Donors',
      name: 'available_donors',
      desc: '',
      args: [],
    );
  }

  /// `Confirm donation`
  String get confirm_donation {
    return Intl.message(
      'Confirm donation',
      name: 'confirm_donation',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get call {
    return Intl.message(
      'Call',
      name: 'call',
      desc: '',
      args: [],
    );
  }

  /// `Donation confirmed`
  String get donation_confirmed {
    return Intl.message(
      'Donation confirmed',
      name: 'donation_confirmed',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Donation History`
  String get donation_history {
    return Intl.message(
      'Donation History',
      name: 'donation_history',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get log_out {
    return Intl.message(
      'Log Out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profile_updated_successfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profile_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `I Donated`
  String get i_donated {
    return Intl.message(
      'I Donated',
      name: 'i_donated',
      desc: '',
      args: [],
    );
  }

  /// `Thank you immensely for your blood donation, your selfless act has been recorded.`
  String get thank_you_text {
    return Intl.message(
      'Thank you immensely for your blood donation, your selfless act has been recorded.',
      name: 'thank_you_text',
      desc: '',
      args: [],
    );
  }

  /// `In pending`
  String get in_pending {
    return Intl.message(
      'In pending',
      name: 'in_pending',
      desc: '',
      args: [],
    );
  }

  /// `No available donors`
  String get no_available_donor {
    return Intl.message(
      'No available donors',
      name: 'no_available_donor',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get points {
    return Intl.message(
      'Points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `The provided phone number is not valid.`
  String get the_provided_phone_number_is_not_valid {
    return Intl.message(
      'The provided phone number is not valid.',
      name: 'the_provided_phone_number_is_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number to login.`
  String get please_enter_your_phone_number_to_login {
    return Intl.message(
      'Please enter your phone number to login.',
      name: 'please_enter_your_phone_number_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Phone number can not be empty`
  String get phone_number_can_not_be_empty {
    return Intl.message(
      'Phone number can not be empty',
      name: 'phone_number_can_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get invalid_phone_number {
    return Intl.message(
      'Invalid phone number',
      name: 'invalid_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Code sent to your mobile number`
  String get code_resend_to_your_mobile_number {
    return Intl.message(
      'Code sent to your mobile number',
      name: 'code_resend_to_your_mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `You cannot donate as per Questionnaires`
  String get you_cannot_donate_as_per_questionnaires {
    return Intl.message(
      'You cannot donate as per Questionnaires',
      name: 'you_cannot_donate_as_per_questionnaires',
      desc: '',
      args: [],
    );
  }

  /// `Register SuccessFully`
  String get register_successFully {
    return Intl.message(
      'Register SuccessFully',
      name: 'register_successFully',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personal_information {
    return Intl.message(
      'Personal Information',
      name: 'personal_information',
      desc: '',
      args: [],
    );
  }

  /// `Profile Image`
  String get profile_image {
    return Intl.message(
      'Profile Image',
      name: 'profile_image',
      desc: '',
      args: [],
    );
  }

  /// `First name can not be empty`
  String get first_name_can_not_be_empty {
    return Intl.message(
      'First name can not be empty',
      name: 'first_name_can_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Middle name can not be empty`
  String get middle_name_can_not_be_empty {
    return Intl.message(
      'Middle name can not be empty',
      name: 'middle_name_can_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Last name can not be empty`
  String get last_name_can_not_be_empty {
    return Intl.message(
      'Last name can not be empty',
      name: 'last_name_can_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `AADHAR number can not be empty`
  String get aadhar_number_can_not_be_empty {
    return Intl.message(
      'AADHAR number can not be empty',
      name: 'aadhar_number_can_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid AADHAR number`
  String get invalid_aadhar_number {
    return Intl.message(
      'Invalid AADHAR number',
      name: 'invalid_aadhar_number',
      desc: '',
      args: [],
    );
  }

  /// `National Identification (AADHAR CARD)`
  String get national_identification {
    return Intl.message(
      'National Identification (AADHAR CARD)',
      name: 'national_identification',
      desc: '',
      args: [],
    );
  }

  /// `Please select profile image`
  String get please_select_profile_image {
    return Intl.message(
      'Please select profile image',
      name: 'please_select_profile_image',
      desc: '',
      args: [],
    );
  }

  /// `Please select gender`
  String get please_select_gender {
    return Intl.message(
      'Please select gender',
      name: 'please_select_gender',
      desc: '',
      args: [],
    );
  }

  /// `Please select valid birth date`
  String get please_select_valid_birth_date {
    return Intl.message(
      'Please select valid birth date',
      name: 'please_select_valid_birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Please select national identification`
  String get please_select_national_identification {
    return Intl.message(
      'Please select national identification',
      name: 'please_select_national_identification',
      desc: '',
      args: [],
    );
  }

  /// `Please select city`
  String get please_select_city {
    return Intl.message(
      'Please select city',
      name: 'please_select_city',
      desc: '',
      args: [],
    );
  }

  /// `Please select area`
  String get please_select_area {
    return Intl.message(
      'Please select area',
      name: 'please_select_area',
      desc: '',
      args: [],
    );
  }

  /// `Choose current location`
  String get choose_current_location {
    return Intl.message(
      'Choose current location',
      name: 'choose_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Blood donation request not found.`
  String get blood_donation_request_not_found {
    return Intl.message(
      'Blood donation request not found.',
      name: 'blood_donation_request_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to decline blood request?`
  String get are_you_sure_to_decline_blood_request {
    return Intl.message(
      'Are you sure to decline blood request?',
      name: 'are_you_sure_to_decline_blood_request',
      desc: '',
      args: [],
    );
  }

  /// `No donation history found.`
  String get no_donation_history_found {
    return Intl.message(
      'No donation history found.',
      name: 'no_donation_history_found',
      desc: '',
      args: [],
    );
  }

  /// `Upload your AADHAR`
  String get upload_your_aadhar {
    return Intl.message(
      'Upload your AADHAR',
      name: 'upload_your_aadhar',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get about_us {
    return Intl.message(
      'About us',
      name: 'about_us',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact_us {
    return Intl.message(
      'Contact us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'gu'),
      Locale.fromSubtags(languageCode: 'hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
