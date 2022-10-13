import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';

class ProductItem extends StatelessWidget {
  final Function onTap;

  const ProductItem({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomTheme.white,
      borderRadius: CustomTheme.mainRadius,
      child: InkWell(
        borderRadius: CustomTheme.mainRadius,
        child: Container(
          padding: CustomTheme.contentPadding,
          decoration: BoxDecoration(
            color: CustomTheme.white,
            borderRadius: CustomTheme.mainRadius,
            boxShadow: [CustomTheme.shadow],
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '11.10.22',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: CustomTheme.grey,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'To do something',
                    style: TextStyle(
                      color: CustomTheme.darkGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: CustomTheme.grey,
                size: 12.0,
              ),
            ],
          ),
        ),
        onTap: () => onTap(),
      ),
    );
  }
}
