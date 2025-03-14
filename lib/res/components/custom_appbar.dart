// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo-project/localization/language_constrants.dart';
import 'package:demo-project/model/booking_model/find_booking_model.dart';
import 'package:demo-project/res/components/custom_text.dart';
import 'package:demo-project/res/components/search_box.dart';
import 'package:demo-project/utils/constants.dart';
import 'package:demo-project/utils/imagesandsvg.dart';
import 'package:demo-project/utils/routes/routes_name.dart';
import 'package:demo-project/view_model/home/home_view_model.dart';
import 'package:demo-project/view_model/order/order_view_model.dart';
import '../../utils/color.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool? arrow;
  final bool? notification;
  final bool? filter;
  final bool? drawer;
  final bool? msg;
  final bool? basket;
  final bool? booking;
  final void Function()? onTap;
  final void Function()? onBasketTap;

  const CustomAppBar(
      {super.key,
      this.title,
      this.arrow,
      this.notification,
      this.filter,
      this.drawer,
      this.msg,
      this.basket,
      this.booking,
      this.onBasketTap,
      this.onTap});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    String selectedValue = Provider.of<OrderViewModel>(context).getSelectedMenu;
    return AppBar(
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
      backgroundColor: AppColors.whiteColor,
      actions: [
        (widget.arrow == true)
            ? Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: InkWell(
                  onTap: widget.onTap ??
                      () {
                        Navigator.pop(context);
                      },
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    size: 25,
                    color: AppColors.blackColor,
                  ),
                ),
              )
            // : (drawer == true)
            //     ? Padding(
            //         padding: const EdgeInsets.only(left: 20.0),
            //         child: SvgPicture.asset(
            //           Svgs.drawer,
            //           height: 18,
            //           width: 18,
            //         ),
            //       )
            : const SizedBox(),
        (widget.booking == true)
            ? Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RoutesName.findMyBookingScreenWithBackBtn);
                  },
                  child: SvgPicture.asset(
                    Svgs.findMyBooking,
                    height: 35,
                    width: 35,
                  ),
                ),
              )
            : const SizedBox(),
        const SizedBox(width: 20),
        widget.title == null
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: SearchBox(
                    readOnly: true,
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.textFieldHintColor,
                    ),
                    maxLines: 1,
                    hintText: getTranslated('search', context),
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.searchScreen);
                    },
                  ),
                ),
              )
            : Center(
                child: PoppinsText(
                  data: '${widget.title}',
                  fSize: 18,
                  fontColor: AppColors.blackColor,
                  fweight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        widget.title != null ? const Spacer() : const SizedBox(),
        const SizedBox(width: 10),
        widget.filter == false
            ? const SizedBox(width: 0)
            :
            // : InkWell(
            //     onTap: () {
            PopupMenuButton<String>(
                offset: const Offset(50, 50),
                color: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Circular border radius
                ),
                icon: SvgPicture.asset(
                  Svgs.filter,
                  height: 25,
                  width: 25,
                ),
                elevation: 2,
                shadowColor: AppColors.mainColor,
                onSelected: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                  Provider.of<OrderViewModel>(context, listen: false)
                      .addMenuValue(selectedValue, context);
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: Constants.all,
                    textStyle: (selectedValue == Constants.all)
                        ? TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          )
                        : TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    child: Text(getTranslated('all', context)!),
                  ),
                  const PopupMenuDivider(
                    height: 0,
                  ),
                  PopupMenuItem(
                    value: Constants.created,
                    textStyle: (selectedValue == Constants.created)
                        ? TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          )
                        : TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    child: Text(getTranslated('created_service', context)!),
                  ),
                  const PopupMenuDivider(
                    height: 0,
                  ),
                  PopupMenuItem(
                    value: Constants.accepted,
                    textStyle: (selectedValue == Constants.accepted)
                        ? TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          )
                        : TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    child: Text(getTranslated('accepted_service', context)!),
                  ),
                  const PopupMenuDivider(
                    height: 0,
                  ),
                  PopupMenuItem(
                    value: Constants.claimed,
                    textStyle: (selectedValue == Constants.claimed)
                        ? TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          )
                        : TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    child: Text(getTranslated('claimed_services', context)!),
                  ),
                  const PopupMenuDivider(
                    height: 0,
                  ),
                  PopupMenuItem(
                    value: Constants.completed,
                    textStyle: (selectedValue == Constants.completed)
                        ? TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          )
                        : TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    child: Text(getTranslated('delivered_services', context)!),
                  ),
                  // const PopupMenuDivider(
                  //   height: 1,
                  // ),
                  // PopupMenuItem(
                  //   value: 'cancelled',
                  //   textStyle: (selectedValue == "cancelled")
                  //       ? TextStyles.inter(
                  //           color: AppColors.blackColor,
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.w700,
                  //         )
                  //       : TextStyles.inter(
                  //           color: AppColors.blackColor,
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //   child: Text(
                  //     getTranslated('cancelled_services', context)!,
                  //   ),
                  // ),
                  const PopupMenuDivider(
                    height: 1,
                  ),
                  PopupMenuItem(
                    value: Constants.rejected,
                    textStyle: (selectedValue == Constants.rejected)
                        ? TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          )
                        : TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    child: Text(
                      getTranslated('rejected_services', context)!,
                    ),
                  ),
                  const PopupMenuDivider(
                    height: 1,
                  ),
                  PopupMenuItem(
                    value: Constants.refunded,
                    textStyle: (selectedValue == Constants.refunded)
                        ? TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          )
                        : TextStyles.inter(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    child: Text(
                      getTranslated('refunded_service', context)!,
                    ),
                  ),
                ],
                child: null,
              ),
        //   },
        //   child: SvgPicture.asset(
        //     Svgs.filter,
        //     height: 25,
        //     width: 25,
        //   ),
        // ),
        const SizedBox(width: 10),
        widget.notification == false
            ? const SizedBox(width: 0)
            : InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.notificationScreen);
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        Svgs.notification,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    if (Provider.of<HomeViewModel>(context)
                            .getNotifyCount
                            .toString() !=
                        '0')
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: PoppinsText(
                              data: Provider.of<HomeViewModel>(context)
                                  .getNotifyCount
                                  .toString(),
                              fSize: 10,
                              fontColor: AppColors.whiteColor,
                              fweight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
        const SizedBox(width: 15),
        // widget.msg == true
        //     ? InkWell(
        //         onTap: () {
        //           Navigator.pushNamed(context, RoutesName.chatScreen);
        //         },
        //         child: SvgPicture.asset(
        //           Svgs.chat,
        //           height: 25,
        //           width: 25,
        //         ),
        //       )
        //     : const SizedBox(),
        // const SizedBox(
        //   width: 20,
        // ),
        (widget.basket == true)
            ? InkWell(
                onTap: widget.onBasketTap ??
                    () async {
                      FindBookingModel? bookingDetail;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? jsonString =
                          prefs.getString(Constants.bookingData);
                      if (jsonString != null) {
                        //setState(() {
                        bookingDetail =
                            FindBookingModel.fromJson(jsonDecode(jsonString));
                        //});
                      }
                      Navigator.pushNamed(context, RoutesName.bookServiceScreen,
                          arguments: {
                            "id": bookingDetail!.data!.booking!.id.toString()
                          });
                    },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        Svgs.basket,
                        color: AppColors.blackColor,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    if (Provider.of<HomeViewModel>(context)
                            .getCount
                            .toString() !=
                        '0')
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: PoppinsText(
                              data: Provider.of<HomeViewModel>(context)
                                  .getCount
                                  .toString(),
                              fSize: 10,
                              fontColor: AppColors.whiteColor,
                              fweight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              )
            : const SizedBox(),
        if (widget.basket == true)
          const SizedBox(
            width: 20,
          ),
      ],
    );
  }

  Size get preferredSize => const Size(double.maxFinite, 50);
}
