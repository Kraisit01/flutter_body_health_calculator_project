// เริ่มตั้งแต่บรรทัดที่ 1 ถึงบรรทัดสุดท้ายของไฟล์ lib/views/bmr_ui.dart
import 'package:flutter/material.dart';

class BmrUI extends StatefulWidget {
  const BmrUI({super.key});

  @override
  State<BmrUI> createState() => _BmrUIState();
}

class _BmrUIState extends State<BmrUI> {
  String _gender = 'male'; // 'male' หรือ 'female'
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  double? _bmrResult;

  void _calculateBmr() {
    final double? weight = double.tryParse(_weightController.text.trim());
    final double? height = double.tryParse(_heightController.text.trim());
    final double? age = double.tryParse(_ageController.text.trim());

    if (weight == null ||
        height == null ||
        age == null ||
        weight <= 0 ||
        height <= 0 ||
        age <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('กรุณากรอกข้อมูลน้ำหนัก ส่วนสูง และอายุให้ครบถ้วน')),
      );
      return;
    }

    final double base = (10 * weight) + (6.25 * height) - (5 * age);
    final double bmr = _gender == 'male' ? base + 5 : base - 161;

    setState(() {
      _bmrResult = bmr;
    });
  }

  void _clearFields() {
    _weightController.clear();
    _heightController.clear();
    _ageController.clear();
    setState(() {
      _bmrResult = null;
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
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
            'คำนวณหาอัตราการเผาผลาญพลังงานพื้นฐานของร่างกาย (BMR)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Icon(Icons.favorite, size: 68, color: Colors.deepOrange),
          const SizedBox(height: 16),
          const Text('เพศ'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _gender == 'male'
                        ? Colors.deepOrange
                        : Colors.grey.shade200,
                    foregroundColor:
                        _gender == 'male' ? Colors.white : Colors.black87,
                  ),
                  onPressed: () => setState(() => _gender = 'male'),
                  child: const Text('ชาย'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _gender == 'female'
                        ? Colors.deepOrange
                        : Colors.grey.shade200,
                    foregroundColor:
                        _gender == 'female' ? Colors.white : Colors.black87,
                  ),
                  onPressed: () => setState(() => _gender = 'female'),
                  child: const Text('หญิง'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
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
          const SizedBox(height: 14),
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
          const SizedBox(height: 14),
          const Text('อายุ (ปี)'),
          const SizedBox(height: 6),
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'กรอกอายุของคุณ',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              onPressed: _calculateBmr,
              child: const Text('คำนวณ BMR'),
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
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text(
                  'BMR',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  _bmrResult == null ? '0.00' : _bmrResult!.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
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