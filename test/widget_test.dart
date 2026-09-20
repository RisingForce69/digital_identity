import 'package:flutter_test/flutter_test.dart';
import 'package:digital_identity/main.dart';

void main() {
  testWidgets('Memastikan aplikasi profil berjalan', (WidgetTester tester) async {
    // Menjalankan aplikasi buatanmu
    await tester.pumpWidget(const DigitalIdentityApp());

    // Mengecek apakah nama kamu muncul di layar
    expect(find.text('Judson Phangestu'), findsOneWidget);
  });
}