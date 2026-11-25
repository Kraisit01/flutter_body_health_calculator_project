// เริ่มตั้งแต่บรรทัดที่ 1 ถึงบรรทัดสุดท้ายของไฟล์ lib/views/bmi_ui.dart
import 'package:flutter/material.dart';

class BmiUI extends StatefulWidget {
  const BmiUI({super.key});

  @override
  State<BmiUI> createState() => _BmiUIState();
}

class _BmiUIState extends State<BmiUI> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double? _bmiResult;
  String _interpretation = '-';

  String _interpretBmi(double bmi) {
    if (bmi < 18.5) return 'น้ำหนักต่ำกว่าเกณฑ์';
    if (bmi <= 22.9) return 'น้ำหนักสมส่วน';
    if (bmi <= 24.9) return 'น้ำหนักเกิน';
    if (bmi <= 29.9) return 'โรคอ้วนระดับ 1';
    return 'โรคอ้วนระดับ 2 หรืออ้วนมาก';
  }

  void _calculateBmi() {
    final double? weight = double.tryParse(_weightController.text.trim());
    final double? heightCm = double.tryParse(_heightController.text.trim());

    if (weight == null || heightCm == null || weight <= 0 || heightCm <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกน้ำหนักและส่วนสูงให้ถูกต้อง')),
      );
      return;
    }

    final double heightM = heightCm / 100.0;
    final double bmi = weight / (heightM * heightM);

    setState(() {
      _bmiResult = bmi;
      _interpretation = _interpretBmi(bmi);
    });
  }

  void _clearFields() {
    _weightController.clear();
    _heightController.clear();
    setState(() {
      _bmiResult = null;
      _interpretation = '-';
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'คำนวณหาค่าดัชนีมวลกาย (BMI)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Icon(Icons.speed, size: 72, color: Colors.deepOrange),
          const SizedBox(height: 20),
          const Text('น้ำหนักตัว (กิโลกรัม)'),
          const SizedBox(height: 6),
          TextField(
            controller: _weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              hintText: 'กรอกน้ำหนักของคุณ',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('ส่วนสูง (เซนติเมตร)'),
          const SizedBox(height: 6),
          TextField(
            controller: _heightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              hintText: 'กรอกส่วนสูงของคุณ',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              onPressed: _calculateBmi,
              child: const Text('คำนวณ BMI'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.black87,
              ),
              onPressed: _clearFields,
              child: const Text('ล้างข้อมูล'),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text(
                  'BMI',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  _bmiResult == null ? '0.00' : _bmiResult!.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _interpretation,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}