import 'package:dormitory_management/models/rating.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DormMGReviewAndRatings extends ConsumerStatefulWidget {
  const DormMGReviewAndRatings({Key? key}) : super(key: key);

  @override
  ConsumerState<DormMGReviewAndRatings> createState() => _DormMGReviewAndRatingsState();
}

class _DormMGReviewAndRatingsState extends ConsumerState<DormMGReviewAndRatings> {
  List<Rating> ratings = [
    Rating(id: 1, dormitoryId: 1, userId: 1, ratingNo: 5, review: "Great place!"),
    Rating(id: 2, dormitoryId: 2, userId: 2, ratingNo: 4, review: "Nice environment."),
    Rating(id: 3, dormitoryId: 3, userId: 3, ratingNo: 3, review: "Could be better."),
    Rating(id: 4, dormitoryId: 4, userId: 4, ratingNo: 2, review: "Not satisfied."),
    Rating(id: 5, dormitoryId: 5, userId: 5, ratingNo: 1, review: "Awful experience."),
  ];

  Widget _buildRatingChip(int ratingNo) {
    Color color;
    String label;

    switch (ratingNo) {
      case 5:
        color = Colors.green;
        label = '5';
        break;
      case 4:
        color = Colors.lightGreen;
        label = '4';
        break;
      case 3:
        color = Colors.yellow;
        label = '3';
        break;
      case 2:
        color = Colors.orange;
        label = '2';
        break;
      case 1:
      default:
        color = Colors.red;
        label = '1';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionPopupMenu() {
    return PopupMenuButton<int>(
      onSelected: (item) {
        switch (item) {
          case 0:
            break;
          case 1:
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<int>(value: 0, child: Text('Action 1')),
        PopupMenuItem<int>(value: 1, child: Text('Action 2')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              constraints: BoxConstraints(maxWidth: 1000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reviews & Ratings',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        DataTable(
                          columnSpacing: 12.0,
                          columns: [
                            DataColumn(label: Text('User')),
                            DataColumn(label: Text('Dormitory')),
                            DataColumn(label: Text('Rating')),
                            DataColumn(label: Text('Review')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: ratings.map((rating) {
                            return DataRow(cells: [
                              DataCell(Text('User ${rating.userId}')),
                              DataCell(Text('Dormitory ${rating.dormitoryId}')),
                              DataCell(_buildRatingChip(rating.ratingNo ?? 0)),
                              DataCell(Text(rating.review ?? "")),
                              DataCell(_buildActionPopupMenu()),
                            ]);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
