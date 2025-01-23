import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Задачи из 1-3 файлов',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskSelector(),
    );
  }
}

class TaskSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 18, // Количество задач
      child: Scaffold(
        appBar: AppBar(
          title: Text('Задачи'),
          bottom: TabBar(
            tabs: [
              // Tab(text: '№1.3 - Таблица умножения'), - без подсказки, просто вкладка
              Tooltip(message: '№1.3 - Таблица умножения', child: Tab(text: '№1.3')),
              Tooltip(message: '№1.6 - Простое число', child: Tab(text: '№1.6')),
              Tooltip(message: '№1.9 - Реверс строки', child: Tab(text: '№1.9')),
              Tooltip(message: '№1.12 - Сумма цифр', child: Tab(text: '№1.12')),
              Tooltip(message: '№1.15 - Сумма массива', child: Tab(text: '№1.15')),
              Tooltip(message: '№1.18 - Гласные и согласные', child: Tab(text: '№1.18')),
              Tooltip(message: '№2.3 - Конвертер строк в числа', child: Tab(text: '№2.3')),
              Tooltip(message: '№2.6 - Факториал', child: Tab(text: '№2.6')),
              Tooltip(message: '№2.9 - Обрезка строки', child: Tab(text: '№2.9')),
              Tooltip(message: '№2.12 - Проверка делимости', child: Tab(text: '№2.12')),
              Tooltip(message: '№2.15 - Проверка даты', child: Tab(text: '№2.15')),
              Tooltip(message: '№2.18 - Квадратный корень', child: Tab(text: '№2.18')),
              Tooltip(message: '№3.3 - Полиморфизм: Животные', child: Tab(text: '№3.3')),
              Tooltip(message: '№3.6 - Инкапсуляция: Банк', child: Tab(text: '№3.6')),
              Tooltip(message: '№3.9 - Наследование: Животные и их движения', child: Tab(text: '№3.9')),
              Tooltip(message: '№3.12 - Интерфейс "Платежная система"', child: Tab(text: '№3.12')),
              Tooltip(message: '№3.15 - Комплексные числа', child: Tab(text: '№3.15')),
              Tooltip(message: '№3.18 - Автоматизированная система заказов', child: Tab(text: '№3.18')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MultiplicationTable(),
            PrimeNumberCheck(),
            StringReversal(),
            DigitSum(),
            ArraySum(),
            VowelConsonantCount(),
            StringToIntConverter(),
            FactorialCalculator(),
            StringTrimmer(),
            DivisibilityChecker(),
            DateValidator(),
            SquareRootCalculator(),
            PolymorphismDemo(),
            EncapsulationDemo(),
            InheritanceDemo(),
            PaymentSystemDemo(),
            ComplexNumbersDemo(),
            OrderSystem(),
          ],
        ),
      ),
    );
  }
}

// 1.3: Таблица умножения
class MultiplicationTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        int multiplier = index + 1;
        int result = multiplier * 5;
        return ListTile(
          title: Text('5 * $multiplier = $result'),
        );
      },
    );
  }
}

// 1.6: Проверка простого числа
class PrimeNumberCheck extends StatefulWidget {
  @override
  _PrimeNumberCheckState createState() => _PrimeNumberCheckState();
}

class _PrimeNumberCheckState extends State<PrimeNumberCheck> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _checkPrime() {
    int? number = int.tryParse(_controller.text);
    if (number == null || number < 2) {
      setState(() => _result = 'Введите целое число больше 1.');
      return;
    }
    
    bool isPrime = true;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) {
        isPrime = false;
        break;
      }
    }
    
    setState(() => _result = isPrime ? '$number - это простое число' : '$number - это не простое число');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Введите целое число'),
            keyboardType: TextInputType.number,
          ),
        ),
        ElevatedButton(
          onPressed: _checkPrime,
          child: Text('Проверить'),
        ),
        SizedBox(height: 20),
        Text(_result),
      ],
    );
  }
}

// 1.9: Реверс строки
class StringReversal extends StatefulWidget {
  @override
  _StringReversalState createState() => _StringReversalState();
}

class _StringReversalState extends State<StringReversal> {
  final TextEditingController _controller = TextEditingController();
  String _reversedString = '';

