// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable, unused_field
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:demo-project/localization/language_constrants.dart';
import 'package:demo-project/res/components/custom_text.dart';
import 'package:demo-project/res/components/custom_dialog.dart';
import 'package:demo-project/utils/color.dart';
import 'package:demo-project/res/components/custom_timmer.dart';
import 'package:demo-project/utils/constants.dart';
import 'package:demo-project/utils/date_time_formatter.dart';
import 'package:demo-project/utils/imagesandsvg.dart';
import 'package:demo-project/utils/routes/routes_name.dart';
import 'package:demo-project/utils/utils.dart';
import 'package:demo-project/view_model/home/home_view_model.dart';

class CustomOrder extends StatefulWidget {
  CustomOrder(
      {super.key,
      required this.context,
      required this.isFeedbackAvailable,
      required this.isFavAvailable,
      required this.index,
      required this.onDateSelected,
      required this.onTimeSelected,
      required this.onQtySelected,
      required this.isDeleteAvailable,
      this.id,
      this.deleteFunc,
      this.deleteFuncAni,
      this.noteFunction,
      required this.isValueDynamic,
      required this.checkoutListDetails});

  BuildContext context;

  int index = 0;

  String? id = '';

  dynamic checkoutListDetails;

  final void Function(String startdate, String enddate) onDateSelected;

  void Function(BuildContext)? deleteFuncAni;

  void Function()? noteFunction;

  void Function()? deleteFunc;

  final void Function(String starttime, String endtime) onTimeSelected;

  final void Function(String qty) onQtySelected;

  bool isFeedbackAvailable = false;

  bool? isValueDynamic = false;

  bool isFavAvailable = false;

  bool isDeleteAvailable = false;

  @override
  State<CustomOrder> createState() => _CustomOrderState();
}

class _CustomOrderState extends State<CustomOrder> {
  String selectTime = '';

  String selectTime1 = '';

