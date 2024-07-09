import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/colors/colors.dart';
import 'package:healmypet/appassets/sizedbox_height.dart';
import 'package:healmypet/view/Screens/joine_as_Petowner/Add%20Profile/controller/controller.dart';
import 'package:intl/intl.dart';

class DatePickerPet extends StatefulWidget {
  @override
  _DatePickerPetState createState() => _DatePickerPetState();
}

class _DatePickerPetState extends State<DatePickerPet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PetProfileController controller = Get.find<PetProfileController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.amber,
              labelColor: Colors.amber,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: grey1,
              tabs: [
                Row(
                  children: [
                    Image.asset('assets/images/Vector (2).png'),
                    AppSizedBoxes.smallWidthSizedBox,
                    Tab(text: 'Birth date'),
                  ],
                ),
                Row(
                  children: [
                    Image.asset('assets/images/Vector (3).png'),
                    AppSizedBoxes.smallWidthSizedBox,
                    Tab(text: 'Adoption date'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      CustomDatePicker(
                        initialDate: controller.selectedBirthDate.value,
                        firstDate: DateTime(2016),
                        lastDate: DateTime(2023),
                        onDateSelected: (date) {
                          controller.updateBirthDate(date);
                        },
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomDatePicker(
                        initialDate: controller.selectedAppointmentDate.value,
                        firstDate: DateTime(2016),
                        lastDate: DateTime(2023),
                        onDateSelected: (date) {
                          controller.updateAppointmentDate(date);
                        },
                      ),
                    ],
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

class CustomDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onDateSelected;

  CustomDatePicker({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  });

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime selectedDate;
  late PageController _yearController;
  late PageController _monthController;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    _yearController = PageController(
      initialPage: selectedDate.year - widget.firstDate.year,
    );
    _monthController = PageController(
      initialPage: selectedDate.month - 1,
    );
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    super.dispose();
  }

  void _onYearChanged(int year) {
    setState(() {
      selectedDate = DateTime(year, selectedDate.month, selectedDate.day);
      widget.onDateSelected(selectedDate);
    });
  }

  void _onMonthChanged(int month) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, month, selectedDate.day);
      widget.onDateSelected(selectedDate);
    });
  }

  void _onDayChanged(int day) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month, day);
      widget.onDateSelected(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgcolor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 16),
          _buildYearSelector(),
          AppSizedBoxes.normalSizedBox,
          _buildMonthSelector(),
          _buildDaySelector(),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildYearSelector() {
    return Container(
      height: 50,
      child: PageView.builder(
        controller: _yearController,
        onPageChanged: (index) {
          _onYearChanged(widget.firstDate.year + index);
        },
        itemBuilder: (context, index) {
          return Container(
            height: 40,
            width: 90,
            decoration: BoxDecoration(color: bgcolor1),
            child: Center(
              child: Text(
                '${widget.firstDate.year + index}',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          );
        },
        itemCount: widget.lastDate.year - widget.firstDate.year + 1,
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Container(
      height: 50,
      child: PageView.builder(
        controller: _monthController,
        onPageChanged: (index) {
          _onMonthChanged(index + 1);
        },
        itemBuilder: (context, index) {
          return Container(
            height: 40,
            width: 90,
            decoration: BoxDecoration(color: bgcolor1),
            child: Center(
              child: Text(
                DateFormat.MMMM().format(DateTime(0, index + 1)),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          );
        },
        itemCount: 12,
      ),
    );
  }

  Widget _buildDaySelector() {
    return Container(
      height: 300,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1.0,
        ),
        itemCount: DateTime(selectedDate.year, selectedDate.month + 1, 0).day,
        itemBuilder: (context, index) {
          final day = index + 1;
          return GestureDetector(
            onTap: () {
              _onDayChanged(day);
            },
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color:
                    selectedDate.day == day ? Colors.blue : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$day',
                  style: TextStyle(
                    color:
                        selectedDate.day == day ? Colors.white : Colors.white70,
                    fontWeight: selectedDate.day == day
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
