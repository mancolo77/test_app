import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MockRepository {
  Future<int> getMinimalTitleLength() async {
    await Future.delayed(const Duration(seconds: 2));
    return 6;
  }
}

class CreateFormScreen extends StatefulWidget {
  const CreateFormScreen({super.key});

  @override
  _CreateFormScreenState createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _emailController = TextEditingController();
  final _priceController = TextEditingController();

  int? _minTitleLength;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMinimalTitleLength();
  }

  Future<void> _loadMinimalTitleLength() async {
    final repository = MockRepository();
    final minTitleLength = await repository.getMinimalTitleLength();
    setState(() {
      _minTitleLength = minTitleLength;
      _isLoading = false;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _validateAndSubmit() {
    if (!_formKey.currentState!.validate()) {
      if (_titleController.text.length < _minTitleLength!) {
        _showSnackBar('Поле должно содержать более $_minTitleLength.');
      } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_emailController.text)) {
        _showSnackBar('Неверный формат почты');
      } else if (_priceController.text.isEmpty) {
        _showSnackBar('Цена не может быть пустой');
      } else {
        _showSnackBar('Цена должна содержать только числовые значения');
      }
      return;
    }
    _showSnackBar('Форма создана');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Item'),
      ),
      body: _isLoading
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не может быть пустым';
                        }
                        if (value.length < _minTitleLength!) {
                          return 'Поле должно содержать более $_minTitleLength.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Почта не может быть пустой.';
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Неверный формат почты';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Цена не может быть пустой';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _formKey.currentState?.validate() == true
                          ? _validateAndSubmit
                          : () {
                              _validateAndSubmit();
                            },
                      child: const Text('Create'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