  List<DateTime?> dialogCalendarPickerValue = [];
  List<TimeOfDay> selectedTimes = [];
  String? selectedValue;

  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
    if (widget.checkoutListDetails!.data![widget.index].qty != null &&
        widget.checkoutListDetails!.data![widget.index].qty != 0) {
      selectedValue =
          widget.checkoutListDetails!.data![widget.index].qty.toString();
      widget.onQtySelected(selectedValue!);
    }
    if (widget.checkoutListDetails!.data![widget.index].startdate != null &&
        widget.checkoutListDetails!.data![widget.index].enddate != null) {
      if (widget.checkoutListDetails!.data![widget.index].startdate !=
          widget.checkoutListDetails!.data![widget.index].enddate) {
        date =
            '${DateTimeFormatter.serviceDate(widget.checkoutListDetails!.data![widget.index].startdate!)} to ${DateTimeFormatter.serviceDate(widget.checkoutListDetails!.data![widget.index].enddate!)}';
        dialogCalendarPickerValue = [
          // DateTime.parse(
          widget.checkoutListDetails!.data![widget.index].startdate!,
          // DateTime.parse(
          widget.checkoutListDetails!.data![widget.index].enddate!
        ];
        widget.onDateSelected(
            DateTimeFormatter.serviceDate(
                widget.checkoutListDetails!.data![widget.index].startdate!),
            DateTimeFormatter.serviceDate(
                widget.checkoutListDetails!.data![widget.index].enddate!));
      } else {
        date = DateTimeFormatter.serviceDate(
            widget.checkoutListDetails!.data![widget.index].startdate!);
        widget.onDateSelected(
            DateTimeFormatter.serviceDate(
                widget.checkoutListDetails!.data![widget.index].startdate!),
            DateTimeFormatter.serviceDate(
                widget.checkoutListDetails!.data![widget.index].startdate!));
        dialogCalendarPickerValue = [
          // DateTime.parse(
          widget.checkoutListDetails!.data![widget.index].startdate!,
        ];
      }
    }
    if (widget.checkoutListDetails!.data![widget.index].starttime != null &&
        widget.checkoutListDetails!.data![widget.index].endtime != null) {
      if (widget.checkoutListDetails!.data![widget.index].starttime !=
          widget.checkoutListDetails!.data![widget.index].endtime) {
        selectTime = widget.checkoutListDetails!.data![widget.index].starttime!;
        selectTime1 = widget.checkoutListDetails!.data![widget.index].endtime!;
        widget.onTimeSelected(
            widget.checkoutListDetails!.data![widget.index].starttime!,
            widget.checkoutListDetails!.data![widget.index].endtime!);
      } else {
        selectTime = widget.checkoutListDetails!.data![widget.index].starttime!;
        widget.onTimeSelected(
            widget.checkoutListDetails!.data![widget.index].starttime!,
            widget.checkoutListDetails!.data![widget.index].starttime!);
      }
    }
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: SvgPicture.asset(
            alignment: Alignment.topLeft,
            Svgs.signOut,
            height: 60,
            width: 60,
          ),
          title: CustomDialog(
            text: getTranslated(
                'are_you_sure_you_want_to_delete_service', context)!,
            negBtn: getTranslated('cancel', context)!,
            negBtnOnTap: () {
              Navigator.pop(context);
            },
            posBtnOnTap: () async {
              await Provider.of<HomeViewModel>(context, listen: false)
                  .deleteBasketApi(
                      context,
                      widget.checkoutListDetails!.data![widget.index].id
                          .toString(),
                      widget.id!,
                      false);
            },
            posBtn: getTranslated('sure', context)!,
          ),
        );
      },
    );
  }

  List<String> items = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      direction: Axis.horizontal,
      endActionPane: (widget.isDeleteAvailable == true)
          ? ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: widget.deleteFuncAni,
                  backgroundColor: AppColors.redColor,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.containerBorderColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.checkoutListDetails!.data![widget.index].image !=
                    null)
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        if (widget.checkoutListDetails!.data![widget.index]
                                .propertyServiceId !=
                            null) {
                          Navigator.pushNamed(
                              context, RoutesName.subserviceScreen,
                              arguments: {
                                'id': widget.checkoutListDetails!
                                    .data![widget.index].propertyServiceId
                                    .toString(),
                              });
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Utils.cacheImage(
                          widget
                              .checkoutListDetails!.data![widget.index].image!,
                          (widget.checkoutListDetails!.data![widget.index]
                                          .desc !=
                                      null &&
                                  widget.checkoutListDetails!
                                      .data![widget.index].desc!.isNotEmpty)
                              ? 142
                              : 122,
                          130,
                          BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (widget.checkoutListDetails!.data![widget.index]
                                      .serviceTitle !=
                                  null &&
                              widget.checkoutListDetails!.data![widget.index]
                                      .serviceTitle !=
                                  '')
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (widget
                                          .checkoutListDetails!
                                          .data![widget.index]
                                          .propertyServiceId !=
                                      null) {
                                    Navigator.pushNamed(
                                        context, RoutesName.subserviceScreen,
                                        arguments: {
                                          'id': widget
                                              .checkoutListDetails!
                                              .data![widget.index]
                                              .propertyServiceId
                                              .toString(),
                                        });
                                  }
                                },
                                child: PoppinsText(
                                  data: widget.checkoutListDetails!
                                      .data![widget.index].serviceTitle!,
                                  fSize: 16,
                                  fontColor: AppColors.blackColor,
                                  fweight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (widget.isFavAvailable == true)
                            const Icon(
                              Icons.favorite,
                              color: AppColors.favColor,
                              size: 25,
                            ),
                          if (widget.isDeleteAvailable == true)
                            InkWell(
                              onTap: widget.deleteFunc,
                              child: (widget.checkoutListDetails!
                                          .data![widget.index].isadd ==
                                      false)
                                  ? const Icon(
                                      Icons.delete,
                                      color: AppColors.redColor,
                                      size: 25,
                                    )
                                  : Utils.ButtonLoader(AppColors.redColor, 30),
                            ),
                          if (widget.isFeedbackAvailable == true)
                            PoppinsText(
                              data: toBeginningOfSentenceCase(widget
                                  .checkoutListDetails!
                                  .data![widget.index]
                                  .status
                                  .toString()),
                              fSize: 14,
                              fontColor: AppColors.mainColor,
                              fweight: FontWeight.w500,
                            ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      if (widget.checkoutListDetails!.data![widget.index]
                                  .desc !=
                              null &&
                          widget.checkoutListDetails!.data![widget.index].desc!
                              .isNotEmpty)
                        InkWell(
                          onTap: () {
                            if (widget.checkoutListDetails!.data![widget.index]
                                    .propertyServiceId !=
                                null) {
                              Navigator.pushNamed(
                                  context, RoutesName.subserviceScreen,
                                  arguments: {
                                    'id': widget.checkoutListDetails!
                                        .data![widget.index].propertyServiceId
                                        .toString(),
                                  });
                            }
                          },
                          child: PoppinsTextSingleLine(
                            data: widget
                                .checkoutListDetails!.data![widget.index].desc!,
                            fSize: 13,
                            fontColor: AppColors.textFieldBorderColor,
                            fweight: FontWeight.w400,
                            textalign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      if (widget.checkoutListDetails!.data![widget.index]
                                  .desc !=
                              null &&
                          widget.checkoutListDetails!.data![widget.index].desc!
                              .isNotEmpty)
                        const SizedBox(height: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (widget.checkoutListDetails!.data![widget.index]
                                  .price !=
                              null)
                            PoppinsText(
                              data:
                                  '${widget.checkoutListDetails!.data![widget.index].price!.toStringAsFixed(2)}${Constants.currency}',
                              fSize: 18,
                              fontColor: AppColors.blackColor,
                              fweight: FontWeight.w600,
                            ),
                          if (widget.isDeleteAvailable == true) ...[
                            InkWell(
                              onTap: widget.noteFunction,
                              child: PoppinsText(
                                data: getTranslated('notes', context),
                                fSize: 14,
                                fontColor: AppColors.mainColor,
                                fweight: FontWeight.w500,
                              ),
                            )
                          ],
                          if (widget.isFeedbackAvailable == true &&
                              widget.checkoutListDetails!.data![widget.index]
                                      .status ==
                                  Constants.completed &&
                              widget.checkoutListDetails!.data![widget.index]
                                      .review ==
                                  null) ...[
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.serviceFeedbackScreen,
                                    arguments: {
                                      'orderlist': widget.checkoutListDetails,
                                      'index': widget.index,
                                    });
                              },
                              child: PoppinsText(
                                data: getTranslated('give_feedback', context),
                                fSize: 14,
                                fontColor: AppColors.mainColor,
                                fweight: FontWeight.w500,
                              ),
                            )
                          ] else if (widget.isFeedbackAvailable == true &&
                              widget.checkoutListDetails!.data![widget.index]
                                      .status !=
                                  Constants.claimed &&
                              widget.checkoutListDetails!.data![widget.index]
                                      .status !=
                                  Constants.refunded &&
                              widget.checkoutListDetails!.data![widget.index]
                                      .status !=
                                  Constants.rejected &&
                              widget.checkoutListDetails!.data![widget.index]
                                      .status !=
                                  Constants.completed) ...[
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.damageScreen,
                                      arguments: {
                                        "orderid": widget.checkoutListDetails!
                                            .data![widget.index].userId
                                            .toString(),
                                        "isdamage": false
                                      });
                                },
                                child: PoppinsText(
                                  data: getTranslated('give_claim', context),
                                  fSize: 14,
                                  fontColor: AppColors.mainColor,
                                  fweight: FontWeight.w500,
                                )),
                          ]
                        ],
                      ),
                      (widget.isFeedbackAvailable == false)
                          ? const SizedBox(height: 4)
                          : const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColors.containerBorderColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.blackColor,
                                        blurRadius: 1,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4, left: 4, right: 4),
                                    child: _buildCalendarDialogButton(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColors.containerBorderColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.blackColor,
                                        blurRadius: 1,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, bottom: 3, left: 4, right: 4),
                                    child: _buildTimeDialogButton(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                flex: 1,
                                child: Container(
                                    //width: 62, // Example width
                                    height: 27, // Example height
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppColors.containerBorderColor,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: AppColors.blackColor,
                                          blurRadius: 1,
                                        )
                                      ],
                                    ),
                                    child: (widget.isValueDynamic == false)
                                        ? DropdownButton<String>(
                                            isExpanded: true,
                                            isDense: false,
                                            iconSize: 19,
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: PoppinsText(
                                                data: getTranslated(
                                                    'qty', context),
                                                fSize: 9,
                                                fontColor: AppColors.blackColor,
                                                fweight: FontWeight.w500,
                                              ),
                                            ),
                                            underline: const SizedBox(),
                                            items: items.map((String item) {
                                              return DropdownMenuItem<String>(
                                                value: item,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: PoppinsText(
                                                    data: item,
                                                    fSize: 9,
                                                    fontColor:
                                                        AppColors.blackColor,
                                                    fweight: FontWeight.w500,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            selectedItemBuilder:
                                                (BuildContext context) {
                                              return items
                                                  .map<Widget>((String item) {
                                                return Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0),
                                                    child: PoppinsText(
                                                      data:
                                                          '${getTranslated('qty', context)}: $item',
                                                      fSize: 9,
                                                      fontColor:
                                                          AppColors.blackColor,
                                                      fweight: FontWeight.w500,
                                                    ),
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            value: selectedValue,
                                            onChanged: (String? value) {
                                              if (widget.isValueDynamic ==
                                                  false) {
                                                setState(() {
                                                  selectedValue = value;
                                                  widget.onQtySelected(
                                                      selectedValue!);
                                                });
                                              }
                                            },
                                            style: TextStyles.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.blackColor,
                                              fontSize: 9,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Center(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  PoppinsText(
                                                    data:
                                                        '${getTranslated('qty', context)}: $selectedValue',
                                                    fSize: 9,
                                                    fontColor:
                                                        AppColors.blackColor,
                                                    fweight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String date = '';

  _buildCalendarDialogButton() {
    return InkWell(
      onTap: () async {
        if (widget.isValueDynamic == false) {
          String dateRange = await Utils.selectCalendarDate(
              context, date, dialogCalendarPickerValue);
          setState(() {
            date = dateRange;
            List<String> dates = dateRange.split(" to ");
            String startDate = dates[0];
            String endDate = (dates.length == 2) ? dates[1] : dates[0];
            if (kDebugMode) {
              print(startDate);
              print(endDate);
            }
            widget.onDateSelected(startDate, endDate);
            // Update the dialogCalendarPickerValue with the selected dates
            dialogCalendarPickerValue = [
              DateTime.parse(startDate),
              dates.length == 2 ? DateTime.parse(endDate) : null
            ];
          });
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (date == '')
              ? PoppinsText(
                  data: getTranslated('date', context),
                  fSize: 10,
                  fontColor: AppColors.blackColor,
                  fweight: FontWeight.w500,
                )
              : Expanded(
                  child: PoppinsText(
                    data: date,
                    fSize: 10,
                    fontColor: AppColors.blackColor,
                    fweight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
          const SizedBox(
            width: 3,
          ),
          const SizedBox(
            child: Icon(
              Icons.calendar_month,
              color: AppColors.textFieldBorderColor,
              size: 19,
            ),
          ),
        ],
      ),
    );
  }

  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  _buildTimeDialogButton() {
    return InkWell(
      onTap: () async {
        if (widget.isValueDynamic == false) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(10),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: PoppinsText(
                        data: getTranslated('select_time', context),
                        fSize: 20,
                        fontColor: AppColors.blackColor,
                        fweight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTimer(
                      controller: _controller,
                      startTimeString: selectTime,
                      endTimeString: selectTime1,
                      onStartTimeSelected: (hours, minutes, isAm) {
                        setState(() {
                          _startTime = TimeOfDay(hour: hours, minute: minutes);
                          String amPm =
                              (isAm == 0) ? Constants.am : Constants.pm;
                          selectTime =
                              '${(hours < 10) ? '0$hours' : hours}:${(minutes < 10) ? '0$minutes' : minutes} $amPm';
                          widget.onTimeSelected(
                              DateTimeFormatter.sendTime(selectTime),
                              DateTimeFormatter.sendTime(selectTime));
                        });
                      },
                      onStartAndEndTimeSelected: (hours, minutes, isAm) {
                        setState(() {
                          _endTime = TimeOfDay(hour: hours, minute: minutes);
                          String amPm =
                              (isAm == 0) ? Constants.am : Constants.pm;
                          selectTime1 =
                              '${(hours < 10) ? '0$hours' : hours}:${(minutes < 10) ? '0$minutes' : minutes} $amPm';
                          widget.onTimeSelected(
                              DateTimeFormatter.sendTime(selectTime),
                              DateTimeFormatter.sendTime(selectTime1));
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (selectTime != '' && selectTime1 != '')
              ? Expanded(
                  child: PoppinsText(
                    data:
                        '${DateTimeFormatter.serviceTime(selectTime)} - ${DateTimeFormatter.serviceTime(selectTime1)}',
                    fSize: 9,
                    fontColor: AppColors.blackColor,
                    fweight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : (selectTime != '')
                  ? Expanded(
                      child: PoppinsText(
                        data: DateTimeFormatter.serviceTime(selectTime),
                        fSize: 9,
                        fontColor: AppColors.blackColor,
                        fweight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : PoppinsText(
                      data: getTranslated('time', context),
                      fSize: 9,
                      fontColor: AppColors.blackColor,
                      fweight: FontWeight.w500,
                    ),
          const Icon(
            Icons.timelapse,
            color: AppColors.textFieldBorderColor,
            size: 19,
          ),
        ],
      ),
    );
  }
}
