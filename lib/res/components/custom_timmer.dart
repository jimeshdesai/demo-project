// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:demo-project/localization/language_constrants.dart';
import 'package:demo-project/res/components/custom_text.dart';
import 'package:demo-project/utils/color.dart';
import 'package:demo-project/utils/constants.dart';
import 'package:demo-project/utils/date_time_formatter.dart';
import 'package:demo-project/utils/utils.dart';
import 'package:demo-project/view/profile_view/widget/custom_profile.dart';

class CustomTimer extends StatefulWidget {
  CustomTimer({
    super.key,
    required this.controller,
    required this.onStartTimeSelected,
    required this.onStartAndEndTimeSelected,
    this.startTimeString,
    this.endTimeString,
  });

  ScrollController? controller;
  final void Function(int hours, int minutes, int isAm) onStartTimeSelected;
  final void Function(int hours, int minutes, int isAm) onStartAndEndTimeSelected;
  String? startTimeString;
  String? endTimeString;

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String getStartTime = '';
  String getEndTime = '';

  @override
  void initState() {
    super.initState();
    if (widget.startTimeString != null && widget.startTimeString!.isNotEmpty) {
      getStartTime = DateTimeFormatter.serviceTime(widget.startTimeString!);
      _startTime = DateTimeFormatter.stringToTimeOfDay1(getStartTime);
    }
    if (widget.endTimeString != null && widget.endTimeString!.isNotEmpty) {
      getEndTime = DateTimeFormatter.serviceTime(widget.endTimeString!);
      _endTime = DateTimeFormatter.stringToTimeOfDay1(getEndTime);
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    try {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: _startTime ?? TimeOfDay.now(),
      );
      if (picked != null) {
        setState(() {
          _startTime = picked;
          getStartTime = timeOfDayToString(picked);

          // Automatically set the end time to 1 hour after the start time if end time is not selected yet
          if (_endTime == null || _endTime!.hour <= _startTime!.hour) {
            int endHour = (_startTime!.hour + 1) % 24;
            int endMinute = _startTime!.minute;
            TimeOfDay endPicked = TimeOfDay(hour: endHour, minute: endMinute);
            _endTime = endPicked;
            getEndTime = timeOfDayToString(endPicked);
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error selecting time: $e');
      }
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    try {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: _endTime ?? TimeOfDay.now(),
      );
      if (picked != null && _startTime != null) {
        // Ensure the end time is at least 1 hour after the start time
        int startInMinutes = _startTime!.hour * 60 + _startTime!.minute;
        int pickedInMinutes = picked.hour * 60 + picked.minute;
        if (pickedInMinutes >= startInMinutes + 60) {
          setState(() {
            _endTime = picked;
            getEndTime = timeOfDayToString(picked);
          });
        } else {
          Utils.toastMessage(
            getTranslated(
                'end_time_must_be_at_least_1_hour_after_start_time', context)!,
            true,
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error selecting time: $e');
      }
    }
  }

  String timeOfDayToString(TimeOfDay time) {
    final hour = (time.hour % 12 == 0) ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? Constants.am : Constants.pm;
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: PoppinsText(
                data: getTranslated('start_time', context),
                fSize: 16,
                fontColor: AppColors.whiteColor,
                fweight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    _selectStartTime(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.timelapse_outlined,
                                color: AppColors.whiteColor,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              PoppinsText(
                                data: getStartTime.isNotEmpty
                                    ? getStartTime
                                    : getTranslated(
                                        'click_to_add_start_time', context),
                                fSize: 14,
                                fontColor: AppColors.whiteColor,
                                fweight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const CustomDivider(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: PoppinsText(
                data: getTranslated('end_time', context),
                fSize: 16,
                fontColor: AppColors.whiteColor,
                fweight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (getStartTime.isNotEmpty) {
                      _selectEndTime(context);
                    } else {
                      Utils.toastMessage(
                        getTranslated('first_select_start_time', context)!,
                        true,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.timelapse_outlined,
                                color: AppColors.whiteColor,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              PoppinsText(
                                data: getEndTime.isNotEmpty
                                    ? getEndTime
                                    : getTranslated(
                                        'click_to_add_end_time', context),
                                fSize: 14,
                                fontColor: AppColors.whiteColor,
                                fweight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15, right: 15),
            child: Row(
              children: [
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.whiteColor),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: CustomText(
                        data: getTranslated('cancel', context),
                        fSize: 14,
                        fontColor: AppColors.whiteColor,
                        fweight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.whiteColor,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (_startTime != null) {
                        widget.onStartTimeSelected(
                          _startTime!.hour,
                          _startTime!.minute,
                          _startTime!.period == DayPeriod.am ? 0 : 1,
                        );
                      }
                      if (_endTime != null) {
                        widget.onStartAndEndTimeSelected(
                          _endTime!.hour,
                          _endTime!.minute,
                          _endTime!.period == DayPeriod.am ? 0 : 1,
                        );
                      }
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: CustomText(
                        data: getTranslated('sure', context),
                        fSize: 14,
                        fontColor: AppColors.mainColor,
                        fweight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
