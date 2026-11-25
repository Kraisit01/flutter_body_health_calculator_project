// เริ่มตั้งแต่บรรทัดที่ 1 ถึงบรรทัดสุดท้ายของไฟล์ lib/views/home_ui.dart
import 'package:flutter/material.dart';
import 'about_ui.dart';
import 'bmi_ui.dart';
import 'bmr_ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int _currentIndex = 1;

  late final List<Widget> _pages = [
    const BmiUI(),
    _HomeDashboardBody(
      onSelectTab: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    ),
    const BmrUI(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Body Health Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            tooltip: 'เกี่ยวกับแอป',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUI()),
              );
            },
            icon: const Icon(Icons.info_outline, color: Colors.white),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight_outlined),
            label: 'BMI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'BMR',
          ),
        ],
      ),
    );
  }
}

class _HomeDashboardBody extends StatelessWidget {
  final ValueChanged<int> onSelectTab;

  const _HomeDashboardBody({required this.onSelectTab});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ยินดีต้อนรับสู่ Body ว้าว',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => onSelectTab(0),
                child: const Text('คำนวณค่าดัชนีมวลกาย (BMI)'),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => onSelectTab(2),
                child: const Text('คำนวณอัตราการเผาผลาญ (BMR)'),
              ),
            ),
            const SizedBox(height: 14),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUI()),
                );
              },
              child: const Text('เกี่ยวกับผู้พัฒนา / แอปพลิเคชัน'),
            ),
          ],
        ),
      ),
    );
  }
}