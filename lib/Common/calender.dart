import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderPage extends StatefulWidget {
  final String username;

  CalenderPage({required this.username});

  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Lovely 1 bedroom in Uptown Dallas',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SimpleVerticalCalendar(
        numOfMonth: 100,
        headerStyle: const HeaderStyle(
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
          ),
          textAlign: TextAlign.left,
          monthFormat: MonthFormats.short,
        ),
        calendarOption:
            CalendarOptions.multiple, // [rangeSelection, single, multiple]
        dayOfWeekHeaderStyle: const DayOfWeekHeaderStyle(
            textStyle:
                TextStyle(fontWeight: FontWeight.w800, color: Colors.black54)),
        dayStyle: const DayHeaderStyle(
          textColor: Colors.black,
        ),
        onDateTap: (start, end) {},
        onDateAdded: (dateAdded) {},
        onDateRemoved: (dateRemoved) {},
      ),
    );
  }
}

///CALENDAR.DART
class SimpleVerticalCalendar extends StatefulWidget {
  /// the default selected start date when initialize the calendar
  final DateTime? startDate;

  /// the default selected end date when initialize the calendar
  final DateTime? endDate;

  /// Number of Month to display in the calendar.
  ///
  /// For example: `numOfMonth = 6` will include the next 6 months to calendar.
  final int numOfMonth;

  /// Styling your Month Header widget using [HeaderStyle].
  final HeaderStyle headerStyle;

  /// Styling your Day widget using [DayHeaderStyle].
  final DayHeaderStyle dayStyle;

  /// Styling your Day of the week widget using [DayOfWeekHeaderStyle].
  final DayOfWeekHeaderStyle dayOfWeekHeaderStyle;

  ///[dayOfWeek] is a list of String that display in text for your Day of Week Widget.
  ///
  /// For example: `dayOfWeek = const ["M", "T", "W", "T", "F", "S", "S"]`
  ///
  /// where index of Monday = 0, and Sunday = 6.
  final List<String> dayOfWeek;

  ///[calendarOption] pick your option between [RANGE, SINGLE_SELECTION]
  ///
  final CalendarOptions calendarOption;

  final void Function(DateTime startDate, DateTime? endDate)? onDateTap;
  final void Function(DateTime dateAdded)? onDateAdded;
  final void Function(DateTime dateRemoved)? onDateRemoved;

  const SimpleVerticalCalendar({
    Key? key,
    this.startDate,
    this.endDate,
    this.numOfMonth = 12,
    this.headerStyle = const HeaderStyle(),
    this.dayStyle = const DayHeaderStyle(),
    this.onDateTap,
    this.onDateAdded,
    this.onDateRemoved,
    this.dayOfWeekHeaderStyle = const DayOfWeekHeaderStyle(),
    this.calendarOption = CalendarOptions.rangeSelection,
    this.dayOfWeek = const ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
  }) : super(key: key);
  @override
  State<SimpleVerticalCalendar> createState() => _SimpleVerticalCalendarState();
}

class _SimpleVerticalCalendarState extends State<SimpleVerticalCalendar> {
  DateTime? current;
  int? startMonth;
  int? endMonth;
  DateTime? startDate;
  DateTime? endDate;
  double? boxHeight;
  _SimpleVerticalCalendarState();
  @override
  void initState() {
    current = DateTime.now();
    startMonth = current!.month;
    endMonth = startMonth! + widget.numOfMonth;
    startDate = widget.startDate;
    endDate = widget.endDate;

    super.initState();
  }

  void rangeSelectedTapEvent(DateTime selectedDay) {
    if (startDate == null || startDate!.compareTo(selectedDay) > 0) {
      setState(() {
        startDate = selectedDay;
        endDate = selectedDay;
      });
    } else if (startDate!.compareTo(endDate!) == 0) {
      setState(() {
        endDate = selectedDay;
      });
    } else {
      setState(() {
        startDate = selectedDay;
        endDate = selectedDay;
      });
    }
    widget.onDateTap!(startDate!, endDate!);
  }

  void singleSelectedTapEvent(DateTime selectedDay) {
    setState(() {
      startDate = selectedDay;
      endDate = selectedDay;
    });
    widget.onDateTap!(startDate!, endDate!);
  }

