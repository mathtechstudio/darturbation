import 'package:darturbation/darturbation.dart';

void main() {
  // --- Schema Intelligence ---
  print('--- Generating Data from a Custom Schema ---');
  final customSchema = {
    'id': int,
    'first_name': String,
    'last_name': String,
    'email_address': String,
    'is_active': bool,
    'balance': double,
  };

  final generatedData = Darturbation.fromSchema(schema: customSchema, count: 3);

  print('Schema: $customSchema');
  print('\nGenerated Data:');
  generatedData.forEach(print);
}
