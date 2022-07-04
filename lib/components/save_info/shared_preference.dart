// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class UserInfoPreferences{
  static late  SharedPreferences _prefs ;

  static const _keyEmail = 'email';
  static const _keyPassword = 'password';
  static const _keyUserId = 'user_id';
  static const _keyFirstName = 'first_name';
  static const _keyLastName = 'last_name';
  static const _keyPhoneNumber = 'phone_number';
  static const _keyCompanyId = 'company_id';
  static const _keyStatusEmail = 'status_email';

  static Future<void> inti() async {
      _prefs = await SharedPreferences.getInstance();
  }

  static Future SetEmail(String email) async => await _prefs.setString(_keyEmail, email);
  static Future SetPassword(String password) async => await _prefs.setString(_keyPassword, password);
  static Future SetUserId(String userId) async => await _prefs.setString(_keyUserId, userId);
  static Future SetFirstName(String firstName) async => await _prefs.setString(_keyFirstName, firstName);
  static Future SetLastName(String lastName) async => await _prefs.setString(_keyLastName, lastName);
  static Future SetPhoneNumber(String phoneNumber) async => await _prefs.setString(_keyPhoneNumber, phoneNumber);
  static Future SetCompanyId(String companyId) async => await _prefs.setString(_keyCompanyId, companyId);
  static Future SetStatusEmail(String statusEmail) async => await _prefs.setString(_keyStatusEmail, statusEmail);

  static String? GetEmail()   =>   _prefs.getString(_keyEmail);
  static String? GetPassword()   =>   _prefs.getString(_keyPassword);
  static String? GetUserId()   =>   _prefs.getString(_keyUserId);
  static String? GetFirstName()   =>   _prefs.getString(_keyFirstName);
  static String? GetLastName()   =>   _prefs.getString(_keyLastName);
  static String? GetPhoneNumber()   =>   _prefs.getString(_keyPhoneNumber);
  static String? GetCompanyId()   =>   _prefs.getString(_keyCompanyId);
  static String? GetStatusEmail()   =>   _prefs.getString(_keyStatusEmail);


  static Future Clear() async => await _prefs.clear();
}