  List<DateTime> multipleDates = [];
  void multiSelectedTapEvent(DateTime selectedDay) {
    setState(() {
      if (multipleDates.contains(selectedDay)) {
        multipleDates.remove(selectedDay);
        if (widget.onDateRemoved != null) widget.onDateRemoved!(selectedDay);
      } else {
        multipleDates.add(selectedDay);
        if (widget.onDateAdded != null) widget.onDateAdded!(selectedDay);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    boxHeight = (MediaQuery.of(context).size.width - 70) / 7;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.numOfMonth,
      itemBuilder: (context, index) {
        DateTime currentListMonth =
            DateTime(current!.year, current!.month + index, 1);
        List<DateTime?> days = populateDate(currentListMonth);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: HeaderWidget(
                currentListMonth,
                headerStyle: widget.headerStyle,
              ),
            ),
            const SizedBox(height: 10),
            Table(
              children: buildTableRows(days),
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }

  List<TableRow> buildTableRows(List<DateTime?> days) {
    return [
      TableRow(
        children: [
          for (var i in widget.dayOfWeek)
            DayOfWeekWidget(
              i,
              dayOfWeekStyle: widget.dayOfWeekHeaderStyle,
            ),
        ],
      ),
      for (var d = 0; d <= days.length ~/ 7; d++)
        if (d * 7 < days.length)
          TableRow(
            children: [
              for (var w = 0; w < 7; w++)
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 0.05)),
                  child: InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: (d * 7 + w) >= days.length ||
                            days[d * 7 + w] != null &&
                                days[d * 7 + w]!.isBefore(current!)
                        ? null
                        : () {
                            switch (widget.calendarOption) {
                              case CalendarOptions.rangeSelection:
                                rangeSelectedTapEvent(days[d * 7 + w]!);
                                break;
                              case CalendarOptions.single:
                                singleSelectedTapEvent(days[d * 7 + w]!);
                                break;
                              case CalendarOptions.multiple:
                                multiSelectedTapEvent(days[d * 7 + w]!);
                                break;
                              default:
                                rangeSelectedTapEvent(days[d * 7 + w]!);
                                break;
                            }
                          },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (!checkInvalidDate(d * 7 + w, days))
                          if (checkInRange(
                              days[d * 7 + w]!, startDate, endDate))
                            Container(
                              width: double.maxFinite,
                              height: boxHeight! - 10,
                              decoration: BoxDecoration(
                                color:
                                    widget.dayStyle.dateInRangeBackgroundColor,
                              ),
                              margin: EdgeInsets.only(
                                left: startDate == days[d * 7 + w]
                                    ? boxHeight! / 2
                                    : 0,
                                right: endDate == days[d * 7 + w]
                                    ? boxHeight! / 2
                                    : 0,
                              ),
                            ),
                        Container(
                          width: boxHeight,
                          height: boxHeight,
                          alignment: Alignment.center,
                          decoration: (!checkInvalidDate(d * 7 + w, days))
                              ? BoxDecoration(
                                  borderRadius: checkIsFirstOrLast(
                                              days[d * 7 + w]!,
                                              startDate,
                                              endDate) ||
                                          multipleDates
                                              .contains(days[d * 7 + w])
                                      ? BorderRadius.circular(100 * 100)
                                      : BorderRadius.circular(0),
                                  color: checkIsFirstOrLast(days[d * 7 + w]!,
                                              startDate, endDate) ||
                                          multipleDates
                                              .contains(days[d * 7 + w])
                                      ? const Color(0xff524F52)
                                      : Colors.transparent,
                                )
                              : const BoxDecoration(),
                          child: Text(
                            checkInvalidDate(d * 7 + w, days)
                                ? ''
                                : days[d * 7 + w]?.day.toString() ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: checkInvalidDate(d * 7 + w, days,
                                      current: current!
                                          .subtract(const Duration(days: 1)))
                                  ? widget.dayStyle.unavailableTextColor
                                  : checkInRange(
                                            days[d * 7 + w]!,
                                            startDate,
                                            endDate,
                                          ) ||
                                          multipleDates
                                              .contains(days[d * 7 + w])
                                      ? widget.dayStyle.selectedTextColor
                                      : widget.dayStyle.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
    ];
  }
}

///DAY.DART
class DayWidget extends StatelessWidget {
  final String thisHeaderText;
  final DayHeaderStyle? dayOfWeekStyle;
  final double? boxHeight;
  final bool? isInRange;
  final bool? isFirstOrLast;
  final bool? isValidDate;
  const DayWidget(this.thisHeaderText,
      {this.dayOfWeekStyle,
      this.boxHeight,
      this.isInRange,
      this.isFirstOrLast,
      this.isValidDate,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

///DAY_OF_THE_WEEK.DART
/// [DayOfWeekWidget] is the widget for building DayOfWeek section of the calendar.
class DayOfWeekWidget extends StatelessWidget {
  ///Display text for this widget
  final String thisHeaderText;

  ///Styling specify by user
  final DayOfWeekHeaderStyle? dayOfWeekStyle;
  const DayOfWeekWidget(this.thisHeaderText, {this.dayOfWeekStyle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: dayOfWeekStyle?.backgroundStyle,
      margin: dayOfWeekStyle?.margin,
      padding: dayOfWeekStyle?.padding,
      child: Text(
        thisHeaderText,
        style: dayOfWeekStyle?.textStyle,
        textAlign: dayOfWeekStyle?.textAlign,
      ),
    );
  }
}

///HEADER.DART
class HeaderWidget extends StatelessWidget {
  ///Display text for this widget
  final DateTime thisHeaderDate;

  ///Styling specify by user
  final HeaderStyle? headerStyle;
  const HeaderWidget(this.thisHeaderDate, {this.headerStyle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: headerStyle?.backgroundStyle,
      child: Text(
        ///intl PACKAGE USED
        ///TODO
        DateFormat(monthFormat[headerStyle?.monthFormat])
            .format(thisHeaderDate),
        style: headerStyle?.titleTextStyle,
        textAlign: headerStyle?.textAlign,
      ),
    );
  }
}

/// [HeaderStyle] is the styling class for each month header of the widget.
///
/// Using this style, you can add styling to your Month header widget.
/// This class also give different text format to your Month header by using [MonthFormats].
///
/// The currently available style are: titleTextStyle, monthFormat, backgroundStyle, textAlign
class HeaderStyle {
  final TextStyle titleTextStyle;
  final MonthFormats monthFormat;
  final Decoration? backgroundStyle;
  final TextAlign textAlign;
  const HeaderStyle({
    this.titleTextStyle = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w800,
    ),
    this.monthFormat = MonthFormats.monthOnly,
    this.backgroundStyle,
    this.textAlign = TextAlign.center,
  });
}

/// [DayOfWeekHeaderStyle] is the styling class for Day of the Week widget.
///
/// Using this style, you can add styling to your Day of the week widget.
///
/// The currently available style are: padding, margin, backgroundStyle, textStyle, textAlign
class DayOfWeekHeaderStyle {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Decoration backgroundStyle;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  const DayOfWeekHeaderStyle({
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.margin = EdgeInsets.zero,
    this.backgroundStyle = const BoxDecoration(),
    this.textAlign = TextAlign.center,
  });
}

/// [DayHeaderStyle] is the styling class for Day widget.
///
/// Using this style, you can specify all colors that you want for your Day.
///
/// The currently available style are: backgroundColor, selectedBackgroundColor
/// dateInRangeBackgroundColor, textColor, selectedTextColor, unavailableTextColor.
class DayHeaderStyle {
  final Color backgroundColor;
  final Color selectedBackgroundColor;
  final Color dateInRangeBackgroundColor;
  final Color textColor;
  final Color selectedTextColor;
  final Color unavailableTextColor;
  const DayHeaderStyle({
    this.backgroundColor = Colors.transparent,
    this.selectedBackgroundColor = Colors.black,
    this.dateInRangeBackgroundColor = Colors.black45,
    this.textColor = Colors.black,
    this.selectedTextColor = Colors.white,
    this.unavailableTextColor = Colors.grey,
  });
}

///HELPER.DART
/// check for invalid within the list of date given the index.
bool checkInvalidDate(int index, List<DateTime?> days, {DateTime? current}) {
  if (current != null) {
    return index >= days.length ||
        days[index] == null ||
        days[index]!.isBefore(current);
  } else {
    return index >= days.length || days[index] == null;
  }
}

/// check if date is in between Start Date and End Date.
bool checkInRange(
    DateTime currentDate, DateTime? startDate, DateTime? endDate) {
  if (startDate == null || endDate == null) return false;
  if (currentDate.isBefore(endDate) && currentDate.isAfter(startDate) ||
      currentDate == endDate ||
      currentDate == startDate) {
    return true;
  }
  return false;
}

/// check if date is one of Start Date or End Date
bool checkIsFirstOrLast(
    DateTime currentDate, DateTime? startDate, DateTime? endDate) {
  if (startDate == null || endDate == null) return false;

  if (currentDate.isSameDate(startDate) || currentDate.isSameDate(endDate)) {
    return true;
  }
  return false;
}

/// generate a list of Date for each month
List<DateTime?> populateDate(DateTime date) {
  var firstDayThisMonth = DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = DateTime(firstDayThisMonth.year,
      firstDayThisMonth.month + 1, firstDayThisMonth.day);

  List<DateTime?> dt = <DateTime?>[];
  for (var i = 0;
      i < firstDayNextMonth.difference(firstDayThisMonth).inDays;
      i++) {
    dt.add(DateTime(firstDayThisMonth.year, firstDayThisMonth.month, 1 + i));
  }
  if (dt.first!.weekday > 1) {
    dt.insertAll(
        0, List<DateTime?>.generate(dt.first!.weekday - 1, (index) => null));
  }
  return dt;
}

/// Date extension to check if Date is the same
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

///
// CONSTANT.DART
/// [MonthFormats] can be used to format your month header.
///
/// current support format are: `full`, `short`, `month_only`.
enum MonthFormats { full, short, monthOnly }

const monthFormat = {
  MonthFormats.full: 'MMMM y',
  MonthFormats.short: 'MMM y',
  MonthFormats.monthOnly: 'MMMM',
};

/// [CalendarOptions] is the type of the selection of the calendar.
///
/// current support format are: `rangeSelection`, `single`, `multiple`.
enum CalendarOptions { rangeSelection, single, multiple }