  void _reverseString() {
    setState(() {
      _reversedString = _controller.text.split('').reversed.join('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Введите строку'),
          ),
        ),
        ElevatedButton(
          onPressed: _reverseString,
          child: Text('Реверсировать'),
        ),
        SizedBox(height: 20),
        Text('Обратная строка: $_reversedString'),
      ],
    );
  }
}

// 1.12: Сумма цифр числа
class DigitSum extends StatefulWidget {
  @override
  _DigitSumState createState() => _DigitSumState();
}

class _DigitSumState extends State<DigitSum> {
  final TextEditingController _controller = TextEditingController();
  int _sum = 0;

  void _calculateSum() {
    String input = _controller.text;
    int sum = input.split('').map(int.parse).reduce((a, b) => a + b);
    
    setState(() => _sum = sum);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Введите число'),
            keyboardType: TextInputType.number,
          ),
        ),
        ElevatedButton(
          onPressed: _calculateSum,
          child: Text('Посчитать сумму цифр'),
        ),
        SizedBox(height: 20),
        Text('Итоговая сумма цифр числа: $_sum'),
      ],
    );
  }
}

// 1.15: Сумма всех элементов массива
class ArraySum extends StatefulWidget {
  @override
  _ArraySumState createState() => _ArraySumState();
}

class _ArraySumState extends State<ArraySum> {
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _elementsController = TextEditingController();
  
  int _totalSum = 0;
  String _errorMessage = '';

  void _calculateArraySum() {
    // Получаем размер массива из текстового поля
    int? size = int.tryParse(_sizeController.text);
    if (size == null || size <= 0) {
      setState(() {
        _errorMessage = 'Введите корректный размер массива.';
        _totalSum = 0; // Сбрасываем сумму
      });
      return;
    }

    // Получаем элементы массива
    List<String> elements = _elementsController.text.split(',');
    
    // Проверяем, совпадает ли количество элементов с указанным размером
    if (elements.length != size) {
      setState(() {
        _errorMessage = 'Количество элементов не совпадает с размером массива.';
        _totalSum = 0; // Сбрасываем сумму
      });
      return;
    }

    // Пробуем преобразовать элементы в целые числа и вычислить сумму
    try {
      int sum = elements.map(int.parse).reduce((a, b) => a + b);
      setState(() {
        _totalSum = sum;
        _errorMessage = ''; // Сбрасываем сообщение об ошибке
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ошибка: убедитесь, что все элементы - целые числа.';
        _totalSum = 0; // Сбрасываем сумму
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _sizeController,
            decoration:
                InputDecoration(labelText: 'Введите размер массива'),
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _elementsController,
            decoration:
                InputDecoration(labelText:
                    'Введите элементы массива через запятую (например, "1,2,3")'),
          ),
        ),
        ElevatedButton(
          onPressed: _calculateArraySum,
          child: Text('Посчитать сумму массива'),
        ),
        SizedBox(height: 20),
        if (_errorMessage.isNotEmpty)
          Text(
            _errorMessage,
            style: TextStyle(color: Colors.red),
          ),
        Text('Сумма элементов массива $_totalSum'),
      ],
    );
  }
}


// 1.18 : Подсчет гласных и согласных в строке
class VowelConsonantCount extends StatefulWidget {
   @override
   _VowelConsonantCountState createState() => _VowelConsonantCountState();
}

class _VowelConsonantCountState extends State<VowelConsonantCount> {
   final TextEditingController _controller = TextEditingController();
   int vowelCount = 0;
   int consonantCount = 0;

   void countLetters() {
     String input = _controller.text.toLowerCase();
     vowelCount = input.split('').where((c) => 'aeiou'.contains(c)).length;
     consonantCount =
         input.split('').where((c) => RegExp(r'[bcdfghjklmnpqrstvwxyz]').hasMatch(c)).length;

     setState(() {});
   }

   @override
   Widget build(BuildContext context) {
     return Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Padding(
           padding:
               const EdgeInsets.all(16.0),
           child:
               TextField(controller:
                   _controller,
                   decoration:
                   InputDecoration(labelText:
                       'Введите строку')),
         ),
         ElevatedButton(onPressed:
             countLetters, child:
             Text('Подсчитать')),
         SizedBox(height:
             20),
         Text('Гласные буквы: $vowelCount\nСогласные буквы: $consonantCount')
       ],
     );
   }
}



