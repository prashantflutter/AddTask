
import 'package:aveosoft/AddTask/datepeker.dart';
import 'package:flutter/material.dart';
enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   ColorLabel? selectedColor;
  IconLabel? selectedIcon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (ctx){
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text('Task Name'),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                        enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                  ),
                ),
                DatePikerCard(),
                SizedBox(height: 10,),
                TimePickerCard(),
                SizedBox(height: 10,),
                DropdownMenu(
                   initialSelection: ColorLabel.green,
                   requestFocusOnTap: true,
                      label: const Text('Color'),
                      onSelected: (ColorLabel? color) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                  dropdownMenuEntries: ColorLabel.values
                          .map<DropdownMenuEntry<ColorLabel>>(
                              (ColorLabel color) {
                        return DropdownMenuEntry<ColorLabel>(
                          value: color,
                          label: color.label,
                          // enabled: color.label != 'Grey',
                          style: MenuItemButton.styleFrom(
                            foregroundColor: color.color,
                          ),
                        );
                      }).toList(),),
                      const SizedBox(width: 24),
                    DropdownMenu<IconLabel>(
                      // controller: iconController,
                      enableFilter: true,
                      requestFocusOnTap: true,
                      leadingIcon: const Icon(Icons.search),
                      label: const Text('Icon'),
                      inputDecorationTheme: const InputDecorationTheme(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      onSelected: (IconLabel? icon) {
                        setState(() {
                          selectedIcon = icon;
                        });
                      },
                      dropdownMenuEntries:
                          IconLabel.values.map<DropdownMenuEntry<IconLabel>>(
                        (IconLabel icon) {
                          return DropdownMenuEntry<IconLabel>(
                            value: icon,
                            label: icon.label,
                            leadingIcon: Icon(icon.icon),
                          );
                        },
                      ).toList(),
                    ),
                  ],
            ),
          );
        });
      }, child: const Text('Add Task')),),
    );
  }
}