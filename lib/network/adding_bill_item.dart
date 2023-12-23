import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../model/person_data.dart';

class AddingBillItemPage extends StatefulWidget {
  final String? initialAmount;
  final String? initialDate;
  final String? initialClassification;

  const AddingBillItemPage({
    Key? key,
    this.initialAmount,
    this.initialDate,
    this.initialClassification,
  }) : super(key: key);
  @override
  _AddingBillItemPageState createState() => _AddingBillItemPageState();
}

class _AddingBillItemPageState extends State<AddingBillItemPage> {
  final myBaby = GetIt.instance<PersonData>();

  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController classificationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Here, we are fixing the initial values if they're provided
    amountController.text = widget.initialAmount ?? '';
    dateController.text = widget.initialDate ?? '';
    classificationController.text = widget.initialClassification ?? '';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bill Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              controller: amountController,
              label: 'Amount',
              prefixText: '₹',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              controller: dateController,
              label: 'Date (dd/mm/yyyy)',
              hintText: 'e.g., 01/12/2023',
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              controller: classificationController,
              label: 'Classification',
              hintText: 'e.g., Food, Travel, Health, Home, Others',
            ),
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context); // Cancel button
                  },
                ),
                _buildButton(
                  text: 'Save',
                  onPressed: () {
                    // TODO: Implement save logic
                    // Example: myBaby.addExpense(Expense(DateTime(...), amount, 0, classificationController.text));
                    Navigator.pop(context); // Save button
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    String? prefixText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixText: prefixText,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.black, width: 2.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
