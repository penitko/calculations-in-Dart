/*
App:
Sovellus laskee 1 hengen ruokakunnan eläkkeensaajan
asumistuen vuosille 2024 ja 2025 vakioillaan ja kertoimillaan
ottaen huomioon korottoman saaston vaikutuksen pankkitililtä.

Vuoden 2025 vakiot ja kertoimet eivät välttämättä ole
vielä paikaansa pitävät. Eduskunta nuijii uuden eläkkeensaajan
asumistuen voimaan joulukuun 2024 aikana. 

Name:
elsaajan_asumistukilaskuri.dart

Compile and run:
dart elsaajan_asumistukilaskuri.dart
*/

void laske_asumistuki
  (
    var _saasto, var _elakkeet, var _tulo_raja, var _var_raja, 
    var _perusomavastuu_per_kk, var _vuokra, var _vesi, var str_vuodelle,
    var _vuositulokerroin, var _lisaomavastuukerroin, var _astukikerroin
  )
{

  // Lasketaan eläkkeensaajan asumistuki
  var saasto = _saasto;
  print("saasto $str_vuodelle = $saasto");

  // saastosta voidaan vähennetään 2000€ vuosina 2024 ja 2025
  saasto -= 2000.0;

  // kaikki bruttoeläkkeet summattuina
  var elakkeet = _elakkeet;
  print("elakkeet = ${double.parse((elakkeet).toStringAsFixed(2))}");
  
  // varallisuusraja 
  var var_raja = _var_raja; // vuonna 2024 18306.0 - 2025 15000

  var vuositulo = (elakkeet * 12.0) + (saasto - var_raja) * _vuositulokerroin; // vuonna 2024 0.08 
  var kk_tulo = vuositulo / 12.0; // 12 kk

  // Kelan kielessa tulo_raja on lisäomavastuun tuloraja
  var tulo_raja = _tulo_raja; // v 2024 10280.0 - v 2025?
  var perusomavastuu_per_kk = _perusomavastuu_per_kk;   //v 2024 56.78
  var lisaomavastuu_per_v = 0.0;      // lasketaan
  var lisaomavastuu_per_kk = 0.0;     // lasketaan

  // Lisäomavastuu maaraytyy mikäli laskennallinen vuositulo ylittää
  // 10280 rajan vuonna 2024 -mikä on tuo luku vuodelle 2025.
  if ( (vuositulo - tulo_raja) > 0.0 ) {
    lisaomavastuu_per_v = (vuositulo - tulo_raja) * _lisaomavastuukerroin; // v 2024 0.413; // prosenttiluku loytyy laista
    lisaomavastuu_per_kk = lisaomavastuu_per_v / 12.0;
  }

  //asumistuki = ( (vuokra + vesi) - (perusomavastuu_per_kk + lisaomavastuu_per_kk)) * 0.85
  var astuki_per_kk = ((_vuokra + _vesi) - (perusomavastuu_per_kk + lisaomavastuu_per_kk)) * _astukikerroin; // v 2024 0.85;

  // pyoristys 2:een desimaaliin - hiukan oudosti tehdaan dartissa!
  print("Eläkkeensaajan asumistuki $str_vuodelle");
  print(double.parse((astuki_per_kk).toStringAsFixed(2)));
  //print(""); // empty line
}

void main() {
  // tuottamattoman varallisuuden vaikutus n. 1076 $ bruttoeläkkeellä
  // vuotena 2024 eläkkeensaajan asumistuessa yhden henkilön ruokakunnassa.
  for (var saasto = 5000.0; saasto < 95000; saasto += 5000) {
    laske_asumistuki
    (
      saasto, 1076.0, 10280.0, 18306.0,
      56.78, 512.0, 20.0, "2024",
      0.08, 0.413, 0.85
    );
  }
  // huomaa muuuttuneet vakiot ja kertoimet vuodesta 2024.
  for (var saasto = 5000.0; saasto < 95000; saasto += 5000) {
    laske_asumistuki
    (
      saasto, 1091, 10280.0, 15000.0,
      56.78, 512.0, 20.0, "2025",
      0.15, 0.435, 0.85
    );
  }


print("*************Kelan Paavo******************");

    laske_asumistuki
    (
      21000.0, 1710.0, 10280.0, 15000.0,
      56.78, 600.0, 0.0, "2025",
      0.15, 0.435, 0.85
    );


}



