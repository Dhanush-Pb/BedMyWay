// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers

import 'package:bedmyway/controller/fetchbloc/bloc/hoteldata_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class filtretionclass {
  static List<Map<String, dynamic>> applyFilters({
    required String selectedPriceRange,
    required String selectedRoomType,
    required String selectedFood,
    required TextEditingController searchController,
    required BuildContext context,
  }) {
    List<Map<String, dynamic>> _filteredHotels = [];
    final state = context.read<HoteldataBloc>().state;

    if (state is HotelDatafetched) {
      _filteredHotels = List<Map<String, dynamic>>.from(state.hotels);

      //! Filter by search
      if (searchController.text.isNotEmpty) {
        _filteredHotels.retainWhere((hotel) {
          final name = (hotel['name'] ?? '').toLowerCase();
          final location = (hotel['locaton'] ?? '').toLowerCase();
          final searchQuery = searchController.text.toLowerCase();
          return name.contains(searchQuery) || location.contains(searchQuery);
        });
      }

      //! Filter by price
      if (selectedPriceRange.isNotEmpty) {
        _filteredHotels.retainWhere((hotel) {
          final hotelPrice = int.tryParse(hotel['price'].replaceAll(',', ''));
          if (hotelPrice != null) {
            switch (selectedPriceRange) {
              case 'Under 500':
                return hotelPrice < 500;
              case '500 - 1000':
                return hotelPrice >= 500 && hotelPrice <= 1000;
              case '1000 - 2000':
                return hotelPrice >= 1000 && hotelPrice <= 2000;
              case '2000 - 4000':
                return hotelPrice >= 2000 && hotelPrice <= 4000;
              case '4000 - 10000':
                return hotelPrice > 4000 && hotelPrice <= 10000;
              case 'Above 10000':
                return hotelPrice > 10000 && hotelPrice <= 50000;
              case 'Above 50000':
                return hotelPrice > 50000;
              default:
                return false;
            }
          }
          return false;
        });
      }

      //! Filter by room
      if (selectedRoomType.isNotEmpty) {
        _filteredHotels.retainWhere((hotel) {
          final roomType = (hotel['Room'] ?? '').toLowerCase();
          return roomType.contains(selectedRoomType.toLowerCase());
        });
      }

      //! Filter by  (A/C,food,refund,wifi)
      if (selectedFood.isNotEmpty) {
        _filteredHotels.retainWhere((hotel) {
          final foodOption = (hotel['foodoption'] ?? '').toLowerCase();
          final acOption = (hotel['acoption'] ?? '').toLowerCase();
          final wifiOption = (hotel['wifi'] ?? '').toLowerCase();
          final refundOption = (hotel['Refundoption'] ?? '').toLowerCase();

          switch (selectedFood) {
            case 'A/C':
              return acOption.contains('available');
            case 'Non A/C':
              return acOption.contains('non a/c');
            case 'Free Food':
              return foodOption.contains('free');
            case 'Paid Food':
              return foodOption.contains('paid');
            case 'WIFI':
              return wifiOption.contains('available');
            case 'Refund':
              return refundOption.contains('yes');
            default:
              return false;
          }
        });
      }
    }
    return _filteredHotels;
  }
}
