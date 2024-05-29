import 'package:dormitory_management/models/rating.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DormMGReviewAndRatings extends ConsumerStatefulWidget {
  const DormMGReviewAndRatings({Key? key}) : super(key: key);

  @override
  ConsumerState<DormMGReviewAndRatings> createState() => _DormMGReviewAndRatingsState();
}

class _DormMGReviewAndRatingsState extends ConsumerState<DormMGReviewAndRatings> {
  List<Rating> ratings = [];
  bool isLoading = false;

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

  Widget _buildActionPopupMenu(int id) {
    return PopupMenuButton<int>(
      onSelected: (item) {
        switch (item) {
          case 0:
            deleteReview(id);
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Text('Delete'),
        ),
      ],
    );
  }

  Future<void> deleteReview(int id) async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    await dormManager.deleteRating(ratingId: id);
    setState(() {
      ratings.removeWhere((element) => element.ratingId == id);
    });
  }

  Future<void> getRatings() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider) as DormitoryOwner;
    setState(() {
      isLoading = true;
    });
    ratings = await dormManager.getRatingByDormitoryId(dormitoryId: user.dormitoryId!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getRatings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userManagerProvider) as DormitoryOwner;

    return Scaffold(
      appBar: getCustomAppBar(context),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Row(
            children: [
              CustomDrawer(activePage: ActivePages.dormMGreviewsAndRatings,),
              const SizedBox(width: 16,),
              Expanded(
                child: Padding(
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
                              'Ratings',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: ListView(
                                children: [
                                  DataTable(
                                    columnSpacing: 12.0,
                                    columns: const [
                                      DataColumn(label: Text('Student Name')),
                                      DataColumn(label: Text('Dormitory')),
                                      DataColumn(label: Text('Rating')),
                                      DataColumn(label: Text('Action')),
                                    ],
                                    rows: ratings.map((rating) {
                                      return DataRow(cells: [
                                        DataCell(Text('${rating.user!.name} ${rating.user!.surName}')),
                                        DataCell(Text('${user.name}')),
                                        DataCell(_buildRatingChip(rating.ratingNo ?? 0)),
                                        DataCell(_buildActionPopupMenu(rating.ratingId!)),
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
              ),
            ],
          ),
    );
  }
}










/*

import 'package:dormitory_management/models/rating.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DormMGReviewAndRatings extends ConsumerStatefulWidget {
  const DormMGReviewAndRatings({Key? key}) : super(key: key);

  @override
  ConsumerState<DormMGReviewAndRatings> createState() => _DormMGReviewAndRatingsState();
}

class _DormMGReviewAndRatingsState extends ConsumerState<DormMGReviewAndRatings> {
  List<Rating> ratings = [];

  bool isLoading = false;

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

  Widget _buildActionPopupMenu(int id) {
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
        PopupMenuItem<int>(
            value: 0,
            child: Text('Delete'),
          onTap: (){
              deleteReview(id);
          },
        ),
      ],
    );
  }

  Future<void> deleteReview(int id) async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    await dormManager.deleteRating(ratingId: id);
    setState(() {
      ratings.removeWhere((element) => element.ratingId == id);
    });
  }

  Future<void> getRatings() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider) as DormitoryOwner;
    setState(() {
      isLoading = true;
    });
    ratings = await dormManager.getRatingByDormitoryId(dormitoryId: user.dormitoryId!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getRatings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userManagerProvider) as DormitoryOwner;

    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: isLoading ? const Center(child: CircularProgressIndicator(),) : Padding(
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
                  const Text(
                    'Ratings',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        DataTable(
                          columnSpacing: 12.0,
                          columns: const [
                            DataColumn(label: Text('Student Name')),
                            DataColumn(label: Text('Dormitory')),
                            DataColumn(label: Text('Rating')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: ratings.map((rating) {
                            return DataRow(cells: [
                              DataCell(Text('${rating.user!.name} ${rating.user!.surName}')),
                              DataCell(Text('${user.name}')),
                              DataCell(_buildRatingChip(rating.ratingNo ?? 0)),
                              DataCell(_buildActionPopupMenu(rating.ratingId!)),
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

*/