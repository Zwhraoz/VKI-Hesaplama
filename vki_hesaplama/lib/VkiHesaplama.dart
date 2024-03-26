import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vücut Kitle Endeksi Hesaplama',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Color.fromARGB(255, 32, 31, 31)),
        useMaterial3: true,
      ),
      home: const VkiHesaplama(title: ''),
    );
  }
}

class VkiHesaplama extends StatefulWidget {
  const VkiHesaplama({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<VkiHesaplama> createState() => _VkiHesaplamaState();
}

class _VkiHesaplamaState extends State<VkiHesaplama> {
  double _boy = 170; // Varsayılan boy değeri
  int _kilo = 60; // Varsayılan kilo değeri
  int _yas = 18; // Varsayılan yaş değeri
  bool _isFemaleSelected = false; // Kız cinsiyeti seçili mi?
  bool _isMaleSelected = false; // Erkek cinsiyeti seçili mi?

  double _calculateBMI() {
    // BMI hesaplama formülü: kilo / (boy * boy) * 10.000
    return _kilo / ((_boy / 100) * (_boy / 100));
  }

  String _evaluateBMI(double bmi) {
  if (bmi < 18.5) {
    return "Zayıf";
  } else if (bmi >= 18.5 && bmi < 24.9) {
    return "Normal";
  } else if (bmi >= 25 && bmi < 29.9) {
    return "Fazla Kilolu";
  } else {
    return "Obez";
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Vücut Kitle Endeksi Hesaplama',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGenderButton(Icons.female, "Kız", _isFemaleSelected),
                _buildGenderButton(Icons.male, "Erkek", _isMaleSelected),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 325,
                  height: 100,
                  color: Color.fromARGB(255, 48, 48, 48),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Boy",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Slider(
                              value: _boy,
                              thumbColor: Color.fromARGB(255, 31, 245, 56),
                              activeColor: Color.fromARGB(255, 78, 75, 75),
                              inactiveColor: Color.fromARGB(255, 0, 0, 0),
                              min: 50,
                              max: 200,
                              onChanged: (value) {
                                setState(() {
                                  _boy = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "${_boy.toInt()} cm",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoCard("Kilo", Icons.accessibility, _kilo),
                  _buildInfoCard("Yaş", Icons.cake, _yas),
                ],
              ),
            ),
    ElevatedButton(
  onPressed: () {
    double bmi = _calculateBMI();
    String result = bmi.toStringAsFixed(2);
    String evaluation = _evaluateBMI(bmi);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          "Vücut Kitle Endeksi (BMI)",
          style: TextStyle(color: Colors.green),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "BMI: $result",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Durum: $evaluation",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Kapat",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  },
  child: const Text(
    "Hesapla",
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  ),
  style: ElevatedButton.styleFrom(
    minimumSize: Size(200, 70),
    foregroundColor: Color.fromARGB(255, 0, 0, 0),
    backgroundColor: Color.fromARGB(255, 31, 245, 56),
  ),
),

          ],
        ),
      ),
    );
  }

  Widget _buildGenderButton(IconData icon, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFemaleSelected = label == "Kız";
          _isMaleSelected = label == "Erkek";
        });
      },
      child: Container(
        width: 160,
        height: 170,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 133, 130, 130)
              : Color.fromARGB(255, 48, 48, 48),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child:
                  Icon(icon, size: 60, color: Color.fromARGB(255, 31, 245, 56)),
            ),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, IconData icon, dynamic value) {
    return SizedBox(
      width: 160,
      child: Card(
        color: Color.fromARGB(255, 48, 48, 48),
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (title == "Kilo") {
                          _kilo--;
                        } else if (title == "Yaş") {
                          _yas--;
                        } else if (title == "Boy") {
                          _boy -= 5; // Boyu azaltmak için 5 değerini çıkar
                        }
                      });
                    },
                    icon: Icon(Icons.remove,
                        color: Color.fromARGB(255, 31, 245, 56)),
                  ),
                  Text(
                    "$value",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (title == "Kilo") {
                          _kilo++;
                        } else if (title == "Yaş") {
                          _yas++;
                        } else if (title == "Boy") {
                          _boy += 5; // Boyu artırmak için 5 değerini ekle
                        }
                      });
                    },
                    icon: Icon(Icons.add,
                        color: Color.fromARGB(255, 31, 245, 56)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
