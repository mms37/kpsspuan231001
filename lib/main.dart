import 'package:flutter/material.dart';

void main() {
  runApp(KPSSCalculatorApp());
}

class KPSSCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.indigoAccent),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 500), // Geçiş süresini ayarlayabilirsiniz
        curve: Curves.easeInOut, // Geçiş eğrisini ayarlayabilirsiniz
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'Ana Sayfa' : 'Puanlar',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: BouncingScrollPhysics(), // Yumuşak geçiş için fiziksel özellikler ekledik
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          AnaSayfa(),
          PuanlarSayfasi(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Puanlar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Diğer kodlar buraya gelecek...


// Diğer kodlar buraya gelecek...



class AnaSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildCard(
            context,
            'KPSS Lisans Puan Hesaplama',
            'Lisans düzeyinde KPSS puanınızı hesaplamak için tıklayın.',
            KPSSLisansCalculator(),
          ),
          const SizedBox(height: 20),
          buildCard(
            context,
            'KPSS Önlisans Puan Hesaplama',
            'Önlisans düzeyinde KPSS puanınızı hesaplamak için tıklayın.',
            KPSSOnLisansCalculator(),
          ),
          const SizedBox(height: 20),
          buildCard(
            context,
            'KPSS Ortaöğretim Puan Hesaplama',
            'Ortaöğretim düzeyinde KPSS puanınızı hesaplamak için tıklayın.',
            KPSSOrtaogretimCalculator(),
          ),
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context, String title, String description, Widget page) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PuanlarSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'En Son Hesaplanan Puanlar:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildPuanCard(
                  context,
                  'KPSS Lisans Puanı',
                  KPSSData.lisansPuan,
                ),
                buildPuanCard(
                  context,
                  'KPSS Önlisans Puanı',
                  KPSSData.onLisansPuan,
                ),
                buildPuanCard(
                  context,
                  'KPSS Ortaöğretim Puanı',
                  KPSSData.ortaogretimPuan,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPuanCard(BuildContext context, String title, double? puan) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          'Puan: ${puan?.toStringAsFixed(2) ?? 'Hesaplanmadı'}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

  Widget buildPuanCard(BuildContext context, String title, double? puan) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          'Puan: ${puan?.toStringAsFixed(2) ?? 'Hesaplanmadı'}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }



class KPSSData {
  static double? lisansPuan;
  static double? onLisansPuan;
  static double? ortaogretimPuan;
}
class KPSSLisansCalculator extends StatefulWidget {
  @override
  _KPSSLisansCalculatorState createState() => _KPSSLisansCalculatorState();
}

class _KPSSLisansCalculatorState extends State<KPSSLisansCalculator> {
  TextEditingController genelKulturDogruController = TextEditingController();
  TextEditingController genelKulturYanlisController = TextEditingController();
  TextEditingController genelYetenekDogruController = TextEditingController();
  TextEditingController genelYetenekYanlisController = TextEditingController();
  double? kpssPuan;
  bool showError = false; // Hata durumunu takip etmek için bir değişken ekledik

  void calculateKPSS() {
    setState(() {
      // Kullanıcıdan alınan değerleri integer'a çeviriyoruz
      int genelKulturDogru = int.tryParse(genelKulturDogruController.text) ?? 0;
      int genelKulturYanlis = int.tryParse(genelKulturYanlisController.text) ?? 0;
      int genelYetenekDogru = int.tryParse(genelYetenekDogruController.text) ?? 0;
      int genelYetenekYanlis = int.tryParse(genelYetenekYanlisController.text) ?? 0;

      // Genel Kültür ve Genel Yetenek netleri 0 ile 60 arasında olmalıdır.
      if (genelKulturDogru < 0 || genelKulturDogru > 60 ||
          genelYetenekDogru < 0 || genelYetenekDogru > 60) {
        showError = true;
        kpssPuan = null; // Geçersiz değer girildiğinde puanı null yap
      } else {
        showError = false; // Geçerli değer girildiğinde hatayı kapat
        // Netleri hesaplıyoruz
        double genelKulturNet = genelKulturDogru - (genelKulturYanlis * 0.25);
        double genelYetenekNet = genelYetenekDogru - (genelYetenekYanlis * 0.25);

        // KPSS puan hesaplama formülüne göre puanı hesaplıyoruz
        kpssPuan = 40 + (genelKulturNet * 0.48) + (genelYetenekNet * 0.52);

        // Puanı negatifse sıfıra ayarlıyoruz
        if (kpssPuan! < 0) {
          kpssPuan = 0;
        }
      }

      // KPSS puanını KPSSData sınıfına atıyoruz
      KPSSData.lisansPuan = kpssPuan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KPSS Lisans Puan Hesaplama',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Genel Kültür',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: genelKulturDogruController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Doğru Sayısı',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: genelKulturYanlisController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Yanlış Sayısı',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Genel Yetenek',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: genelYetenekDogruController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Doğru Sayısı',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: genelYetenekYanlisController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Yanlış Sayısı',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateKPSS();
              },
              child: const Text(
                'Puanı Hesapla',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (showError)
              Text(
                'Geçersiz değer girdiniz. Genel Kültür ve Genel Yetenek netleri 0 ile 60 arasında olmalıdır.',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            if (kpssPuan != null)
              Text(
                'KPSS Puanınız: ${kpssPuan?.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
class KPSSOnLisansCalculator extends StatefulWidget {
  @override
  _KPSSOnLisansCalculatorState createState() => _KPSSOnLisansCalculatorState();
}

class _KPSSOnLisansCalculatorState extends State<KPSSOnLisansCalculator> {
  TextEditingController genelKulturDogruController = TextEditingController();
  TextEditingController genelKulturYanlisController = TextEditingController();
  TextEditingController genelYetenekDogruController = TextEditingController();
  TextEditingController genelYetenekYanlisController = TextEditingController();
  double? kpssPuan;
  bool showError = false;

  void calculateKPSS() {
    setState(() {
      int genelKulturDogru = int.tryParse(genelKulturDogruController.text) ?? 0;
      int genelKulturYanlis = int.tryParse(genelKulturYanlisController.text) ?? 0;
      int genelYetenekDogru = int.tryParse(genelYetenekDogruController.text) ?? 0;
      int genelYetenekYanlis = int.tryParse(genelYetenekYanlisController.text) ?? 0;

      if (genelKulturDogru < 0 || genelKulturDogru > 60 ||
          genelYetenekDogru < 0 || genelYetenekDogru > 60) {
        showError = true;
        kpssPuan = null;
      } else {
        showError = false;
        double genelKulturNet = genelKulturDogru - (genelKulturYanlis * 0.25);
        double genelYetenekNet = genelYetenekDogru - (genelYetenekYanlis * 0.25);

        kpssPuan = 40 + (genelKulturNet * 0.53) + (genelYetenekNet * 0.47);

        if (kpssPuan! < 0) {
          kpssPuan = 0;
        }
      }

      KPSSData.onLisansPuan = kpssPuan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KPSS ÖnLisans Puan Hesaplama',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Genel Kültür',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: genelKulturDogruController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Doğru Sayısı',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: genelKulturYanlisController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Yanlış Sayısı',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Genel Yetenek',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: genelYetenekDogruController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Doğru Sayısı',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: genelYetenekYanlisController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Yanlış Sayısı',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateKPSS();
              },
              child: const Text(
                'Puanı Hesapla',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (showError)
              Text(
                'Geçersiz değer girdiniz. Genel Kültür ve Genel Yetenek netleri 0 ile 60 arasında olmalıdır.',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            if (kpssPuan != null)
              Text(
                'KPSS Puanınız: ${kpssPuan?.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

class KPSSOrtaogretimCalculator extends StatefulWidget {
  @override
  _KPSSOrtaogretimCalculatorState createState() =>
      _KPSSOrtaogretimCalculatorState();
}

class _KPSSOrtaogretimCalculatorState
    extends State<KPSSOrtaogretimCalculator> {
  TextEditingController genelKulturDogruController = TextEditingController();
  TextEditingController genelKulturYanlisController = TextEditingController();
  TextEditingController genelYetenekDogruController = TextEditingController();
  TextEditingController genelYetenekYanlisController = TextEditingController();
  double? kpssPuan;
  bool showError = false;

  void calculateKPSS() {
    setState(() {
      int genelKulturDogru =
          int.tryParse(genelKulturDogruController.text) ?? 0;
      int genelKulturYanlis =
          int.tryParse(genelKulturYanlisController.text) ?? 0;
      int genelYetenekDogru =
          int.tryParse(genelYetenekDogruController.text) ?? 0;
      int genelYetenekYanlis =
          int.tryParse(genelYetenekYanlisController.text) ?? 0;

      if (genelKulturDogru < 0 ||
          genelKulturDogru > 60 ||
          genelYetenekDogru < 0 ||
          genelYetenekDogru > 60) {
        showError = true;
        kpssPuan = null;
      } else {
        showError = false;
        double genelKulturNet = genelKulturDogru - (genelKulturYanlis * 0.25);
        double genelYetenekNet = genelYetenekDogru - (genelYetenekYanlis * 0.25);

        kpssPuan = 40 + (genelKulturNet * 0.45) + (genelYetenekNet * 0.55);

        if (kpssPuan! < 0) {
          kpssPuan = 0;
        }
      }

      KPSSData.ortaogretimPuan = kpssPuan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KPSS Ortaöğretim Puan Hesaplama',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Genel Kültür',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: genelKulturDogruController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Doğru Sayısı',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: genelKulturYanlisController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Yanlış Sayısı',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Genel Yetenek',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: genelYetenekDogruController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Doğru Sayısı',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: genelYetenekYanlisController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Yanlış Sayısı',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateKPSS();
              },
              child: const Text(
                'Puanı Hesapla',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (showError)
              Text(
                'Geçersiz değer girdiniz. Genel Kültür ve Genel Yetenek netleri 0 ile 60 arasında olmalıdır.',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            if (kpssPuan != null)
              Text(
                'KPSS Puanınız: ${kpssPuan?.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
