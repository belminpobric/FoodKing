import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodKingDateTimePicker extends StatelessWidget {
  final DateTime? value;
  final String labelText;
  final void Function(DateTime?)? onChanged;
  final bool showTime;

  const FoodKingDateTimePicker({
    super.key,
    required this.value,
    required this.labelText,
    required this.onChanged,
    this.showTime = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null && showTime) {
          final pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(value ?? DateTime.now()),
          );
          if (pickedTime != null) {
            pickedDate = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          }
        }
        if (pickedDate != null) {
          onChanged?.call(pickedDate);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.deepOrange),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          controller: TextEditingController(
            text: value == null
                ? ''
                : showTime
                    ? DateFormat('dd.MM.yyyy HH:mm').format(value!)
                    : DateFormat('dd.MM.yyyy').format(value!),
          ),
        ),
      ),
    );
  }
}
