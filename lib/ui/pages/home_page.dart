import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUpperBlock(),
            _buildBlockInfo(),
            _buildLowerBlock(),
          ],
        ),
      ),
    );
  }

  Widget _buildUpperBlock() {
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * 0.6;

    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                height: imageHeight,
                child: _buildImageSection(),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _buildHeader()),
                SizedBox(height: 16),
                Center(child: _buildWelcomeText()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Image.asset(
      'assets/images/home_img2.png',
      fit: BoxFit.contain,
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "Welcome to\nDormitory Management System",
        style: TextStyle(
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBlockInfo() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "Dormitories",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Center(
                  child: Text(
                    "10",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "Users",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Center(
                  child: Text(
                    "302",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLowerBlock() {
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * 0.6;

    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Find Your Dormitory",
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                height: imageHeight,
                child: _buildLowerImageSection(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLowerImageSection() {
    return Image.asset(
      'assets/images/home_img1.png',
      fit: BoxFit.contain,
    );
  }
}