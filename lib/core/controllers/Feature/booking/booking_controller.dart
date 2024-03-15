import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saralnova/core/model/country_model.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_bottom_sheets.dart/booking_calandar_bottom_sheet.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_country_screen.dart';
import 'package:saralnova/features/screens/Feature/rooms/room_type_bottom_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../features/widgets/common_widgets/loading_dialog.dart';
import '../../../../features/widgets/common_widgets/sky_snack_bar.dart';
import '../../../model/feature_model/room_type_model.dart';
import '../../../model/rooms_model.dart';
import '../../../repo/feature_repo/booking_repo.dart';

enum BookingState { DATEROOMS, OPTIONS, INFORMATION, CONFIRM }

enum PageState { EMPTY, LOADING, NORMAL, ERROR }

class BookingController extends GetxController {
  List<CountryModel> countries = [
    {'key': 'AF', 'country': 'Afghanistan'},
    {'key': 'AX', 'country': 'Åland Islands'},
    {'key': 'AL', 'country': 'Albania'},
    {'key': 'DZ', 'country': 'Algeria'},
    {'key': 'AS', 'country': 'American Samoa'},
    {'key': 'AD', 'country': 'Andorra'},
    {'key': 'AF', 'country': 'Afghanistan'},
    {'key': 'AX', 'country': 'Åland Islands'},
    {'key': 'AL', 'country': 'Albania'},
    {'key': 'DZ', 'country': 'Algeria'},
    {'key': 'AS', 'country': 'American Samoa'},
    {'key': 'AD', 'country': 'Andorra'},
    {'key': 'AO', 'country': 'Angola'},
    {'key': 'AI', 'country': 'Anguilla'},
    {'key': 'AQ', 'country': 'Antarctica'},
    {'key': 'AG', 'country': 'Antigua and Barbuda'},
    {'key': 'AR', 'country': 'Argentina'},
    {'key': 'AM', 'country': 'Armenia'},
    {'key': 'AW', 'country': 'Aruba'},
    {'key': 'AU', 'country': 'Australia'},
    {'key': 'AT', 'country': 'Austria'},
    {'key': 'AZ', 'country': 'Azerbaijan'},
    {'key': 'BS', 'country': 'Bahamas'},
    {'key': 'BH', 'country': 'Bahrain'},
    {'key': 'BD', 'country': 'Bangladesh'},
    {'key': 'BB', 'country': 'Barbados'},
    {'key': 'BY', 'country': 'Belarus'},
    {'key': 'BE', 'country': 'Belgium'},
    {'key': 'BZ', 'country': 'Belize'},
    {'key': 'BJ', 'country': 'Benin'},
    {'key': 'BM', 'country': 'Bermuda'},
    {'key': 'BT', 'country': 'Bhutan'},
    {'key': 'BO', 'country': 'Bolivia'},
    {'key': 'BA', 'country': 'Bosnia and Herzegovina'},
    {'key': 'BW', 'country': 'Botswana'},
    {'key': 'BV', 'country': 'Bouvet Island'},
    {'key': 'BR', 'country': 'Brazil'},
    {'key': 'IO', 'country': 'British Indian Ocean Territory'},
    {'key': 'BN', 'country': 'Brunei Darussalam'},
    {'key': 'BG', 'country': 'Bulgaria'},
    {'key': 'BF', 'country': 'Burkina Faso'},
    {'key': 'BI', 'country': 'Burundi'},
    {'key': 'KH', 'country': 'Cambodia'},
    {'key': 'CM', 'country': 'Cameroon'},
    {'key': 'CA', 'country': 'Canada'},
    {'key': 'CV', 'country': 'Cape Verde'},
    {'key': 'KY', 'country': 'Cayman Islands'},
    {'key': 'CF', 'country': 'Central African Republic'},
    {'key': 'TD', 'country': 'Chad'},
    {'key': 'CL', 'country': 'Chile'},
    {'key': 'CN', 'country': 'China'},
    {'key': 'CX', 'country': 'Christmas Island'},
    {'key': 'CC', 'country': 'Cocos (Keeling) Islands'},
    {'key': 'CO', 'country': 'Colombia'},
    {'key': 'KM', 'country': 'Comoros'},
    {'key': 'CG', 'country': 'Congo'},
    {'key': 'CD', 'country': 'Congo, Democratic Republic of the'},
    {'key': 'CK', 'country': 'Cook Islands'},
    {'key': 'CR', 'country': 'Costa Rica'},
    {'key': 'CI', 'country': 'Côte d Ivoire'},
    {'key': 'HR', 'country': 'Croatia'},
    {'key': 'CU', 'country': 'Cuba'},
    {'key': 'CY', 'country': 'Cyprus'},
    {'key': 'CZ', 'country': 'Czech Republic'},
    {'key': 'DK', 'country': 'Denmark'},
    {'key': 'DJ', 'country': 'Djibouti'},
    {'key': 'DM', 'country': 'Dominica'},
    {'key': 'DO', 'country': 'Dominican Republic'},
    {'key': 'EC', 'country': 'Ecuador'},
    {'key': 'EG', 'country': 'Egypt'},
    {'key': 'SV', 'country': 'El Salvador'},
    {'key': 'GQ', 'country': 'Equatorial Guinea'},
    {'key': 'ER', 'country': 'Eritrea'},
    {'key': 'EE', 'country': 'Estonia'},
    {'key': 'ET', 'country': 'Ethiopia'},
    {'key': 'FK', 'country': 'Falkland Islands (Malvinas)'},
    {'key': 'FO', 'country': 'Faroe Islands'},
    {'key': 'FJ', 'country': 'Fiji'},
    {'key': 'FI', 'country': 'Finland'},
    {'key': 'FR', 'country': 'France'},
    {'key': 'GF', 'country': 'French Guiana'},
    {'key': 'PF', 'country': 'French Polynesia'},
    {'key': 'TF', 'country': 'French Southern Territories'},
    {'key': 'GA', 'country': 'Gabon'},
    {'key': 'GM', 'country': 'Gambia'},
    {'key': 'GE', 'country': 'Georgia'},
    {'key': 'DE', 'country': 'Germany'},
    {'key': 'GH', 'country': 'Ghana'},
    {'key': 'GI', 'country': 'Gibraltar'},
    {'key': 'GR', 'country': 'Greece'},
    {'key': 'GL', 'country': 'Greenland'},
    {'key': 'GD', 'country': 'Grenada'},
    {'key': 'GP', 'country': 'Guadeloupe'},
    {'key': 'GU', 'country': 'Guam'},
    {'key': 'GT', 'country': 'Guatemala'},
    {'key': 'GG', 'country': 'Guernsey'},
    {'key': 'GN', 'country': 'Guinea'},
    {'key': 'GW', 'country': 'Guinea-Bissau'},
    {'key': 'GY', 'country': 'Guyana'},
    {'key': 'HT', 'country': 'Haiti'},
    {'key': 'HM', 'country': 'Heard Island and McDonald Islands'},
    {'key': 'VA', 'country': 'Holy See (Vatican City State)'},
    {'key': 'HN', 'country': 'Honduras'},
    {'key': 'HK', 'country': 'Hong Kong'},
    {'key': 'HU', 'country': 'Hungary'},
    {'key': 'IS', 'country': 'Iceland'},
    {'key': 'IN', 'country': 'India'},
    {'key': 'ID', 'country': 'Indonesia'},
    {'key': 'IR', 'country': 'Iran, Islamic Republic of'},
    {'key': 'IQ', 'country': 'Iraq'},
    {'key': 'IE', 'country': 'Ireland'},
    {'key': 'IM', 'country': 'Isle of Man'},
    {'key': 'IL', 'country': 'Israel'},
    {'key': 'IT', 'country': 'Italy'},
    {'key': 'JM', 'country': 'Jamaica'},
    {'key': 'JP', 'country': 'Japan'},
    {'key': 'JE', 'country': 'Jersey'},
    {'key': 'JO', 'country': 'Jordan'},
    {'key': 'KZ', 'country': 'Kazakhstan'},
    {'key': 'KE', 'country': 'Kenya'},
    {'key': 'KI', 'country': 'Kiribati'},
    {'key': 'KP', 'country': "Korea, Democratic People's Republic of"},
    {'key': 'KR', 'country': 'Korea, Republic of'},
    {'key': 'KW', 'country': 'Kuwait'},
    {'key': 'KG', 'country': 'Kyrgyzstan'},
    {'key': 'LA', 'country': "Lao People's Democratic Republic"},
    {'key': 'LV', 'country': 'Latvia'},
    {'key': 'LB', 'country': 'Lebanon'},
    {'key': 'LS', 'country': 'Lesotho'},
    {'key': 'LR', 'country': 'Liberia'},
    {'key': 'LY', 'country': 'Libyan Arab Jamahiriya'},
    {'key': 'LI', 'country': 'Liechtenstein'},
    {'key': 'LT', 'country': 'Lithuania'},
    {'key': 'LU', 'country': 'Luxembourg'},
    {'key': 'MO', 'country': 'Macao'},
    {'key': 'MK', 'country': 'Macedonia, the Former Yugoslav Republic of'},
    {'key': 'MG', 'country': 'Madagascar'},
    {'key': 'MW', 'country': 'Malawi'},
    {'key': 'MY', 'country': 'Malaysia'},
    {'key': 'MV', 'country': 'Maldives'},
    {'key': 'ML', 'country': 'Mali'},
    {'key': 'MT', 'country': 'Malta'},
    {'key': 'MH', 'country': 'Marshall Islands'},
    {'key': 'MQ', 'country': 'Martinique'},
    {'key': 'MR', 'country': 'Mauritania'},
    {'key': 'MU', 'country': 'Mauritius'},
    {'key': 'YT', 'country': 'Mayotte'},
    {'key': 'MX', 'country': 'Mexico'},
    {'key': 'FM', 'country': 'Micronesia, Federated States of'},
    {'key': 'MD', 'country': 'Moldova, Republic of'},
    {'key': 'MC', 'country': 'Monaco'},
    {'key': 'MN', 'country': 'Mongolia'},
    {'key': 'ME', 'country': 'Montenegro'},
    {'key': 'MS', 'country': 'Montserrat'},
    {'key': 'MA', 'country': 'Morocco'},
    {'key': 'MZ', 'country': 'Mozambique'},
    {'key': 'MM', 'country': 'Myanmar'},
    {'key': 'NA', 'country': 'Namibia'},
    {'key': 'NR', 'country': 'Nauru'},
    {'key': 'NP', 'country': 'Nepal'},
    {'key': 'NL', 'country': 'Netherlands'},
    {'key': 'AN', 'country': 'Netherlands Antilles'},
    {'key': 'NC', 'country': 'New Caledonia'},
    {'key': 'NZ', 'country': 'New Zealand'},
    {'key': 'NI', 'country': 'Nicaragua'},
    {'key': 'NE', 'country': 'Niger'},
    {'key': 'NG', 'country': 'Nigeria'},
    {'key': 'NU', 'country': 'Niue'},
    {'key': 'NF', 'country': 'Norfolk Island'},
    {'key': 'MP', 'country': 'Northern Mariana Islands'},
    {'key': 'NO', 'country': 'Norway'},
    {'key': 'OM', 'country': 'Oman'},
    {'key': 'PK', 'country': 'Pakistan'},
    {'key': 'PW', 'country': 'Palau'},
    {'key': 'PS', 'country': 'Palestinian Territory, Occupied'},
    {'key': 'PA', 'country': 'Panama'},
    {'key': 'PG', 'country': 'Papua New Guinea'},
    {'key': 'PY', 'country': 'Paraguay'},
    {'key': 'PE', 'country': 'Peru'},
    {'key': 'PH', 'country': 'Philippines'},
    {'key': 'PN', 'country': 'Pitcairn'},
    {'key': 'PL', 'country': 'Poland'},
    {'key': 'PT', 'country': 'Portugal'},
    {'key': 'PR', 'country': 'Puerto Rico'},
    {'key': 'QA', 'country': 'Qatar'},
    {'key': 'RE', 'country': 'Réunion'},
    {'key': 'RO', 'country': 'Romania'},
    {'key': 'RU', 'country': 'Russian Federation'},
    {'key': 'RW', 'country': 'Rwanda'},
    {'key': 'BL', 'country': 'Saint Barthélemy'},
    {'key': 'SH', 'country': 'Saint Helena'},
    {'key': 'KN', 'country': 'Saint Kitts and Nevis'},
    {'key': 'LC', 'country': 'Saint Lucia'},
    {'key': 'MF', 'country': 'Saint Martin (French part)'},
    {'key': 'PM', 'country': 'Saint Pierre and Miquelon'},
    {'key': 'VC', 'country': 'Saint Vincent and the Grenadines'},
    {'key': 'WS', 'country': 'Samoa'},
    {'key': 'SM', 'country': 'San Marino'},
    {'key': 'ST', 'country': 'Sao Tome and Principe'},
    {'key': 'SA', 'country': 'Saudi Arabia'},
    {'key': 'SN', 'country': 'Senegal'},
    {'key': 'RS', 'country': 'Serbia'},
    {'key': 'SC', 'country': 'Seychelles'},
    {'key': 'SL', 'country': 'Sierra Leone'},
    {'key': 'SG', 'country': 'Singapore'},
    {'key': 'SK', 'country': 'Slovakia'},
    {'key': 'SI', 'country': 'Slovenia'},
    {'key': 'SB', 'country': 'Solomon Islands'},
    {'key': 'SO', 'country': 'Somalia'},
    {'key': 'ZA', 'country': 'South Africa'},
    {'key': 'GS', 'country': 'South Georgia and the South Sandwich Islands'},
    {'key': 'ES', 'country': 'Spain'},
    {'key': 'LK', 'country': 'Sri Lanka'},
    {'key': 'SD', 'country': 'Sudan'},
    {'key': 'SR', 'country': 'Suriname'},
    {'key': 'SJ', 'country': 'Svalbard and Jan Mayen'},
    {'key': 'SZ', 'country': 'Swaziland'},
    {'key': 'SE', 'country': 'Sweden'},
    {'key': 'CH', 'country': 'Switzerland'},
    {'key': 'SY', 'country': 'Syrian Arab Republic'},
    {'key': 'TW', 'country': 'Taiwan, Province of China'},
    {'key': 'TJ', 'country': 'Tajikistan'},
    {'key': 'TZ', 'country': 'Tanzania, United Republic of'},
    {'key': 'TH', 'country': 'Thailand'},
    {'key': 'TL', 'country': 'Timor-Leste'},
    {'key': 'TG', 'country': 'Togo'},
    {'key': 'TK', 'country': 'Tokelau'},
    {'key': 'TO', 'country': 'Tonga'},
    {'key': 'TT', 'country': 'Trinidad and Tobago'},
    {'key': 'TN', 'country': 'Tunisia'},
    {'key': 'TR', 'country': 'Turkey'},
    {'key': 'TM', 'country': 'Turkmenistan'},
    {'key': 'TC', 'country': 'Turks and Caicos Islands'},
    {'key': 'TV', 'country': 'Tuvalu'},
    {'key': 'UG', 'country': 'Uganda'},
    {'key': 'UA', 'country': 'Ukraine'},
    {'key': 'AE', 'country': 'United Arab Emirates'},
    {'key': 'GB', 'country': 'United Kingdom'},
    {'key': 'US', 'country': 'United States'},
    {'key': 'UM', 'country': 'United States Minor Outlying Islands'},
    {'key': 'UY', 'country': 'Uruguay'},
    {'key': 'UZ', 'country': 'Uzbekistan'},
    {'key': 'VU', 'country': 'Vanuatu'},
    {'key': 'VE', 'country': 'Venezuela, Bolivarian Republic of'},
    {'key': 'VN', 'country': 'Viet Nam'},
    {'key': 'VG', 'country': 'Virgin Islands, British'},
    {'key': 'VI', 'country': 'Virgin Islands, U.S.'},
    {'key': 'WF', 'country': 'Wallis and Futuna'},
    {'key': 'EH', 'country': 'Western Sahara'},
    {'key': 'YE', 'country': 'Yemen'},
    {'key': 'ZM', 'country': 'Zambia'},
    {'key': 'ZW', 'country': 'Zimbabwe'}
    // Add more countries here
  ].map((json) {
    return CountryModel(
      key: json['key'],
      countryName: json['country'],
    );
  }).toList();

