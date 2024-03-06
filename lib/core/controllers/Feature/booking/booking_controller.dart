import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/country_model.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_country_screen.dart';
import 'package:saralnova/features/screens/Feature/rooms/room_type_bottom_sheet.dart';

enum BookingState { DATEROOMS, OPTIONS, INFORMATION, CONFIRM }

class BookingController extends GetxController {
  List<CountryModel> countries = [
    {'key': 'AF', 'country': 'Afghanistan'},
    {'key': 'AX', 'country': 'Åland Islands'},
    {'key': 'AL', 'country': 'Albania'},
    {'key': 'DZ', 'country': 'Algeria'},
    //TODO: add more countires text file is saved in desktop folder
  ].map((json) {
    print(json);
    return CountryModel(
      key: json['key'],
      countryName: json['country'],
    );
  }).toList();
  var bookingState = BookingState.DATEROOMS.obs;
  PageController pageController = PageController();

  final roomTypeController = TextEditingController();
  final countryController = TextEditingController();
  RxInt guestNumber = RxInt(0);

  onIncrement() {
    if (guestNumber.value >= 0) {
      print("hahaha");

      guestNumber.value += 1;
    }
  }

  onDecrement() {
    if (guestNumber.value > 0) {
      guestNumber.value -= 1;
    }
  }

  // var activeIndex = 0.obs; // Track active index

  setActiveIndex(int index) {
    print("-current Index--------------->${index}");
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

                //     this.roomType.value = roomType;
                // if (crudState.value == CRUDSTATE.UPDATE) {
                //   updateIndex.value = roomType.id;
                // }
              },
            ),
          );
        });
  }

  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;
  changeIndex(int value) {
    pageController.jumpToPage(value);
    _currentIndex.value = value;
  }

  onNext() {
    if (currentIndex >= 0 && currentIndex < 3) {
      _currentIndex.value += 1;
      setActiveIndex(currentIndex);
      changeIndex(currentIndex);
    }
  }

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

  Rxn<CountryModel> country = Rxn();

  void onsubmit() async {
    print(country.value?.key);
    print(country.value?.countryName);
  }
