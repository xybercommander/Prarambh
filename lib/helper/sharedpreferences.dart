import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String loggedInSharedPreferenceKey = 'LOGINKEY';
  static String isCompanySharedPreferenceKey = 'ISCOMPANYKEY';
  static String fullNameSharedPreferenceKey = 'FULLNAMEKEY';
  static String companyNameSharedPreferenceKey = 'COMPANYKEY';
  static String emailSharedPreferenceKey = 'EMAILKEY';
  static String imgUrlSharedPreferenceKey = 'IMGURLKEY';
  static String logoUrlSharedPreferenceKey = 'LOGOURLKEY';
  static String companyDescriptionSharedPreferenceKey = 'COMPANYDESCRIPTIONKEY';
  static String companyServiceTypeSharedPreferenceKey = 'COMPANYSERVICETYPEKEY';
  static String themeStateSharedPreferenceKey = 'THEMESTATEKEY';

  // ****************
  // SET FUNCTIONS
  // ****************
  static Future<void> saveLoggedInSharedPreference(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        loggedInSharedPreferenceKey, isUserLoggedIn);
  }

  static Future<void> saveIsCompanySharedPreference(bool isCompany) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        isCompanySharedPreferenceKey, isCompany);
  }

  static Future<void> saveFullNameSharedPreference(String fullname) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        fullNameSharedPreferenceKey, fullname);
  }

  static Future<void> saveCompanyNameSharedPreference(String companyname) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        companyNameSharedPreferenceKey, companyname);
  }

  static Future<void> saveEmailSharedPreference(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        emailSharedPreferenceKey, email);
  }

  static Future<void> saveImgUrlSharedPreference(String imgurl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        imgUrlSharedPreferenceKey, imgurl);
  }

  static Future<void> saveLogoUrlSharedPreference(String logourl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        imgUrlSharedPreferenceKey, logourl);
  }

  static Future<void> saveCompanyDescriptionSharedPreference(String desc) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        companyDescriptionSharedPreferenceKey, desc);
  }

  static Future<void> saveCompanyServiceTypeSharedPreference(String servicetype) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        companyServiceTypeSharedPreferenceKey, servicetype);
  }

  static Future<bool> saveThemeStateSharedPreference(bool theme) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        themeStateSharedPreferenceKey, theme);
  }

  // ****************
  // GET FUNCTIONS
  // ****************
  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(loggedInSharedPreferenceKey);
  }

  static Future<bool> getIsCompanySharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(isCompanySharedPreferenceKey);
  }

  static Future<String> getFullNameInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(fullNameSharedPreferenceKey);
  }

  static Future<String> getCompanyNameInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(companyNameSharedPreferenceKey);
  }

  static Future<String> getEmailInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(emailSharedPreferenceKey);
  }

  static Future<String> getImgUrlInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(imgUrlSharedPreferenceKey);
  }

  static Future<String> getLogoUrlInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(logoUrlSharedPreferenceKey);
  }

  static Future<String> getCompanyDescriptionInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(companyDescriptionSharedPreferenceKey);
  }

  static Future<String> getCompanyServiceTypeInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(companyServiceTypeSharedPreferenceKey);
  }

  static Future<bool> getThemeStateInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(themeStateSharedPreferenceKey);
  }
}
