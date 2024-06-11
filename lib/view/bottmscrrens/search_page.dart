// // ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

// import 'dart:developer';

// import 'package:bedmyway/controller/fetchbloc/bloc/hoteldata_bloc.dart';
// import 'package:bedmyway/repositories/custom/page_transition.dart';
// import 'package:bedmyway/view/bottmscrrens/hotel_details.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bedmyway/repositories/colors/colors.dart';

// class Searchpage extends StatefulWidget {
//   const Searchpage({Key? key}) : super(key: key);

//   @override
//   _SearchpageState createState() => _SearchpageState();
// }

// class _SearchpageState extends State<Searchpage> {
//   final TextEditingController _searchController = TextEditingController();

//   final List<String> _priceRanges = [
//     'Under 500',
//     '500 - 1000',
//     '1000 - 2000',
//     '2000 - 4000',
//     '4000 - 10000',
//     'Above 10000',
//     'Above 50000'
//   ];

//   String _selectedPriceRange = '';

//   final List<String> _roomTypes = [
//     'Double Room',
//     'Single Room',
//     'Deluxe Room',
//     'Studio Room',
//   ];

//   String _selectedRoomType = '';
//   final List<String> _additionalFilters = [
//     'A/C',
//     'Non A/C',
//     'Free Food',
//     'Paid Food',
//     'WIFI',
//     'Refund'
//   ];

//   String _selectedfood = '';
//   List<Map<String, dynamic>> _filteredHotels = [];

//   @override
//   void initState() {
//     super.initState();
//     _applyFilters();
//   }

//   void _applyFilters() {
//     final state = context.read<HoteldataBloc>().state;
//     if (state is HotelDatafetched) {
//       _filteredHotels = List<Map<String, dynamic>>.from(state.hotels);

//       if (_searchController.text.isNotEmpty) {
//         _filteredHotels.retainWhere((hotel) {
//           final name = (hotel['name'] ?? '').toLowerCase();
//           final location = (hotel['locaton'] ?? '').toLowerCase();
//           final searchQuery = _searchController.text.toLowerCase();
//           return name.contains(searchQuery) || location.contains(searchQuery);
//         });
//       }

//       if (_selectedPriceRange.isNotEmpty) {
//         _filteredHotels.retainWhere((hotel) {
//           final hotelPrice = int.tryParse(hotel['price'].replaceAll(',', ''));
//           if (hotelPrice != null) {
//             if (_selectedPriceRange == 'Under 500') {
//               return hotelPrice < 500;
//             } else if (_selectedPriceRange == '500 - 1000') {
//               return hotelPrice >= 500 && hotelPrice <= 1000;
//             } else if (_selectedPriceRange == '1000 - 2000') {
//               return hotelPrice >= 1000 && hotelPrice <= 2000;
//             } else if (_selectedPriceRange == '2000 - 4000') {
//               return hotelPrice >= 2000 && hotelPrice <= 4000;
//             } else if (_selectedPriceRange == '4000 - 10000') {
//               return hotelPrice > 4000 && hotelPrice <= 10000;
//             } else if (_selectedPriceRange == 'Above 10000') {
//               return hotelPrice > 10000 && hotelPrice <= 50000;
//             } else if (_selectedPriceRange == 'Above 50000') {
//               return hotelPrice > 50000;
//             }
//           }
//           return false;
//         });
//       }

//       if (_selectedRoomType.isNotEmpty) {
//         _filteredHotels.retainWhere((hotel) {
//           final roomType = (hotel['Room'] ?? '').toLowerCase();
//           return roomType.contains(_selectedRoomType.toLowerCase());
//         });
//       }
//       if (_selectedfood.isNotEmpty) {
//         _filteredHotels.retainWhere((hotel) {
//           final foodOption = (hotel['foodoption'] ?? '').toLowerCase();
//           final acOption = (hotel['acoption'] ?? '').toLowerCase();
//           final wifioption = (hotel['wifi'] ?? '').toLowerCase();
//           final iswifiavilable = wifioption.startsWith('available');
//           final ACAvailable = acOption.startsWith('available');
//           final NonAC = acOption.contains('non a/c');
//           final isFreeFood = foodOption.contains('free food');

