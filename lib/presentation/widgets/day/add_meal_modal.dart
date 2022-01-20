import 'package:calorie_calculator/domain/entities/meal.dart';
import 'package:calorie_calculator/presentation/bloc/dates_bloc.dart';
import 'package:calorie_calculator/utils/date_converters.dart';
import 'package:calorie_calculator/utils/get_calories_per_portion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrUpdateMealModal extends StatefulWidget {
  final Meal? meal;
  final String? date;

  const AddOrUpdateMealModal({Key? key, this.meal, this.date})
      : super(key: key);

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
    Meal meal = Meal(
        id: widget.meal?.id ?? 'id',
        date: widget.meal?.date ??
            widget.date ??
            dateToString(DateTime.now().toLocal()),
        name: nameController.text,
        calories: caloriesController.text.isEmpty
            ? 0.0
            : double.parse(caloriesController.text),
        weight: weightController.text.isEmpty
            ? 0.0
            : double.parse(weightController.text),
        portion: portionController.text);
    widget.meal == null
        ? BlocProvider.of<DatesBloc>(context).add(AddMealEvent(meal))
        : BlocProvider.of<DatesBloc>(context).add(UpdateMealEvent(meal));
    Navigator.of(context).pop();
  }

  void calculateCalories(BuildContext context) async {
    if (nameController.text.isNotEmpty) {
      try {
        double calories = await getCaloriesPerPortion(
            portionController.text, nameController.text);
        caloriesController.text = calories.toString();
      } catch (e) {
        print(e);
      }
    }
  }

  Widget generateCustomInput(
      {required TextEditingController controller,
      required String hint,
      String suffix = ''}) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 2, color: Colors.blueGrey.shade600)),
      ),
      child: TextField(
        onChanged: (_) {
          setState(() {});
        },
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.orange.shade600,
          labelText: hint,
          suffixText: suffix,
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
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
            generateCustomInput(
                controller: weightController, hint: 'Weight', suffix: 'g'),
            Row(
              children: [
                Expanded(
                  child: generateCustomInput(
                      controller: caloriesController,
                      hint: 'Calories',
                      suffix: 'kcal'),
                ),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: nameController.text.isEmpty ? 0 : 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                        tooltip: 'Calculate',
                        onPressed: () => calculateCalories(context),
                        icon: const Icon(Icons.calculate_outlined)))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: addMeal,
                  child: const Text(
                    'Save',
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
