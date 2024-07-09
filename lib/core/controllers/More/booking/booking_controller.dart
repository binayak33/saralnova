import 'dart:developer';

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saralnova/core/model/country_model.dart';
import 'package:saralnova/core/model/feature_model/booking_model/booking_model.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/More/Booking/booking_bottom_sheets.dart/booking_calandar_bottom_sheet.dart';
import 'package:saralnova/features/screens/More/Booking/booking_bottom_sheets.dart/booking_country_screen.dart';
import 'package:saralnova/features/screens/More/rooms/room_type_bottom_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../features/widgets/common_widgets/loading_dialog.dart';
import '../../../../features/widgets/common_widgets/sky_snack_bar.dart';
import '../../../model/feature_model/facility_model.dart';
import '../../../model/feature_model/request_model/store_booking_request_model.dart';
import '../../../model/feature_model/room_type_model.dart';
import '../../../model/rooms_model.dart';
import '../../../repo/more_repo/booking_repo.dart';
import '../../../utils/enums/enums.dart';

class BookingController extends GetxController {
  //controllers
  final ScrollController scrollController = ScrollController();

  //universal states and variables
  final dateRoomKey = GlobalKey<FormState>();
  final informationFormKey = GlobalKey<FormState>();
  var bookingState = BookingState.DATEROOMS.obs;
  var pageState = PageState.LOADING.obs;
  PageController pageController = PageController();
  RxList<Booking> bookingList = RxList();
  RxBool isLoadingMore = RxBool(false);
  RxnString nextPageUrl = RxnString();
  RxInt estimatedCost = RxInt(0);

  @override
  void onInit() {
    getAllBookings();
    initScrollListener();

    super.onInit();
  }

