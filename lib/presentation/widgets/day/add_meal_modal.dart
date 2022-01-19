import 'package:calorie_calculator/domain/entities/meal.dart';
import 'package:calorie_calculator/presentation/bloc/dates_bloc.dart';
import 'package:calorie_calculator/utils/date_converters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrUpdateMealModal extends StatefulWidget {
  final Meal? meal;

  const AddOrUpdateMealModal({Key? key, this.meal}) : super(key: key);

  @override
  _AddMealModalState createState() => _AddMealModalState();
}

class _AddMealModalState extends State<AddOrUpdateMealModal> {
  late TextEditingController nameController;
  late TextEditingController weightController;
  late TextEditingController caloriesController;
  late TextEditingController portionController;

  @override
  void initState() {
    nameController = TextEditingController();
    weightController = TextEditingController();
    caloriesController = TextEditingController();
    portionController = TextEditingController();
    super.initState();
    if (widget.meal != null) {
      setState(() {
        nameController.text = widget.meal?.name ?? '';
        weightController.text = widget.meal?.weight.toString() ?? '';
        caloriesController.text = widget.meal?.calories.toString() ?? '';
        portionController.text = widget.meal?.portion ?? '';
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    weightController.dispose();
    caloriesController.dispose();
    portionController.dispose();
    super.dispose();
  }

  void addMeal() {
    print(dateToString(DateTime.now().toLocal()));
    Meal meal = Meal(
        id: 'id',
        date: dateToString(DateTime.now().toLocal()),
        name: nameController.text,
        calories: double.parse(caloriesController.text),
        weight: double.parse(weightController.text),
        portion: portionController.text);
    BlocProvider.of<DatesBloc>(context).add(AddMealEvent(meal));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        height: 420,
        child: ListView(
          children: [
            Text(
              widget.meal == null ? 'Add meal' : 'Edit meal',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            generateCustomInput(controller: nameController, hint: 'Name'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: generateCustomInput(
                      controller: portionController, hint: 'Portion'),
                ),
                Tooltip(
                  message: 'For example "1 cup"',
                  triggerMode: TooltipTriggerMode.tap,
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text('?',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        )),
                  ),
                ),
              ],
            ),
            generateCustomInput(controller: weightController, hint: 'Weight'),
            generateCustomInput(
                controller: caloriesController, hint: 'Calories'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: addMeal,
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                  ),
                ),
                TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text('Cancel')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget generateCustomInput(
    {required TextEditingController controller, required String hint}) {
  return Container(
    height: 60,
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(width: 2, color: Colors.blueGrey.shade600),
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration.collapsed(hintText: hint),
    ),
  );
}
