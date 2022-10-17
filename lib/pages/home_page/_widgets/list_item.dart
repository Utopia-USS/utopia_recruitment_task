import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/helpers/datetime_helper.dart';
import 'package:utopia_recruitment_task/models/item_model.dart';

class ListItem extends StatelessWidget {
  final int index;
  final Item item;
  final Function onTap;

  const ListItem({
    super.key,
    required this.index,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CustomTheme.white,
        borderRadius: CustomTheme.mainRadius,
        boxShadow: [CustomTheme.shadow],
      ),
      child: Material(
        color: CustomTheme.white,
        borderRadius: CustomTheme.mainRadius,
        child: InkWell(
          borderRadius: CustomTheme.mainRadius,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(
                  0,
                  CustomTheme.spacing,
                  CustomTheme.spacing,
                  CustomTheme.spacing,
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        color: CustomTheme.semiBlue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6.0),
                          bottomRight: Radius.circular(6.0),
                        ),
                      ),
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: CustomTheme.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: CustomTheme.spacing / 3),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateTimeHelper.fullDate(item.created),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: CustomTheme.grey,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            item.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: CustomTheme.darkGray,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (item.url != null)
                      ClipOval(
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          color: CustomTheme.semiBlue,
                          child: const Icon(
                            Icons.link_rounded,
                            color: CustomTheme.white,
                            size: 18.0,
                          ),
                        ),
                      ),
                    const SizedBox(width: CustomTheme.spacing),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: CustomTheme.grey,
                      size: 12.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () => onTap(),
        ),
      ),
    );
  }
}
