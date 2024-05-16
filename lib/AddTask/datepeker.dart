
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:intl/intl_browser.dart';


class DatePikerCard extends StatefulWidget {
  const DatePikerCard({super.key});

  @override
  State<DatePikerCard> createState() => _DatePikerCardState();
}

class _DatePikerCardState extends State<DatePikerCard> {

// String startDate = DateFormat.yMMMMd().format(DateTime.now());
String startDate = '${DateFormat.d().format(DateTime.now())} ${DateFormat.LLL().format(DateTime.now())}, ${DateFormat.y().format(DateTime.now())}';


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(startDate,),
        SizedBox(width: 10,),
        InkWell(
          onTap: ()async {
            
               DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate:DateTime.now(), 
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  
                      String formattedDate = DateFormat.yMMMMd().format(pickedDate); 
                      print(formattedDate); 
                      setState(() {
                        startDate = '${DateFormat.d().format(pickedDate)} ${DateFormat.LLL().format(pickedDate)}, ${DateFormat.y().format(pickedDate)}';
                      });
                  }

                  
          },
          child: Icon(Icons.calendar_month,size: 25,),
        )
      ],
    );
  }
}


class TimePickerCard extends StatefulWidget {
  const TimePickerCard({super.key});

  @override
  State<TimePickerCard> createState() => _TimePickerCardState();
}

class _TimePickerCardState extends State<TimePickerCard> {
  TimeOfDay initialTime = TimeOfDay.now();
                     
      // String time = "${(initialTime.hour > 12 ? initialTime.hour - 12 : initialTime.hour).abs()}:${initialTime.minute} ${initialTime.hour >= 12 ? "PM" : "AM"}";

    // String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    String currentTime = '';

@override
  void initState() {
    // TODO: implement initState
    currentTime = '${(initialTime.hour > 12 ? initialTime.hour - 12 : initialTime.hour).abs()}:${initialTime.minute} ${initialTime.hour >= 12 ? "PM" : "AM"}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(currentTime,),
        SizedBox(width: 10,),
        InkWell(
          onTap: ()async {
            
              TimeOfDay? pickedTime =  await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          initialEntryMode: TimePickerEntryMode.dial,
                          context: context,
                      );
                  
                  if(pickedTime != null ){
                      print(pickedTime.format(context));   //output 10:51 PM
                      // DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                      // //converting to DateTime so that we can further format on different pattern.
                      // print(parsedTime); //output 1970-01-01 22:53:00.000
                      // String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                      // print(formattedTime); //output 14:59:00
                      // //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        currentTime = '${(pickedTime.hour > 12 ? pickedTime.hour - 12 : pickedTime.hour).abs()}:${pickedTime.minute} ${pickedTime.hour >= 12 ? "PM" : "AM"}'; //set the value of text field. 
                      });
                  }else{
                      print("Time is not selected");
                  }

                  
          },
          child: Icon(Icons.alarm_add_outlined,size: 25,),
        )
      ],
    );
  }
}

