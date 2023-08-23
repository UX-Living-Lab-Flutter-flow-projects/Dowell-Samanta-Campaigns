import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es', 'fr', 'de'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
    String? frText = '',
    String? deText = '',
  }) =>
      [enText, esText, frText, deText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // settings_screen
  {
    '7zw3xmhv': {
      'en': 'Settings Page',
      'de': '',
      'es': '',
      'fr': '',
    },
    'aw2b3ib1': {
      'en': 'Account setting',
      'de': '',
      'es': '',
      'fr': '',
    },
    'b6rym9st': {
      'en': 'Profile',
      'de': '',
      'es': '',
      'fr': '',
    },
    'bwyhwk42': {
      'en': 'Edit profile information',
      'de': '',
      'es': '',
      'fr': '',
    },
    'kwnuk7r9': {
      'en': 'Account Setting',
      'de': '',
      'es': '',
      'fr': '',
    },
    'fl9q9ypj': {
      'en': 'Manage account setting',
      'de': '',
      'es': '',
      'fr': '',
    },
    '8txt9h1m': {
      'en': 'Contact details',
      'de': '',
      'es': '',
      'fr': '',
    },
    'n2rffeem': {
      'en': 'Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    'xmcxroot': {
      'en': 'Phone Number',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ifix6rzl': {
      'en': 'App settings',
      'de': '',
      'es': '',
      'fr': '',
    },
    '231lsfgm': {
      'en': 'Exit',
      'de': '',
      'es': '',
      'fr': '',
    },
    'cjm18o96': {
      'en': 'Close the app',
      'de': '',
      'es': '',
      'fr': '',
    },
    'q20hfhd8': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // profile_screen
  {
    'f1wl44jy': {
      'en': 'Profile Setting',
      'de': '',
      'es': '',
      'fr': '',
    },
    'yj3w910r': {
      'en': 'Edit Profile',
      'de': '',
      'es': '',
      'fr': '',
    },
    '83669vm3': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // login
  {
    'hq0xp8td': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // signup
  {
    'rrvo013a': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // livinglabmap
  {
    'tp79swum': {
      'en': 'DoWell Maps',
      'de': '',
      'es': '',
      'fr': '',
    },
    '2puxfdgn': {
      'en': 'Save',
      'de': '',
      'es': '',
      'fr': '',
    },
    '0w5q1vi5': {
      'en': 'Add place',
      'de': '',
      'es': '',
      'fr': '',
    },
    'soa6i3oi': {
      'en': 'Log in',
      'de': '',
      'es': '',
      'fr': '',
    },
    'vmzmf6u8': {
      'en': 'Search Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    'j662l18p': {
      'en': 'Current Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    'zzw54amt': {
      'en': 'Current Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    'm4vt7298': {
      'en': 'Select Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    'jmek49of': {
      'en': 'Distance Between',
      'de': '',
      'es': '',
      'fr': '',
    },
    'l41emut2': {
      'en': 'From Distance',
      'de': '',
      'es': '',
      'fr': '',
    },
    'iheue23a': {
      'en': '0',
      'de': '',
      'es': '',
      'fr': '',
    },
    'tq8kr8vu': {
      'en': 'To Distance',
      'de': '',
      'es': '',
      'fr': '',
    },
    '4cnw2jqj': {
      'en': '2000',
      'de': '',
      'es': '',
      'fr': '',
    },
    '4ar1jv3k': {
      'en': 'Search  e.g School, Park',
      'de': '',
      'es': '',
      'fr': '',
    },
    '28ehlezs': {
      'en': 'school',
      'de': '',
      'es': '',
      'fr': '',
    },
    'pyvmjhq1': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // placedetail
  {
    'p1qdpcc4': {
      'en': 'Add a place',
      'de': '',
      'es': '',
      'fr': '',
    },
    'r1teu51y': {
      'en': 'Place Name (required)',
      'de': '',
      'es': '',
      'fr': '',
    },
    '7id4jn2u': {
      'en': 'Food & Drinks',
      'de': '',
      'es': '',
      'fr': '',
    },
    'z5dkra1q': {
      'en': 'Shopping',
      'de': '',
      'es': '',
      'fr': '',
    },
    'z4h5y6x7': {
      'en': 'Services',
      'de': '',
      'es': '',
      'fr': '',
    },
    'zkhko1j4': {
      'en': 'Hotels & Lodging',
      'de': '',
      'es': '',
      'fr': '',
    },
    '6lnw22mn': {
      'en': 'Outdoors & Recreation',
      'de': '',
      'es': '',
      'fr': '',
    },
    '3utjhrfm': {
      'en': 'Religion',
      'de': '',
      'es': '',
      'fr': '',
    },
    'xezzq58c': {
      'en': 'Office  & Industrial',
      'de': '',
      'es': '',
      'fr': '',
    },
    '9519y3p6': {
      'en': 'Residental',
      'de': '',
      'es': '',
      'fr': '',
    },
    '29s5tlao': {
      'en': 'Education',
      'de': '',
      'es': '',
      'fr': '',
    },
    '4xjdroqk': {
      'en': 'category (required)',
      'de': '',
      'es': '',
      'fr': '',
    },
    '273hue2x': {
      'en': 'Search for an item...',
      'de': '',
      'es': '',
      'fr': '',
    },
    '078ql83n': {
      'en': 'Address (required)',
      'de': '',
      'es': '',
      'fr': '',
    },
    '06tak398': {
      'en': 'Hours e.g 10am - 5pm',
      'de': '',
      'es': '',
      'fr': '',
    },
    'sxftdmcd': {
      'en': 'Phone Number',
      'de': '',
      'es': '',
      'fr': '',
    },
    'nitlj046': {
      'en': 'Country',
      'de': '',
      'es': '',
      'fr': '',
    },
    '3ui21llg': {
      'en': 'Located within',
      'de': '',
      'es': '',
      'fr': '',
    },
    'calc9x36': {
      'en': 'Website (Optional)',
      'de': '',
      'es': '',
      'fr': '',
    },
    'l2t2qzzf': {
      'en': 'Submit',
      'de': '',
      'es': '',
      'fr': '',
    },
    'km47t8pu': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // map_screen
  {
    'zh7982vr': {
      'en': 'Samanta Campaign ',
      'de': '',
      'es': '',
      'fr': '',
    },
    '8ojk73sz': {
      'en': 'Add place to campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    '5vaw2aht': {
      'en': 'login',
      'de': '',
      'es': '',
      'fr': '',
    },
    't1ro486n': {
      'en': 'Select Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    'msz3wc2r': {
      'en': 'current loction',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ymyag0gf': {
      'en': 'current loction',
      'de': '',
      'es': '',
      'fr': '',
    },
    '1fb72czh': {
      'en': 'select location',
      'de': '',
      'es': '',
      'fr': '',
    },
    'jxajk5pc': {
      'en': 'Distance Between',
      'de': '',
      'es': '',
      'fr': '',
    },
    'st6zfe0p': {
      'en': '0',
      'de': '',
      'es': '',
      'fr': '',
    },
    '9v41wph2': {
      'en': '2000',
      'de': '',
      'es': '',
      'fr': '',
    },
    'vfur6787': {
      'en': 'search key word',
      'de': '',
      'es': '',
      'fr': '',
    },
    'n3k9pllb': {
      'en': 'school',
      'de': '',
      'es': '',
      'fr': '',
    },
    'gj5acyys': {
      'en': 'Save Campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'clbfyeqv': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // welcome_screen
  {
    'qgj11d09': {
      'en': 'Welcome\nTo \nSamantha Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    '5qvmco68': {
      'en':
          'This Campaign app, a powerful tool designed to help you plan, manage, and track your campaigns with ease. With our campaign app, you can create and customize your campaigns, set goals, track progress,  and monitor results all in one convenient place.',
      'de': '',
      'es': '',
      'fr': '',
    },
    'lo9orphs': {
      'en': 'Skip',
      'de': '',
      'es': '',
      'fr': '',
    },
    'bopqwgza': {
      'en': 'Welcome\nTo \nSamantha Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'a1yxf1t8': {
      'en':
          'This Campaign app, a powerful tool designed to help you plan, manage, and track your campaigns with ease. With our campaign app, you can create and customize your campaigns, set goals, track progress,  and monitor results all in one convenient place.',
      'de': '',
      'es': '',
      'fr': '',
    },
    's0nbiu7v': {
      'en': 'Skip',
      'de': '',
      'es': '',
      'fr': '',
    },
    'qpnatwxw': {
      'en': 'Campaign Creation\nFeatures',
      'de': '',
      'es': '',
      'fr': '',
    },
    '0zi2c8g4': {
      'en':
          ' Easily create new campaigns and customize them according to your specific needs. Set campaign goals, define target audiences, and choose the duration and distance.It provides a seamless user experience with a user-friendly interface and intuitive features.',
      'de': '',
      'es': '',
      'fr': '',
    },
    'pge18n08': {
      'en': 'Skip',
      'de': '',
      'es': '',
      'fr': '',
    },
    'gytimjfl': {
      'en': 'Campaign Creation\nFeatures',
      'de': '',
      'es': '',
      'fr': '',
    },
    '8jmqv2jo': {
      'en':
          ' Easily create new campaigns and customize them according to your specific needs. Set campaign goals, define target audiences, and choose the duration and distance.It provides a seamless user experience with a user-friendly interface and intuitive features.',
      'de': '',
      'es': '',
      'fr': '',
    },
    'fvpqubj0': {
      'en': 'Skip',
      'de': '',
      'es': '',
      'fr': '',
    },
    'haird8uq': {
      'en': 'Check Target\nAudience',
      'de': '',
      'es': '',
      'fr': '',
    },
    'zsvt7i18': {
      'en':
          'Set campaign goals, define target audiences, and choose the duration. Our campaign app is designed to simplify the complexities of campaign management, Get started today and take your campaigns to the next level of success!',
      'de': '',
      'es': '',
      'fr': '',
    },
    'kpm3fvv3': {
      'en': 'Get Started',
      'de': '',
      'es': '',
      'fr': '',
    },
    '9zrbcqbn': {
      'en': 'Check Target\nAudience',
      'de': '',
      'es': '',
      'fr': '',
    },
    '2x58936f': {
      'en':
          'Set campaign goals, define target audiences, and choose the duration. Our campaign app is designed to simplify the complexities of campaign management, Get started today and take your campaigns to the next level of success!',
      'de': '',
      'es': '',
      'fr': '',
    },
    '96109gbc': {
      'en': 'Get Started',
      'de': '',
      'es': '',
      'fr': '',
    },
    '07ykr5hy': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // Guest_home_page_screen
  {
    'pn8wq0uq': {
      'en': 'Samanta Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'xqntv7pv': {
      'en': 'Welcome to Samanta Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'qra1hcmk': {
      'en': 'How to create a campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'c54sorxv': {
      'en': 'Our products',
      'de': '',
      'es': '',
      'fr': '',
    },
    '6zni2jn8': {
      'en': 'Login',
      'de': '',
      'es': '',
      'fr': '',
    },
    '2yal41nt': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // Home_Page_Screen
  {
    'x2ht3o2i': {
      'en': 'Campaign Type',
      'de': '',
      'es': '',
      'fr': '',
    },
    '8j1cd42j': {
      'en': 'Campaign Title',
      'de': '',
      'es': '',
      'fr': '',
    },
    'e4exnn1m': {
      'en': 'Active status',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ji4vuhaq': {
      'en': 'View Details',
      'de': '',
      'es': '',
      'fr': '',
    },
    'doj8i1i9': {
      'en': 'Samanta Campaigns\ncreate and manage your Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'dquaqph5': {
      'en': 'My Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    '57260ka1': {
      'en': 'View all',
      'de': '',
      'es': '',
      'fr': '',
    },
    '80eejca8': {
      'en': 'Campaign Title',
      'de': '',
      'es': '',
      'fr': '',
    },
    'gu18te25': {
      'en': 'Campaign Type',
      'de': '',
      'es': '',
      'fr': '',
    },
    '0it93xbx': {
      'en': 'Campaign Title',
      'de': '',
      'es': '',
      'fr': '',
    },
    'qjxnc7jc': {
      'en': 'Campaign Type',
      'de': '',
      'es': '',
      'fr': '',
    },
    '2gkhd50m': {
      'en': 'Campaign Title',
      'de': '',
      'es': '',
      'fr': '',
    },
    'mqt72xnv': {
      'en': 'Campaign Type',
      'de': '',
      'es': '',
      'fr': '',
    },
    'y4ejace8': {
      'en': 'Campaign Title',
      'de': '',
      'es': '',
      'fr': '',
    },
    '4cu49asi': {
      'en': 'Campaign Type',
      'de': '',
      'es': '',
      'fr': '',
    },
    'rh4wy6tq': {
      'en': 'Campaign Title',
      'de': '',
      'es': '',
      'fr': '',
    },
    '2am0zvdm': {
      'en': 'Campaign Type',
      'de': '',
      'es': '',
      'fr': '',
    },
    '18dmlh4a': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // Campaign_List_screen
  {
    'dofq3n7j': {
      'en': 'Campaign Title ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'qzbm37v0': {
      'en': 'Start Date:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'lcw4zjof': {
      'en': '07-07-2023',
      'de': '',
      'es': '',
      'fr': '',
    },
    'b2rk3kje': {
      'en': 'End Date:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    '5evqknw0': {
      'en': '07-07-2023',
      'de': '',
      'es': '',
      'fr': '',
    },
    'y3kqdc8u': {
      'en': 'Scaping  in Process',
      'de': '',
      'es': '',
      'fr': '',
    },
    '7ou4icv5': {
      'en': 'Active campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'tj3aixmb': {
      'en': 'Campaign Title ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'rwiil4bm': {
      'en': 'Start Date:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'o1jdem2l': {
      'en': '07-07-2023',
      'de': '',
      'es': '',
      'fr': '',
    },
    'qlrp8mgz': {
      'en': 'End Date:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'h505kubq': {
      'en': '07-07-2023',
      'de': '',
      'es': '',
      'fr': '',
    },
    '5ip0646e': {
      'en': 'Scaping  in Process',
      'de': '',
      'es': '',
      'fr': '',
    },
    '4wsx781f': {
      'en': 'Active campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'gvsfv7yy': {
      'en': 'Campaign Title ',
      'de': '',
      'es': '',
      'fr': '',
    },
    '41rtz7o7': {
      'en': 'Start Date:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'l8hu82dt': {
      'en': '07-07-2023',
      'de': '',
      'es': '',
      'fr': '',
    },
    'plrg4tpu': {
      'en': 'End Date:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'hr1rimbu': {
      'en': '07-07-2023',
      'de': '',
      'es': '',
      'fr': '',
    },
    'sy6tgon3': {
      'en': 'Scaping  in Process',
      'de': '',
      'es': '',
      'fr': '',
    },
    'qtsiwfe4': {
      'en': 'Active campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'e6drnfpk': {
      'en': 'Campaign Title ',
      'de': '',
      'es': '',
      'fr': '',
    },
    '1ga3pk74': {
      'en': 'Start Date:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'man9qyow': {
      'en': '07-07-2023',
      'de': '',
      'es': '',
      'fr': '',
    },
    'fuzne6jj': {
      'en': 'End Date:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'om0om08z': {
      'en': '07-07-2023',
      'de': '',
      'es': '',
      'fr': '',
    },
    '3i9l57a5': {
      'en': 'Scaping  in Process',
      'de': '',
      'es': '',
      'fr': '',
    },
    'rulwrmxy': {
      'en': 'Active campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'jetkxffy': {
      'en': 'Campaign Title ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'jn2o3ixf': {
      'en': 'Start Date:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    't9x57ynb': {
      'en': '07-07-2023',
      'de': '',
      'es': '',
      'fr': '',
    },
    '4hba5rye': {
      'en': 'End Date:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'qio17uno': {
      'en': '07-07-2023',
      'de': '',
      'es': '',
      'fr': '',
    },
    'nt7v9mtu': {
      'en': 'Scaping  in Process',
      'de': '',
      'es': '',
      'fr': '',
    },
    '5pmra1eu': {
      'en': 'Active campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    '4a782gfq': {
      'en': 'Campaign Title ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'hxnk34is': {
      'en': 'Start Date:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'aw5lb8gf': {
      'en': '07-07-2023',
      'de': '',
      'es': '',
      'fr': '',
    },
    '4obr4t6e': {
      'en': 'End Date:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    '8utvodan': {
      'en': '07-07-2023',
      'de': '',
      'es': '',
      'fr': '',
    },
    'zq3cksyl': {
      'en': 'Scaping  in Process',
      'de': '',
      'es': '',
      'fr': '',
    },
    '4q89rizb': {
      'en': 'Active campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    't4je1uq3': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // Camapign_detail_screen
  {
    'cfu0q2ax': {
      'en': 'Active Campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'fag95zjx': {
      'en': 'Campaign Type ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'hfeb77jg': {
      'en': 'Campaign Title',
      'de': '',
      'es': '',
      'fr': '',
    },
    'cylohzd6': {
      'en': 'Purpose of Campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    '4g1o296u': {
      'en':
          'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.',
      'de': '',
      'es': '',
      'fr': '',
    },
    'k7r5e625': {
      'en': 'Repeat Period',
      'de': '',
      'es': '',
      'fr': '',
    },
    'v6gukfpu': {
      'en': 'Start Date',
      'de': '',
      'es': '',
      'fr': '',
    },
    'oee51iji': {
      'en': 'End Date',
      'de': '',
      'es': '',
      'fr': '',
    },
    'yonvt6yu': {
      'en': 'Budget:  ',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ay8pw5qp': {
      'en': '\$',
      'de': '',
      'es': '',
      'fr': '',
    },
    '73hopw5q': {
      'en': 'Lounch Campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'eymtx3a7': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // Create_camapign_screen
  {
    'kv0q4lmh': {
      'en': 'Create Campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'lu4lpjjc': {
      'en': 'Enter campaign title',
      'de': '',
      'es': '',
      'fr': '',
    },
    'msvp29lw': {
      'en': 'Purpose of Campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'pjtbkk6r': {
      'en': 'Product Launch Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ol72vlta': {
      'en': 'Brand Awareness Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'lwb9rbah': {
      'en': 'Lead Generation Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'p3unct1b': {
      'en': 'Social Media Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ug6fujr6': {
      'en': 'Email Marketing Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ui0bc6oh': {
      'en': 'Content Marketing Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    '5zbakqzy': {
      'en': 'others',
      'de': '',
      'es': '',
      'fr': '',
    },
    '9215556g': {
      'en': 'Campaign type',
      'de': '',
      'es': '',
      'fr': '',
    },
    'zvi81lwn': {
      'en': 'Search for an item...',
      'de': '',
      'es': '',
      'fr': '',
    },
    'wfa1won6': {
      'en': 'Daily',
      'de': '',
      'es': '',
      'fr': '',
    },
    'uniimtb1': {
      'en': 'Fortnight',
      'de': '',
      'es': '',
      'fr': '',
    },
    'bpx4pvcx': {
      'en': 'Weekly',
      'de': '',
      'es': '',
      'fr': '',
    },
    'i638kv6x': {
      'en': 'Monthly',
      'de': '',
      'es': '',
      'fr': '',
    },
    '8gdho69n': {
      'en': 'Quarterly',
      'de': '',
      'es': '',
      'fr': '',
    },
    '1nh4mwn3': {
      'en': 'Repeat Period',
      'de': '',
      'es': '',
      'fr': '',
    },
    'bc04n75d': {
      'en': 'Search for an item...',
      'de': '',
      'es': '',
      'fr': '',
    },
    'opxgnrmg': {
      'en': 'Budget',
      'de': '',
      'es': '',
      'fr': '',
    },
    'jmf5otzq': {
      'en': 'Create',
      'de': '',
      'es': '',
      'fr': '',
    },
    '55knm937': {
      'en': 'Field is required',
      'de': '',
      'es': '',
      'fr': '',
    },
    'z911tnl5': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
      'fr': '',
    },
    'sarbjayd': {
      'en': 'Field is required',
      'de': '',
      'es': '',
      'fr': '',
    },
    'sujj7ldc': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
      'fr': '',
    },
    '6jq0c351': {
      'en': 'Field is required',
      'de': '',
      'es': '',
      'fr': '',
    },
    'iimmgynv': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
      'fr': '',
    },
    'icoxia1y': {
      'en': 'Field is required',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ehnorafk': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
      'fr': '',
    },
    'g5y4ifko': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // Send_Email_screen
  {
    'aekjlr88': {
      'en': 'Send Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    'xs4ot5ge': {
      'en': 'Sender Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ybychqyv': {
      'en': 'email address of the sende',
      'de': '',
      'es': '',
      'fr': '',
    },
    'f7gw7or2': {
      'en': 'Email Subject',
      'de': '',
      'es': '',
      'fr': '',
    },
    'gb0q0pym': {
      'en': 'email sabjuct',
      'de': '',
      'es': '',
      'fr': '',
    },
    'wet5gksh': {
      'en': 'campaign title',
      'de': '',
      'es': '',
      'fr': '',
    },
    'f2t3dlxh': {
      'en': 'Purpose of Campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'fuae1yn2': {
      'en':
          'Lorem ipsum dolor sit aLorem ipsum dolor sit amet, consectetur  sit amet, adipiscing elit. Nunc vitae commodo  sit amet, augue.Lorem ipsum Lorem ipsum dolor sit aLorem ipsum dolor sit amet,adipiscing elit. Nunc vitae commodo  sit amet, augue.Lorem ipsum ',
      'de': '',
      'es': '',
      'fr': '',
    },
    '092jshnn': {
      'en': 'Additional Details',
      'de': '',
      'es': '',
      'fr': '',
    },
    'kxyt07yy': {
      'en': 'Additional details',
      'de': '',
      'es': '',
      'fr': '',
    },
    'hsasesoh': {
      'en': 'Attachments',
      'de': '',
      'es': '',
      'fr': '',
    },
    '5vsqbuew': {
      'en': 'Send Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    '1aerevik': {
      'en': 'Normal Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    '58sgs2p1': {
      'en': 'Normal Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    't3w84zcc': {
      'en': 'Html Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    '5ggdk497': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // view_scraped_data_screen
  {
    '4xf5pqaq': {
      'en': 'Scraped Data',
      'de': '',
      'es': '',
      'fr': '',
    },
    '0kqoanyu': {
      'en': 'User Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    'sxvpgwnw': {
      'en': 'Phone Number',
      'de': '',
      'es': '',
      'fr': '',
    },
    'clgizeso': {
      'en': 'Address & Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    '8x3gryqe': {
      'en': 'User Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    'caqor2jo': {
      'en': 'Phone Number',
      'de': '',
      'es': '',
      'fr': '',
    },
    'b1fqs48j': {
      'en': 'Address & Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    'bb6mn8q4': {
      'en': 'User Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    '2u5m04l1': {
      'en': 'Phone Number',
      'de': '',
      'es': '',
      'fr': '',
    },
    'g2a7jahj': {
      'en': 'Address & Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    'j108izg8': {
      'en': 'User Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    'xn2g9rst': {
      'en': 'Phone Number',
      'de': '',
      'es': '',
      'fr': '',
    },
    'sv3p7q9w': {
      'en': 'Address & Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    '1ruj6hgm': {
      'en': 'User Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    't7w3edtu': {
      'en': 'Phone Number',
      'de': '',
      'es': '',
      'fr': '',
    },
    'nluamvi2': {
      'en': 'Address & Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    'tzts03dh': {
      'en': 'User Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    'gze8s0zw': {
      'en': 'Phone Number',
      'de': '',
      'es': '',
      'fr': '',
    },
    'l18wbyzj': {
      'en': 'Address & Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    '6ybyvrny': {
      'en': 'User Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    'xkhzy91c': {
      'en': 'Phone Number',
      'de': '',
      'es': '',
      'fr': '',
    },
    'wlfzyrnq': {
      'en': 'Address & Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    '0vjyp5bl': {
      'en': 'User Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    'zy9br3tm': {
      'en': 'Phone Number',
      'de': '',
      'es': '',
      'fr': '',
    },
    'u4etrda2': {
      'en': 'Address & Location',
      'de': '',
      'es': '',
      'fr': '',
    },
    'hpmhr8v2': {
      'en': 'Send Email',
      'de': '',
      'es': '',
      'fr': '',
    },
    'btzggitz': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // Edit_campaign_screen_page
  {
    'a9bzpt61': {
      'en': 'Edit Campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'd5sbcslp': {
      'en': 'Enter campaign title',
      'de': '',
      'es': '',
      'fr': '',
    },
    '1lr5fs0c': {
      'en': 'My Campaign title',
      'de': '',
      'es': '',
      'fr': '',
    },
    'e62a9a1c': {
      'en': 'Purpose of Campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    '5i29gg3t': {
      'en': 'Email Marketing Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'q2oug295': {
      'en': 'Product Launch Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'vuqldxb2': {
      'en': 'Brand Awareness Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'rqtcmiil': {
      'en': 'Lead Generation Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    '54t1yowb': {
      'en': 'Social Media Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'tqdm6vov': {
      'en': 'Email Marketing Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'bs73mb64': {
      'en': 'Content Marketing Campaigns',
      'de': '',
      'es': '',
      'fr': '',
    },
    'txdgzoba': {
      'en': 'others',
      'de': '',
      'es': '',
      'fr': '',
    },
    'n7dwaagk': {
      'en': 'Campaign type',
      'de': '',
      'es': '',
      'fr': '',
    },
    'apbpwmnj': {
      'en': 'Search for an item...',
      'de': '',
      'es': '',
      'fr': '',
    },
    'v1fg47j6': {
      'en': 'Weekly',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ktr3ho0z': {
      'en': 'Daily',
      'de': '',
      'es': '',
      'fr': '',
    },
    '4iuw34y5': {
      'en': 'Fortnight',
      'de': '',
      'es': '',
      'fr': '',
    },
    'qtefh43k': {
      'en': 'Weekly',
      'de': '',
      'es': '',
      'fr': '',
    },
    'fgzscfx2': {
      'en': 'Monthly',
      'de': '',
      'es': '',
      'fr': '',
    },
    '6qko21kh': {
      'en': 'Quarterly',
      'de': '',
      'es': '',
      'fr': '',
    },
    '862x2mny': {
      'en': 'Repeat Period',
      'de': '',
      'es': '',
      'fr': '',
    },
    'dsh0f1p7': {
      'en': 'Search for an item...',
      'de': '',
      'es': '',
      'fr': '',
    },
    '2j4bggum': {
      'en': 'Budget',
      'de': '',
      'es': '',
      'fr': '',
    },
    '2l9j1r8p': {
      'en': 'Edit',
      'de': '',
      'es': '',
      'fr': '',
    },
    'biageb7b': {
      'en': 'Field is required',
      'de': '',
      'es': '',
      'fr': '',
    },
    't9ymompw': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
      'fr': '',
    },
    '4l3lv97x': {
      'en': 'Field is required',
      'de': '',
      'es': '',
      'fr': '',
    },
    '3nqr5p5d': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
      'fr': '',
    },
    'elenl34s': {
      'en': 'Field is required',
      'de': '',
      'es': '',
      'fr': '',
    },
    '6q6kr19u': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
      'fr': '',
    },
    's2cisnfy': {
      'en': 'Field is required',
      'de': '',
      'es': '',
      'fr': '',
    },
    'qqjn5kkm': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
      'fr': '',
    },
    'zw9ugo4s': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // help_page_screen
  {
    'qdfyefrw': {
      'en': 'How It works',
      'de': '',
      'es': '',
      'fr': '',
    },
    'jjcq4rvj': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // subscribers_list_screen
  {
    'pi2eiino': {
      'en': 'Subscribers',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ln4ixjly': {
      'en': 'Unsubscried',
      'de': '',
      'es': '',
      'fr': '',
    },
    '9e086cvp': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // menu_components
  {
    '5b7x6f9s': {
      'en': 'Home',
      'de': '',
      'es': '',
      'fr': '',
    },
    '92nm2pa8': {
      'en': 'Create campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'cjgw8i76': {
      'en': 'How it works',
      'de': '',
      'es': '',
      'fr': '',
    },
    '2ta8ziic': {
      'en': 'Settings',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ehd9spov': {
      'en': 'Logout',
      'de': '',
      'es': '',
      'fr': '',
    },
    '279k7anz': {
      'en': 'version',
      'de': '',
      'es': '',
      'fr': '',
    },
    '2pnw6t7r': {
      'en': ' - 1.001',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // ask_send_email_component
  {
    '3ny4r8l0': {
      'en': 'View Data',
      'de': '',
      'es': '',
      'fr': '',
    },
    '563bajfa': {
      'en': 'Send Email',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // AddPlace_dialog_box_component
  {
    '4ngu8yu9': {
      'en': 'Do you want to add the place \nto your campaign ?',
      'de': '',
      'es': '',
      'fr': '',
    },
    'uy04zdqd': {
      'en': 'No',
      'de': '',
      'es': '',
      'fr': '',
    },
    'xr0w3sfb': {
      'en': 'Yes',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // select_place_error_component
  {
    'j3psq8my': {
      'en':
          'You haven\'t selected any place\nfor the campaign please add a place first',
      'de': '',
      'es': '',
      'fr': '',
    },
    'q3va8xol': {
      'en': 'Close',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // Complete_campaig_info_dialog
  {
    'k8bx2vtt': {
      'en': 'Complete the information and save your campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'ye00o31o': {
      'en': 'Continue',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // place_adde_success_dialog
  {
    'jfegcctb': {
      'en':
          'Place is added to your Campaign add more places or save you campaign now',
      'de': '',
      'es': '',
      'fr': '',
    },
    '5mgwzze9': {
      'en': 'OK',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // campaign_created_success_dialog
  {
    'uh5o01qq': {
      'en': 'Campaign created successfully',
      'de': '',
      'es': '',
      'fr': '',
    },
    '89g1tqsp': {
      'en': 'OK',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // campaign_delete_confirm_dialog
  {
    'upm6so2q': {
      'en': 'Do you want to delete this campaign',
      'de': '',
      'es': '',
      'fr': '',
    },
    'vhou6x5q': {
      'en': 'Cancle',
      'de': '',
      'es': '',
      'fr': '',
    },
    '54kzi7t1': {
      'en': 'Delete',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // campaign_edit_success_dialog
  {
    'jlxjpy90': {
      'en': 'Campaign edited successfully',
      'de': '',
      'es': '',
      'fr': '',
    },
    'krfvjxdn': {
      'en': 'OK',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // campaign_delete_success_dialog
  {
    'r9a2alcw': {
      'en': 'Campaign deleted successfully',
      'de': '',
      'es': '',
      'fr': '',
    },
    'wq7k8u2i': {
      'en': 'OK',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // email_sent_success_dialogCopy
  {
    '49jp68az': {
      'en':
          'Email sent successfully please check your email for more information',
      'de': '',
      'es': '',
      'fr': '',
    },
    'lp4x2wuw': {
      'en': 'OK',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // search_component
  {
    'ptnzcx43': {
      'en': 'Type here',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
  // Miscellaneous
  {
    'znfgdv7b': {
      'en':
          'Your location helps us to show you the nearby places  aroubd you, and also provide valuable tips.',
      'de': '',
      'es':
          'Su ubicación nos ayuda a mostrarle los lugares cercanos a su alrededor y también le proporciona valiosos consejos.',
      'fr':
          'Votre emplacement nous aide à vous montrer les endroits à proximité autour de vous, et également à vous fournir de précieux conseils.',
    },
    'whr1kc7s': {
      'en':
          'Your location helps us to show you the nearby places  aroubd you, and also provide valuable tips.',
      'de': '',
      'es': '',
      'fr': '',
    },
    '91xa7o6a': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    's2tp8tfd': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '6o63037m': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'l6f6rrmz': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'h907nzcb': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'agqhhu4m': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'rx5q6130': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'v2p3x6q6': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'eokn12t0': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'lcbsya8a': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'rarwlnc9': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'xfqeeijv': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'l1v04iq5': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'e4391ze6': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'y2qe3tkp': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '3jzm2y0l': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '5or1ib2s': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '1l8l0xif': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'gdam051i': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'e93us677': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'vuuf8ts7': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    '3scr7y08': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
    'kzgse0ys': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