// 2.3: Конвертер строк в числа
class StringToIntConverter extends StatefulWidget {
  @override
  _StringToIntConverterState createState() => _StringToIntConverterState();
}

class _StringToIntConverterState extends State<StringToIntConverter> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _convertStringToInt() {
    try {
      int number = NumberFormat().parse(_controller.text).toInt();
      setState(() => _result = 'Результат: $number');
    } catch (e) {
      setState(() => _result = 'Ошибка: не удалось конвертировать строку в число.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Введите строку для конвертации'),
          ),
        ),
        ElevatedButton(
          onPressed: _convertStringToInt,
          child: Text('Конвертировать'),
        ),
        SizedBox(height: 20),
        Text(_result),
      ],
    );
  }
}

// 2.6: Факториал
class FactorialCalculator extends StatefulWidget {
  @override
  _FactorialCalculatorState createState() => _FactorialCalculatorState();
}

class _FactorialCalculatorState extends State<FactorialCalculator> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _calculateFactorial() {
    int? number = int.tryParse(_controller.text);
    if (number == null || number < 0) {
      setState(() => _result = 'Ошибка: введите неотрицательное целое число.');
      return;
    }

    int factorial = _factorial(number);
    setState(() => _result = 'Факториал $number! = $factorial');
  }

  int _factorial(int n) {
    return n == 0 ? 1 : n * _factorial(n - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Введите число для факториала'),
            keyboardType: TextInputType.number,
          ),
        ),
        ElevatedButton(
          onPressed: _calculateFactorial,
          child: Text('Посчитать факториал'),
        ),
        SizedBox(height: 20),
        Text(_result),
      ],
    );
  }
}

// 2.9: Обрезка строки
class StringTrimmer extends StatefulWidget {
  @override
  _StringTrimmerState createState() => _StringTrimmerState();
}

class _StringTrimmerState extends State<StringTrimmer> {
  final TextEditingController _stringController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  String _result = '';

  void _trimString() {
    String inputString = _stringController.text;
    int? length = int.tryParse(_lengthController.text);

    if (length == null || length > inputString.length) {
      setState(() => _result = 'Ошибка: длина больше длины строки.');
      return;
    }

    setState(() => _result = 'Обрезанная строка: ${inputString.substring(0, length)}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              TextField(controller: _stringController, decoration:
                  InputDecoration(labelText:
                      'Введите строку')),
        ),
        Padding(
          padding:
              const EdgeInsets.all(16.0),
          child:
              TextField(controller:
                  _lengthController,
                  decoration:
                  InputDecoration(labelText:
                      'Введите длину для обрезки'),
                  keyboardType:
                      TextInputType.number),
        ),
        ElevatedButton(onPressed:
            () {_trimString();},
            child:
            Text('Обрезать строку')),
        SizedBox(height:
            20),
        Text(_result),
      ],
    );
  }
}

// 2.12 : Проверка делимости
class DivisibilityChecker extends StatefulWidget {
   @override
   _DivisibilityCheckerState createState() => _DivisibilityCheckerState();
}

class _DivisibilityCheckerState extends State<DivisibilityChecker> {
   final TextEditingController _num1Controller = TextEditingController();
   final TextEditingController _num2Controller = TextEditingController();
   String _result = '';

   void checkDivisibility() {
     int? num1 = int.tryParse(_num1Controller.text);
     int? num2 = int.tryParse(_num2Controller.text);

     if (num2 == null || num2 == 0) {
       setState(() => _result = 'Ошибка: деление на ноль.');
       return;
     }

     if (num1 != null && num1 % num2 == 0) {
       setState(() => _result = '$num1 делится на $num2.');
     } else {
       setState(() => _result = '$num1 не делится на $num2.');
     }
   }

   @override
   Widget build(BuildContext context) {
     return Column(
       mainAxisAlignment:
           MainAxisAlignment.center,
       children:
           [
             Padding(padding:
                 const EdgeInsets.all(16.0),
                 child:
                 TextField(controller:
                     _num1Controller,
                     decoration:
                     InputDecoration(labelText:
                         'Введите первое число')),
             ),
             Padding(padding:
                 const EdgeInsets.all(16.0),
                 child:
                 TextField(controller:
                     _num2Controller,
                     decoration:
                     InputDecoration(labelText:
                         'Введите второе число')),
             ),
             ElevatedButton(onPressed:
                 checkDivisibility,
                 child:
                 Text('Проверить делимость')),
             SizedBox(height:
                 20),
             Text(_result)
           ],
     );
   }
}