//           switch (_selectedfood) {
//             case 'A/C':
//               return ACAvailable;
//             case 'Non A/C':
//               return NonAC;
//             case 'Free Food':
//               return isFreeFood;
//             case 'Paid Food':
//               return foodOption.toLowerCase().startsWith('paid');
//             case 'WIFI':
//               return iswifiavilable;
//             default:
//               return false;
//           }
//         });
//       }

//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<HoteldataBloc, HoteldataState>(
//       listener: (context, state) {
//         if (state is HotelDataerror) {
//           log(state.error);
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Appcolor.red,
//           title: Text(
//             'Find Your Perfect Stay',
//             style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 color: Appcolor.white),
//           ),
//         ),
//         backgroundColor: Appcolor.white,
//         body: Padding(
//           padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 6, right: 6),
//                 child: CupertinoSearchTextField(
//                   controller: _searchController,
//                   placeholder: 'Search...',
//                   onChanged: (value) {
//                     _applyFilters();
//                   },
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               const Text(
//                 'Filter by Price',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//               const SizedBox(height: 5.0),
//               SizedBox(
//                 height: 50.0,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: _priceRanges.map((String priceRange) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       child: FilterChip(
//                         label: Text(priceRange),
//                         selected: _selectedPriceRange == priceRange,
//                         onSelected: (bool selected) {
//                           setState(() {
//                             _selectedPriceRange = selected ? priceRange : '';
//                             _applyFilters();
//                           });
//                         },
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//               const SizedBox(height: 8.0),
//               const Text(
//                 'Room Types',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//               SizedBox(
//                 height: 50.0,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: _roomTypes.map((String roomtype) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       child: FilterChip(
//                         label: Text(roomtype),
//                         selected: _selectedRoomType == roomtype,
//                         onSelected: (bool selected) {
//                           setState(() {
//                             _selectedRoomType = selected ? roomtype : '';
//                             _applyFilters();
//                           });
//                         },
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               const Text(
//                 'AC Options & Food Preferences',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//               SizedBox(
//                 height: 50.0,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: _additionalFilters.map((String food) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       child: FilterChip(
//                         label: Text(food),
//                         selected: _selectedfood == food,
//                         onSelected: (bool selected) {
//                           setState(() {
//                             _selectedfood = selected ? food : '';
//                             _applyFilters();
//                           });
//                         },
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Search Results',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               const SizedBox(height: 8.0),
//               Expanded(
//                 child: _filteredHotels.isEmpty
//                     ? Center(
//                         child: _searchController.text.isNotEmpty
//                             ? const Text('No results found')
//                             : Image.asset(
//                                 'assets/images/Screenshot 2024-06-10 125332.png',
//                                 width: 200,
//                               ),
//                       )
//                     : GridView.builder(
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 8.0,
//                           crossAxisSpacing: 8.0,
//                           childAspectRatio: 0.7,
//                         ),
//                         itemCount: _filteredHotels.length,
//                         itemBuilder: (context, index) {
//                           final hotel = _filteredHotels[index];
//                           final roomImages = hotel['images'] as List<dynamic>;
//                           final firstImageUrl = roomImages.isNotEmpty
//                               ? roomImages[2].toString()
//                               : '';
//                           return InkWell(
//                             onTap: () {
//                               Navigator.of(context).push(FadePageRoute(
//                                   page: HotelDetailPage(hotel: hotel)));
//                             },
//                             child: Card(
//                               elevation: 2.0,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(5),
//                                     child: SizedBox(
//                                       width: double.infinity,
//                                       height: 130.0,
//                                       child: Image.network(
//                                         firstImageUrl,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           hotel['name'] ?? '',
//                                           style: const TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 4.0),
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.location_on_outlined,
//                                               size: 17,
//                                               color: Appcolor.red2,
//                                             ),
//                                             Text(
//                                               hotel['locaton'] ?? '',
//                                               style: const TextStyle(
//                                                 fontSize: 13,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 3,
//                                         ),
//                                         Text(
//                                           '₹ ${hotel['price']},',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               color: Appcolor.red),
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:math';

import 'package:bedmyway/controller/fetchbloc/bloc/hoteldata_bloc.dart';
import 'package:bedmyway/repositories/custom/page_transition.dart';
import 'package:bedmyway/view/bottmscrrens/hotel_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:shimmer/shimmer.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({Key? key}) : super(key: key);

  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _priceRanges = [
    'Under 500',
    '500 - 1000',
    '1000 - 2000',
    '2000 - 4000',
    '4000 - 10000',
    'Above 10000',
    'Above 50000'
  ];

  String _selectedPriceRange = '';

  final List<String> _roomTypes = [
    'Double Room',
    'Single Room',
    'Deluxe Room',
    'Studio Room',
  ];

  String _selectedRoomType = '';
  final List<String> _additionalFilters = [
    'A/C',
    'Non A/C',
    'Free Food',
    'Paid Food',
    'WIFI',
    'Refund'
  ];

  String _selectedfood = '';
  List<Map<String, dynamic>> _filteredHotels = [];

  @override
  void initState() {
    super.initState();
    _applyFilters();
  }

  void _applyFilters() {
    final state = context.read<HoteldataBloc>().state;
    if (state is HotelDatafetched) {
      _filteredHotels = List<Map<String, dynamic>>.from(state.hotels);

      if (_searchController.text.isNotEmpty) {
        _filteredHotels.retainWhere((hotel) {
          final name = (hotel['name'] ?? '').toLowerCase();
          final location = (hotel['locaton'] ?? '').toLowerCase();
          final searchQuery = _searchController.text.toLowerCase();
          return name.contains(searchQuery) || location.contains(searchQuery);
        });
      }

      if (_selectedPriceRange.isNotEmpty) {
        _filteredHotels.retainWhere((hotel) {
          final hotelPrice = int.tryParse(hotel['price'].replaceAll(',', ''));
          if (hotelPrice != null) {
            if (_selectedPriceRange == 'Under 500') {
              return hotelPrice < 500;
            } else if (_selectedPriceRange == '500 - 1000') {
              return hotelPrice >= 500 && hotelPrice <= 1000;
            } else if (_selectedPriceRange == '1000 - 2000') {
              return hotelPrice >= 1000 && hotelPrice <= 2000;
            } else if (_selectedPriceRange == '2000 - 4000') {
              return hotelPrice >= 2000 && hotelPrice <= 4000;
            } else if (_selectedPriceRange == '4000 - 10000') {
              return hotelPrice > 4000 && hotelPrice <= 10000;
            } else if (_selectedPriceRange == 'Above 10000') {
              return hotelPrice > 10000 && hotelPrice <= 50000;
            } else if (_selectedPriceRange == 'Above 50000') {
              return hotelPrice > 50000;
            }
          }
          return false;
        });
      }

      if (_selectedRoomType.isNotEmpty) {
        _filteredHotels.retainWhere((hotel) {
          final roomType = (hotel['Room'] ?? '').toLowerCase();
          return roomType.contains(_selectedRoomType.toLowerCase());
        });
      }
      if (_selectedfood.isNotEmpty) {
        _filteredHotels.retainWhere((hotel) {
          final foodOption = (hotel['foodoption'] ?? '').toLowerCase();
          final acOption = (hotel['acoption'] ?? '').toLowerCase();
          final wifioption = (hotel['wifi'] ?? '').toLowerCase();
          final refund = (hotel['Refundoption'] ?? '').toLowerCase();
          final isrefund = refund.startsWith('yes');
          final iswifiavilable = wifioption.startsWith('available');
          final ACAvailable = acOption.startsWith('available');
          final NonAC = acOption.contains('non a/c');
          final isFreeFood = foodOption.contains('free food');

          switch (_selectedfood) {
            case 'A/C':
              return ACAvailable;
            case 'Non A/C':
              return NonAC;
            case 'Free Food':
              return isFreeFood;
            case 'Paid Food':
              return foodOption.toLowerCase().startsWith('paid');
            case 'WIFI':
              return iswifiavilable;
            case 'Refund':
              return isrefund;
            default:
              return false;
          }
        });
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HoteldataBloc, HoteldataState>(
      listener: (context, state) {
        if (state is HotelDataerror) {
          print(state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Appcolor.red,
          title: Text(
            'Find Your Perfect Stay',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Appcolor.white),
          ),
        ),
        backgroundColor: Appcolor.white,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CupertinoSearchTextField(
                      controller: _searchController,
                      placeholder: 'Search...',
                      onChanged: (value) {
                        _applyFilters();
                      },
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Filter by Price',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 5.0),
                    SizedBox(
                      height: 50.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _priceRanges.map((String priceRange) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilterChip(
                              label: Text(priceRange),
                              selected: _selectedPriceRange == priceRange,
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedPriceRange =
                                      selected ? priceRange : '';
                                  _applyFilters();
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Room Types',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _roomTypes.map((String roomtype) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilterChip(
                              label: Text(roomtype),
                              selected: _selectedRoomType == roomtype,
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedRoomType = selected ? roomtype : '';
                                  _applyFilters();
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'AC Options & Food Preferences',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _additionalFilters.map((String food) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilterChip(
                              label: Text(food),
                              selected: _selectedfood == food,
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedfood = selected ? food : '';
                                  _applyFilters();
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Search Results',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    _filteredHotels.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: _searchController.text.isNotEmpty
                                    ? Center(
                                        child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/Screenshot 2024-06-11 144952.png',
                                            width: 200,
                                          ),
                                          const Text('No results found'),
                                        ],
                                      ))
                                    : Center(
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/Screenshot 2024-06-10 125332.png',
                                              width: 200,
                                            ),
                                            Text('No filtered items found')
                                          ],
                                        ),
                                      ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  mainAxisSpacing: 8.0, // Space between grid items vertically
                  crossAxisSpacing:
                      8.0, // Space between grid items horizontally
                  childAspectRatio: 0.75, // Aspect ratio of each grid item
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final hotel = _filteredHotels[index];
                    final roomImages = hotel['images'] as List<dynamic>;
                    final firstImageUrl =
                        roomImages.isNotEmpty ? roomImages[2].toString() : '';
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            FadePageRoute(page: HotelDetailPage(hotel: hotel)));
                      },
                      child: Card(
                        elevation: 2.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: double.infinity,
                                height: 120,
                                child: firstImageUrl.isNotEmpty
                                    ? Image.network(
                                        firstImageUrl,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            // Image successfully loaded
                                            return child;
                                          } else {
                                            // Display shimmer while loading
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                color: Appcolor.white,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 200,
                                              ),
                                            );
                                          }
                                        },
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          // Display shimmer if there's an error loading the image
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              color: Appcolor.white,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 200,
                                            ),
                                          );
                                        },
                                      )
                                    : Shimmer.fromColors(
                                        baseColor: Appcolor.shimer1,
                                        highlightColor: Appcolor.shimer1,
                                        child: Container(
                                          color: Appcolor.shimer1,
                                          width: double.infinity,
                                          height: 200,
                                        ),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hotel['name'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 17,
                                        color: Appcolor.red2,
                                      ),
                                      Text(
                                        hotel['locaton'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    '₹ ${hotel['price']},',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Appcolor.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: _filteredHotels.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
