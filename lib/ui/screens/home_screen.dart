import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/ui/screens/home_tab/home_tab.dart';
import 'package:movies_app/ui/screens/profile_tab/profile_tab.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/ui/screens/search_tab/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    HomeTab(),
    const ProfileTab(),
  ];

  List<String> bottomNavBarTabs = [
    AppImages.homeIcon,
    AppImages.searchIcon,
    AppImages.exploreIcon,
    AppImages.profileIcon,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          tabs[selectedIndex],
          Container(
            decoration: BoxDecoration(
              color: AppColors.darkGrayColor,
              borderRadius: BorderRadius.circular(
                16,
              ),
            ),
            margin: EdgeInsets.symmetric(
              vertical: context.scaleHeight(40),
              horizontal: context.scaleWidth(15),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            height: context.scaleHeight(70),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    selectedIndex = index;
                    setState(() {});
                  },
                  child: SizedBox(
                    width: context.scaleWidth(95),
                    height: context.scaleHeight(
                      20,
                    ),
                    child: SvgPicture.asset(
                      bottomNavBarTabs[index],
                      colorFilter:
                          ColorFilter.mode(
                            selectedIndex == index
                                ? AppColors
                                      .yellowColor
                                : AppColors
                                      .whiteColor,
                            BlendMode.srcIn,
                          ),
                    ),
                  ),
                );
              },
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