// 2.15 : Проверка даты
class DateValidator extends StatefulWidget {
   @override
   _DateValidatorState createState() => _DateValidatorState();
}

class _DateValidatorState extends State<DateValidator> {
   final TextEditingController _controller = TextEditingController();
   String? result;

   void validateDate() {
     String inputDate = _controller.text;
     try {
       DateTime.parse(inputDate);
       if (RegExp(r'^\d{2}\.\d{2}\.\d{4}$').hasMatch(inputDate)) {
         setState(() => result =
             '$inputDate - корректная дата в формате dd.MM.yyyy');
       } else {
         throw FormatException();
       }
     } catch (e) {
       setState(() => result =
           '$inputDate - некорректная дата. Формат должен быть dd.MM.yyyy');
     }
   }

   @override
   Widget build(BuildContext context) {
     return Column(
       mainAxisAlignment:
           MainAxisAlignment.center,
       children:
           [
             Padding(padding:
                 const EdgeInsets.all(16.0),
                 child:
                 TextField(controller:
                     _controller,
                     decoration:
                     InputDecoration(labelText:
                         'Введите дату в формате dd.MM.yyyy')),
             ),
             ElevatedButton(onPressed:
                 validateDate,
                 child:
                 Text('Проверить дату')),
             SizedBox(height:
                 20),
             if (result != null)
               Text(result!)
           ],
     );
   }
}

// 2.18 : Квадратный корень
class SquareRootCalculator extends StatefulWidget {
   @override
   _SquareRootCalculatorState createState() => _SquareRootCalculatorState();
}

class _SquareRootCalculatorState extends State<SquareRootCalculator> {
   final TextEditingController controller =
       TextEditingController();
   double? result;

   void calculateSquareRoot() {
     double? number =
         double.tryParse(controller.text);
     if (number == null || number < 0) {
       setState(() =>
           result =
               null); // Установка результата в null при ошибке.
       return;
     }

     setState(() =>
         result = sqrt(number)); // Вычисление квадратного корня.
   }

   @override
   Widget build(BuildContext context) {
     return Column(
       mainAxisAlignment:
           MainAxisAlignment.center,
       children:[
         Padding(padding:
             const EdgeInsets.all(16.0),
             child:
             TextField(controller:
                 controller,
                 decoration:
                 InputDecoration(labelText:'Введите число для квадратного корня'),
                 keyboardType:
                     TextInputType.number)),
         ElevatedButton(onPressed :
             calculateSquareRoot,
             child :
             Text('Вычислить квадратный корень')),
         SizedBox(height :
             20),
         if (result != null)
           Text('Квадратный корень равен $result')
         else
           Container()
       ],
     );
   }
}

// 3.3 : Полиморфизм
// Полиморфизм
abstract class Animal {
  void makeSound();
}

class Dog implements Animal {
  @override
  void makeSound() {
    // Вместо print используем виджет для отображения
    print("Гав!");
  }
}

class Cat implements Animal {
  @override
  void makeSound() {
    print("Мяу!");
  }
}

class Cow implements Animal {
  @override
  void makeSound() {
    print("Му!");
  }
}

class PolymorphismDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Animal> animals = [Dog(), Cat(), Cow()];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: animals.map((animal) {
        animal.makeSound(); // Вызов метода makeSound()
        return Text(animal.runtimeType.toString());
      }).toList(),
    );
  }
}

// Инкапсуляция
class BankAccount {
  final String accountNumber;
  double _balance;

  BankAccount(this.accountNumber) : _balance = 0.0;

  double get balance => _balance;

  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
    } else {
      throw Exception("Сумма должна быть положительной");
    }
  }

  void withdraw(double amount) {
    if (amount > _balance) {
      throw Exception("Недостаточно средств");
    }
    _balance -= amount;
  }
}

class EncapsulationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BankAccount account = BankAccount('123456');
    account.deposit(100);
    account.withdraw(50);
    return Text('Баланс счета: ${account.balance}');
  }
}

// Наследование
abstract class AnimalMovement {
  void move();
}

class Fish extends AnimalMovement {
  @override
  void move() {
    print("Рыба плавает.");
  }
}

class Bird extends AnimalMovement {
  @override
  void move() {
    print("Птица летает.");
  }
}

class DogMovement extends AnimalMovement {
  @override
  void move() {
    print("Собака бегает.");
  }
}

class InheritanceDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<AnimalMovement> animals = [Fish(), Bird(), DogMovement()];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: animals.map((animal) {
        animal.move(); // Вызов метода move()
        return Text(animal.runtimeType.toString());
      }).toList(),
    );
  }
}

// Интерфейс "Платежная система"
abstract class PaymentSystem {
  void pay(double amount);
}

class CreditCard implements PaymentSystem {
  @override
  void pay(double amount) {
    // Вместо print используем виджет для отображения
    print("Оплата $amount через кредитную карту.");
  }
}

class PayPal implements PaymentSystem {
  @override
  void pay(double amount) {
    print("Оплата $amount через PayPal.");
  }
}

class PaymentSystemDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PaymentSystem payment = CreditCard();
    payment.pay(100.0); // Оплата через кредитную карту
    return Text('Оплата выполнена.');
  }
}

// Комплексные числа
class ComplexNumber {
  final double real;
  final double imaginary;

  ComplexNumber(this.real, this.imaginary);

   ComplexNumber operator +(ComplexNumber other) =>
       ComplexNumber(real + other.real, imaginary + other.imaginary);

   ComplexNumber operator -(ComplexNumber other) =>
       ComplexNumber(real - other.real, imaginary - other.imaginary);

   ComplexNumber operator *(ComplexNumber other) =>
       ComplexNumber(real * other.real - imaginary * other.imaginary,
           real * other.imaginary + imaginary * other.real);

   ComplexNumber operator /(ComplexNumber other) {
     double denominator = other.real * other.real + other.imaginary * other.imaginary;
     return ComplexNumber(
         (real * other.real + imaginary * other.imaginary) / denominator,
         (imaginary * other.real - real * other.imaginary) / denominator);
   }
}

class ComplexNumbersDemo extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     ComplexNumber num1 = ComplexNumber(3, 4);
     ComplexNumber num2 = ComplexNumber(1, -2);
     ComplexNumber result = num1 + num2; // Сложение комплексных чисел

     return Text('Результат сложения: ${result.real} + ${result.imaginary}i');
   }
}
 
class OrderSystem extends StatefulWidget {
  @override
  _OrderSystemState createState() => _OrderSystemState();
}

class _OrderSystemState extends State<OrderSystem> {
  final List<Order> _orders = [];
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();

  void _addOrder() {
    String productName = _productNameController.text;
    double? productPrice = double.tryParse(_productPriceController.text);
    String customerName = _customerNameController.text;

    if (productName.isEmpty || productPrice == null || customerName.isEmpty) {
      return; // Можно добавить обработку ошибок
    }

    Product product = Product(name: productName, price: productPrice);
    Customer customer = Customer(name: customerName);
    Order order = Order(customer: customer, product: product);

    setState(() {
      _orders.add(order);
      _productNameController.clear();
      _productPriceController.clear();
      _customerNameController.clear();
    });
  }

  double getTotalCost() {
    return _orders.fold(0, (total, order) => total + order.product.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Система заказов'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _customerNameController,
              decoration: InputDecoration(labelText: 'Имя клиента'),
            ),
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Название продукта'),
            ),
            TextField(
              controller: _productPriceController,
              decoration: InputDecoration(labelText: 'Цена продукта'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _addOrder,
              child: Text('Добавить заказ'),
            ),
            SizedBox(height: 20),
            Text('Общая стоимость заказов: \$${getTotalCost()}'),
            Expanded(
              child: ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${_orders[index].customer.name} - ${_orders[index].product.name}'),
                    subtitle: Text('Цена: \$${_orders[index].product.price}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Order {
  final Customer customer;
  final Product product;

  Order({required this.customer, required this.product});
}

class Customer {
  final String name;

  Customer({required this.name});
}

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}