// //TODO make different countrylist file , add modal and make a new list do a loop add all values in that list
//   List<Map<String, String>> countryData = [
//     {'AF': 'Afghanistan'},
//     {'AX': 'Åland Islands'},
//     {'AL': 'Albania'},
//     {'DZ': 'Algeria'},
//     {'AS': 'American Samoa'},
//     {'AD': 'Andorra'},
//     {'AO': 'Angola'},
//     {'AI': 'Anguilla'},
//     {'AQ': 'Antarctica'},
//     {'AG': 'Antigua and Barbuda'},
//     {'AR': 'Argentina'},
//     {'AM': 'Armenia'},
//     {'AW': 'Aruba'},
//     {'AU': 'Australia'},
//     {'AT': 'Austria'},
//     {'AZ': 'Azerbaijan'},
//     {'BS': 'Bahamas'},
//     {'BH': 'Bahrain'},
//     {'BD': 'Bangladesh'},
//     {'BB': 'Barbados'},
//     {'BY': 'Belarus'},
//     {'BE': 'Belgium'},
//     {'BZ': 'Belize'},
//     {'BJ': 'Benin'},
//     {'BM': 'Bermuda'},
//     {'BT': 'Bhutan'},
//     {'BO': 'Bolivia'},
//     {'BA': 'Bosnia and Herzegovina'},
//     {'BW': 'Botswana'},
//     {'BV': 'Bouvet Island'},
//     {'BR': 'Brazil'},
//     {'IO': 'British Indian Ocean Territory'},
//     {'BN': 'Brunei Darussalam'},
//     {'BG': 'Bulgaria'},
//     {'BF': 'Burkina Faso'},
//     {'BI': 'Burundi'},
//     {'KH': 'Cambodia'},
//     {'CM': 'Cameroon'},
//     {'CA': 'Canada'},
//     {'CV': 'Cape Verde'},
//     {'KY': 'Cayman Islands'},
//     {'CF': 'Central African Republic'},
//     {'TD': 'Chad'},
//     {'CL': 'Chile'},
//     {'CN': 'China'},
//     {'CX': 'Christmas Island'},
//     {'CC': 'Cocos (Keeling) Islands'},
//     {'CO': 'Colombia'},
//     {'KM': 'Comoros'},
//     {'CG': 'Congo'},
//     {'CD': 'Congo, Democratic Republic of the'},
//     {'CK': 'Cook Islands'},
//     {'CR': 'Costa Rica'},
//     {'CI': 'Côte d Ivoire'},
//     {'HR': 'Croatia'},
//     {'CU': 'Cuba'},
//     {'CY': 'Cyprus'},
//     {'CZ': 'Czech Republic'},
//     {'DK': 'Denmark'},
//     {'DJ': 'Djibouti'},
//     {'DM': 'Dominica'},
//     {'DO': 'Dominican Republic'},
//     {'EC': 'Ecuador'},
//     {'EG': 'Egypt'},
//     {'SV': 'El Salvador'},
//     {'GQ': 'Equatorial Guinea'},
//     {'ER': 'Eritrea'},
//     {'EE': 'Estonia'},
//     {'ET': 'Ethiopia'},
//     {'FK': 'Falkland Islands (Malvinas)'},
//     {'FO': 'Faroe Islands'},
//     {'FJ': 'Fiji'},
//     {'FI': 'Finland'},
//     {'FR': 'France'},
//     {'GF': 'French Guiana'},
//     {'PF': 'French Polynesia'},
//     {'TF': 'French Southern Territories'},
//     {'GA': 'Gabon'},
//     {'GM': 'Gambia'},
//     {'GE': 'Georgia'},
//     {'DE': 'Germany'},
//     {'GH': 'Ghana'},
//     {'GI': 'Gibraltar'},
//     {'GR': 'Greece'},
//     {'GL': 'Greenland'},
//     {'GD': 'Grenada'},
//     {'GP': 'Guadeloupe'},
//     {'GU': 'Guam'},
//     {'GT': 'Guatemala'},
//     {'GG': 'Guernsey'},
//     {'GN': 'Guinea'},
//     {'GW': 'Guinea-Bissau'},
//     {'GY': 'Guyana'},
//     {'HT': 'Haiti'},
//     {'HM': 'Heard Island and McDonald Islands'},
//     {'VA': 'Holy See (Vatican City State)'},
//     {'HN': 'Honduras'},
//     {'HK': 'Hong Kong'},
//     {'HU': 'Hungary'},
//     {'IS': 'Iceland'},
//     {'IN': 'India'},
//     {'ID': 'Indonesia'},
//     {'IR': 'Iran, Islamic Republic of'},
//     {'IQ': 'Iraq'},
//     {'IE': 'Ireland'},
//     {'IM': 'Isle of Man'},
//     {'IL': 'Israel'},
//     {'IT': 'Italy'},
//     {'JM': 'Jamaica'},
//     {'JP': 'Japan'},
//     {'JE': 'Jersey'},
//     {'JO': 'Jordan'},
//     {'KZ': 'Kazakhstan'},
//     {'KE': 'Kenya'},
//     {'KI': 'Kiribati'},
//     {'KP': "Korea, Democratic People's Republic of"},
//     {'KR': 'Korea, Republic of'},
//     {'KW': 'Kuwait'},
//     {'KG': 'Kyrgyzstan'},
//     {'LA': "Lao People's Democratic Republic"},
//     {'LV': 'Latvia'},
//     {'LB': 'Lebanon'},
//     {'LS': 'Lesotho'},
//     {'LR': 'Liberia'},
//     {'LY': 'Libyan Arab Jamahiriya'},
//     {'LI': 'Liechtenstein'},
//     {'LT': 'Lithuania'},
//     {'LU': 'Luxembourg'},
//     {'MO': 'Macao'},
//     {'MK': 'Macedonia, the Former Yugoslav Republic of'},
//     {'MG': 'Madagascar'},
//     {'MW': 'Malawi'},
//     {'MY': 'Malaysia'},
//     {'MV': 'Maldives'},
//     {'ML': 'Mali'},
//     {'MT': 'Malta'},
//     {'MH': 'Marshall Islands'},
//     {'MQ': 'Martinique'},
//     {'MR': 'Mauritania'},
//     {'MU': 'Mauritius'},
//     {'YT': 'Mayotte'},
//     {'MX': 'Mexico'},
//     {'FM': 'Micronesia, Federated States of'},
//     {'MD': 'Moldova, Republic of'},
//     {'MC': 'Monaco'},
//     {'MN': 'Mongolia'},
//     {'ME': 'Montenegro'},
//     {'MS': 'Montserrat'},
//     {'MA': 'Morocco'},
//     {'MZ': 'Mozambique'},
//     {'MM': 'Myanmar'},
//     {'NA': 'Namibia'},
//     {'NR': 'Nauru'},
//     {'NP': 'Nepal'},
//     {'NL': 'Netherlands'},
//     {'AN': 'Netherlands Antilles'},
//     {'NC': 'New Caledonia'},
//     {'NZ': 'New Zealand'},
//     {'NI': 'Nicaragua'},
//     {'NE': 'Niger'},
//     {'NG': 'Nigeria'},
//     {'NU': 'Niue'},
//     {'NF': 'Norfolk Island'},
//     {'MP': 'Northern Mariana Islands'},
//     {'NO': 'Norway'},
//     {'OM': 'Oman'},
//     {'PK': 'Pakistan'},
//     {'PW': 'Palau'},
//     {'PS': 'Palestinian Territory, Occupied'},
//     {'PA': 'Panama'},
//     {'PG': 'Papua New Guinea'},
//     {'PY': 'Paraguay'},
//     {'PE': 'Peru'},
//     {'PH': 'Philippines'},
//     {'PN': 'Pitcairn'},
//     {'PL': 'Poland'},
//     {'PT': 'Portugal'},
//     {'PR': 'Puerto Rico'},
//     {'QA': 'Qatar'},
//     {'RE': 'Réunion'},
//     {'RO': 'Romania'},
//     {'RU': 'Russian Federation'},
//     {'RW': 'Rwanda'},
//     {'BL': 'Saint Barthélemy'},
//     {'SH': 'Saint Helena'},
//     {'KN': 'Saint Kitts and Nevis'},
//     {'LC': 'Saint Lucia'},
//     {'MF': 'Saint Martin (French part)'},
//     {'PM': 'Saint Pierre and Miquelon'},
//     {'VC': 'Saint Vincent and the Grenadines'},
//     {'WS': 'Samoa'},
//     {'SM': 'San Marino'},
//     {'ST': 'Sao Tome and Principe'},
//     {'SA': 'Saudi Arabia'},
//     {'SN': 'Senegal'},
//     {'RS': 'Serbia'},
//     {'SC': 'Seychelles'},
//     {'SL': 'Sierra Leone'},
//     {'SG': 'Singapore'},
//     {'SK': 'Slovakia'},
//     {'SI': 'Slovenia'},
//     {'SB': 'Solomon Islands'},
//     {'SO': 'Somalia'},
//     {'ZA': 'South Africa'},
//     {'GS': 'South Georgia and the South Sandwich Islands'},
//     {'ES': 'Spain'},
//     {'LK': 'Sri Lanka'},
//     {'SD': 'Sudan'},
//     {'SR': 'Suriname'},
//     {'SJ': 'Svalbard and Jan Mayen'},
//     {'SZ': 'Swaziland'},
//     {'SE': 'Sweden'},
//     {'CH': 'Switzerland'},
//     {'SY': 'Syrian Arab Republic'},
//     {'TW': 'Taiwan, Province of China'},
//     {'TJ': 'Tajikistan'},
//     {'TZ': 'Tanzania, United Republic of'},
//     {'TH': 'Thailand'},
//     {'TL': 'Timor-Leste'},
//     {'TG': 'Togo'},
//     {'TK': 'Tokelau'},
//     {'TO': 'Tonga'},
//     {'TT': 'Trinidad and Tobago'},
//     {'TN': 'Tunisia'},
//     {'TR': 'Turkey'},
//     {'TM': 'Turkmenistan'},
//     {'TC': 'Turks and Caicos Islands'},
//     {'TV': 'Tuvalu'},
//     {'UG': 'Uganda'},
//     {'UA': 'Ukraine'},
//     {'AE': 'United Arab Emirates'},
//     {'GB': 'United Kingdom'},
//     {'US': 'United States'},
//     {'UM': 'United States Minor Outlying Islands'},
//     {'UY': 'Uruguay'},
//     {'UZ': 'Uzbekistan'},
//     {'VU': 'Vanuatu'},
//     {'VE': 'Venezuela, Bolivarian Republic of'},
//     {'VN': 'Viet Nam'},
//     {'VG': 'Virgin Islands, British'},
//     {'VI': 'Virgin Islands, U.S.'},
//     {'WF': 'Wallis and Futuna'},
//     {'EH': 'Western Sahara'},
//     {'YE': 'Yemen'},
//     {'ZM': 'Zambia'},
//     {'ZW': 'Zimbabwe'}
//   ];
}