  openCountryBottomSheet() async {
    showModalBottomSheet(
        isScrollControlled: true,
        context: Get.context!,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: CountryBottomSheet(
              onSelectCountry: (country) {
                countryController.text = country.countryName.toString();

                this.country.value = country;
                // if (crudState.value == CRUDSTATE.UPDATE) {
                //   updateIndex.value = roomType.id;
                // }
              },
            ),
          );
        });
  }

  var bookingState = BookingState.DATEROOMS.obs;
  var pageState = PageState.EMPTY.obs;
  PageController pageController = PageController();

  final roomTypeController = TextEditingController();
  final countryController = TextEditingController();
  RxInt guestNumber = RxInt(1);

  onIncrement() {
    if (guestNumber.value >= 1) {
      guestNumber.value += 1;
    }
  }

  onDecrement() {
    if (guestNumber.value > 1) {
      guestNumber.value -= 1;
    }
  }

  setActiveIndex(int index) {
    switch (index) {
      case 0:
        bookingState.value = BookingState.DATEROOMS;
        break;
      case 1:
        bookingState.value = BookingState.OPTIONS;
        break;
      case 2:
        bookingState.value = BookingState.INFORMATION;
        break;
      default:
        bookingState.value = BookingState.CONFIRM;
        break;
    }
  }

  // onNext() {
  //   if (activeIndex.value >= 0 && activeIndex.value < 3) {
  //     activeIndex.value += 1;
  //     setActiveIndex(activeIndex.value);
  //   }
  // }

  // onBack() {
  //   if (activeIndex.value > 0 && activeIndex.value <= 3) {
  //     activeIndex.value -= 1;
  //     setActiveIndex(activeIndex.value);
  //   }
  // }

  Rxn<RoomType> roomType = Rxn();
  openRoomTypeBottomSheet() async {
    showModalBottomSheet(
        isScrollControlled: true,
        context: Get.context!,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: RoomTypeBottomSheet(
              onSelectRoomType: (roomType) {
                roomTypeController.text = roomType.title.toString();

                this.roomType.value = roomType;
                // if (crudState.value == CRUDSTATE.UPDATE) {
                //   updateIndex.value = roomType.id;
                // }
              },
            ),
          );
        });
  }

  final RxInt _currentIndex = 0.obs;
  RxBool currentIndexEnabled = RxBool(false);

  int get currentIndex => _currentIndex.value;
  changeIndex(int value) {
    pageController.animateToPage(
      value,
      duration: const Duration(
        milliseconds: 200,
      ),
      curve: Curves.easeInOutCubicEmphasized,
    );
    _currentIndex.value = value;
  }

  // onNext() {
  //   if (currentIndex >= 0 && currentIndex < 3) {
  //     _currentIndex.value += 1;
  //     setActiveIndex(currentIndex);
  //     changeIndex(currentIndex);
  //   }
  // }
  void onNext() {
    switch (currentIndex) {
      case 0:
        if (dateRoomKey.currentState!.validate()) {
          _currentIndex.value++;
          changeIndex(currentIndex);
          currentIndexEnabled.value = true;
        }
    }
  }

  Rxn<CountryModel> country = Rxn();

  void onsubmit() async {
    // print(country.value?.key);
    // print(country.value?.countryName);

    // ---------------------------print dates
    print("--page state----${pageState.value}");
    print("list-----${availableRoomList}");
    // print("--strtdate-----${startFromDate.value}");

    // print("--enddate-----${endToDate.value}");

    // print("00000000000000");
    // print("--selectedDate-----${selectedDate.value}");
    // print("--dateCount-----${dateCount.value}");
    // print("--range-----${range.value}");
    // print("--rangeCount-----${rangeCount.value}");

    // print("---roomType----${roomType.value}");
    // print("---roomType--id--${roomType.value?.id}");
    // print("---roomType--txt--${roomTypeController.text}");
  }

  List<Country>? dataList = [
    Country(
      id: "1",
      country: "Afghanistan",
      totalConfirmed: 12345,
      totalDeaths: 567,
    ),
    Country(
      id: "2",
      country: "Albania",
      totalConfirmed: 45678,
      totalDeaths: 890,
    ),
    Country(
      id: "3",
      country: "Algeria",
      totalConfirmed: 78901,
      totalDeaths: 234,
    ),
    Country(
      id: "4",
      country: "Andorra",
      totalConfirmed: 23456,
      totalDeaths: 678,
    ),
  ];

  //open calanader bottom sheet

  RxString selectedDate = RxString("");
  RxString dateCount = RxString("");
  RxString range = RxString("");
  RxString rangeCount = RxString("");
  RxString startFromDate = RxString("");
  RxString endToDate = RxString("");
  final checkInOutRangeController = TextEditingController();

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      DateTime startDate = args.value.startDate;
      DateTime endDate = args.value.endDate ?? args.value.startDate;

      range.value =
          '${DateFormat('yyyy-MM-dd').format(startDate)}  -TO-  ${DateFormat('yyyy-MM-dd').format(endDate)}';
      checkInOutRangeController.text = range.value;

      startFromDate.value = DateFormat('yyyy-MM-dd').format(startDate);
      endToDate.value = DateFormat('yyyy-MM-dd').format(endDate);
    } else if (args.value is DateTime) {
      selectedDate.value = args.value.toString();
    } else if (args.value is List<DateTime>) {
      dateCount.value = args.value.length.toString();
    } else {
      rangeCount.value = args.value.length.toString();
    }
  }

  openCalendarBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BookingCalandarBottomSheet(),
        );
      },
    );
  }

  //search available rooms
  // RxBool isVisible = RxBool(false);
  RxList<Rooms> availableRoomList = RxList();
  final dateRoomKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();
  void getAvailableRooms() async {
    if (dateRoomKey.currentState!.validate()) {
      pageState.value = PageState.LOADING;

      loading.show();
      availableRoomList.clear();

      BookingRepo.searchAvailableRooms(
        roomType: roomType.value?.id,
        checkInDate: startFromDate.value,
        checkOutDate: endToDate.value,
        guestCount: guestNumber.value.toString(),
        onSuccess: (availableRooms) {
          loading.hide();

          if (availableRooms.isNotEmpty) {
            // isVisible.value = true;
            availableRoomList.addAll(availableRooms);
            pageState.value = PageState.NORMAL;
          } else {
            // isVisible.value = false;
            pageState.value = PageState.ERROR;
          }
        },
        onError: (message) {
          loading.hide();
          pageState.value == PageState.ERROR;

          SkySnackBar.error(title: "Available Rooms", message: message);
        },
      );
    }
  }
}

class Country {
  final String id;
  final String country;
  final int totalConfirmed;
  final int totalDeaths;
  Country({
    required this.id,
    required this.country,
    required this.totalConfirmed,
    required this.totalDeaths,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["ID"],
        country: json["Country"],
        totalConfirmed: json["TotalConfirmed"],
        totalDeaths: json["TotalDeaths"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Country": country,
        "TotalConfirmed": totalConfirmed,
        "TotalDeaths": totalDeaths,
      };
}
