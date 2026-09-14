import 'package:flutter/material.dart';


import '../../utils/app_styles.dart';
import '../../utils/size_utils.dart';

class MainErrorWidget extends StatelessWidget {
  const MainErrorWidget({
    super.key,
    required this.errorMesaage,
    required this.onPressed,
  });

  final String errorMesaage;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: context.scaleHeight(20),
        children: [
          Text(errorMesaage, style: Theme.of(context).textTheme.titleMedium),
          ElevatedButton(
            onPressed: onPressed,
            child: Text('Try Again', style: AppStyles.bold20Black),
          ),
        ],
      ),
    );
  }
}