  initScrollListener() {
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        LogHelper.debug("Scroll end reached");
        if (nextPageUrl.value != null && !isLoadingMore.value) {
          getAllBookings(loadMore: true);
        }
      }
    });
  }

  void getAllBookings({bool loadMore = false}) async {
    if (!loadMore) {
      bookingList.clear();
    } else {
      isLoadingMore.value = true;
    }
    BookingRepo.getAllBookings(
      nextPageUrl: nextPageUrl.value,
      onSuccess: (bookings, nextPageUrl) {
        if (bookings.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          pageState.value = PageState.NORMAL;
          bookingList.addAll(bookings);
          this.nextPageUrl.value = nextPageUrl;
          isLoadingMore.value = false;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
        isLoadingMore.value = false;
      },
    );
  }

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


  final roomTypeController = TextEditingController();

  RxInt guestNumber = RxInt(1);
  Rx<Time> selectedTime = Time(hour: 12, minute: 0).obs;

    void onTimeChanged(Time newTime) {
    selectedTime.value = newTime;
  }

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

  onBack() {
    if (currentIndex > 0 && currentIndex <= 3) {
      _currentIndex.value -= 1;
      // setActiveIndex(activeIndex.value);
      changeIndex(currentIndex);
    }
  }

  void onNext() {
    switch (currentIndex) {
      case 0:
        if (dateRoomKey.currentState!.validate() && bookedRoomList.isNotEmpty) {
          _currentIndex.value++;
          changeIndex(currentIndex);
          currentIndexEnabled.value = true;
          // calculateDaysCount();
        } else {
          SkySnackBar.error(
              title: "Booking", message: "Please select the available rooms");
        }
        break;

      case 1:
        _currentIndex.value++;
        changeIndex(currentIndex);
        currentIndexEnabled.value = true;
        break;

      case 2:
        if (informationFormKey.currentState!.validate()) {
          _currentIndex.value++;
          changeIndex(currentIndex);
          currentIndexEnabled.value = true;
        }
        break;

      case 3: // confirm screen(table wala)
        // _currentIndex.value++;
        // changeIndex(currentIndex);
        // currentIndexEnabled.value = true;
        // storeBooking(storeBookingModel);
        storeBooking();

        break;
    }
  }

  void onsubmit() async {
    print("----bookedRooms----${bookedRoomList}");
  }

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

      //validation if the start date and end date are same
      if (startDate == endDate) {
        endDate = endDate.add(Duration(days: 1));
        return;
      }

      // Ensure end date is one day ahead
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
  RxList<Rooms> availableRoomList = RxList();
  RxList<Rooms> bookedRoomList =
      RxList(); //rooms that are selected from available sheets

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
            print("normal state----------------------------------------------");
            availableRoomList.addAll(availableRooms);
            pageState.value = PageState.NORMAL;
          } else {
            pageState.value = PageState.ERROR;
          }
        },
        onError: (message) {
          print("-------errrer--------------------_${message}");
          loading.hide();
          pageState.value == PageState.ERROR;

          SkySnackBar.error(title: "Available Rooms", message: message);
        },
      );
    }
  }

  //options screen index

  RxList<Facility> facilitiesList = RxList(); //TODO yesko id matra pathaune

  //Information screen Index :
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  Rxn<CountryModel> country = Rxn();
  final countryController = TextEditingController();

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

  int? daysCount;

  int calculateDaysCount() {
    DateTime startDate = DateTime.parse(startFromDate.value);
    DateTime endDate = DateTime.parse(endToDate.value);
    daysCount = endDate.difference(startDate).inDays;
    log("-----------Days count-------------${daysCount}");
    return daysCount ?? 0;
  }

  int calculateEstimatedCost() {
    calculateDaysCount();
    estimatedCost.value = 0; // Reset estimatedCost to 0

    for (Rooms room in bookedRoomList) {
      estimatedCost.value += (room.rate ?? 0) * (daysCount ?? 0);
    }

    for (Facility facility in facilitiesList) {
      estimatedCost.value +=
          ((facility.price ?? 0) * (guestNumber.value) * (daysCount ?? 0))
              .toInt();
      // (facility.price ?? 0) * (guestNumber.value) * (daysCount ?? 0);
    }

    return estimatedCost.value;
  }

  // void storeBooking(StoreBookingRequestModel? storeBookingModel) async {
  //   BookingRepo.createBooking(
  //       storeBookingmodel: storeBookingModel,
  //       onSuccess: (booking) {
  //         //TODO call get api while navigating
  //         Get.offNamed(BookingScreen.routeName);
  //       },
  //       onError: (message) {
  //         SkySnackBar.error(title: "Booking", message: message);
  //       });
  // }

  void storeBooking() async {
    List<int> facilityIds =
        facilitiesList.map((facility) => int.parse(facility.id!)).toList();

    List<int> roomIds =
        bookedRoomList.map((room) => int.parse(room.id!)).toList();

    // log("----ids----${facilityIds}");
    log("----roomIds----${roomIds}");

    loading.show();
    StoreBookingRequestModel requestModel = StoreBookingRequestModel(
      guestData: GuestData(
        name: nameController.text,
        contact: contactController.text,
        email: emailController.text,
        address: addressController.text,
        nationality: countryController.text,
        // citizenship: "6456211022",
        // passport: "5631145655",
        // purposeOfVisit: "Leisure",
      ),
      bookingData: BookingData(
        checkin: startFromDate.value.toString(),
        checkout: endToDate.value.toString(),
        totalAmount: int.parse(estimatedCost.value.toString()),
        // paidAmount: "012000",
        // discount: "020",
        // advanceAmount: 0,
        // subtotal: 12347128,
        // remainingAmount: 12335108,
        // paymentStatus: "Partial",
        // source: "none",
        guestCount: int.parse(guestNumber.value.toString()),
        // specialRequests: "Beautiful Beautiful",
        // isPackage: 0,
        // facilities: [9, 10],
        facilities: facilityIds,
      ),
      // rooms: [4, 5],
      rooms: roomIds,
    );
    BookingRepo.createBooking(
        storeBookingmodel: requestModel,
        onSuccess: (booking, message) {
          //TODO call get api while navigating
          // Get.offNamed(BookingScreen.routeName);
          loading.hide();
          _currentIndex.value++;
          changeIndex(currentIndex);
          getAllBookings();
          SkySnackBar.success(title: "Booking", message: message);
        },
        onError: (message) {
          loading.hide();

          SkySnackBar.error(title: "Booking", message: message);
        });
  }
}
