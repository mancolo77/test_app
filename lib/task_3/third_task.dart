import 'package:flutter/material.dart';

class Purchase {
  final String title;
  final double price;
  final DateTime date;

  Purchase({required this.title, required this.price, required this.date});
}

class PurchaseListView extends StatefulWidget {
  const PurchaseListView({super.key});

  @override
  State<PurchaseListView> createState() => _PurchaseListViewState();
}

class _PurchaseListViewState extends State<PurchaseListView> {
  List<Purchase> purchases = [
    Purchase(title: 'My title', price: 100, date: DateTime(2024, 7, 3)),
    Purchase(title: 'My title2', price: 1002, date: DateTime(2024, 2, 3)),
    Purchase(title: 'My title3', price: 1421002, date: DateTime(2021, 2, 3)),
  ];

  String? _selectedSort;
  bool isChanged = true;

  void _sortList(String sortType) {
    setState(() {
      if (sortType == 'title') {
        purchases.sort((a, b) => isChanged
            ? a.title.compareTo(b.title)
            : b.title.compareTo(a.title));
      } else if (sortType == 'date') {
        purchases.sort((a, b) =>
            isChanged ? a.date.compareTo(b.date) : b.date.compareTo(a.date));
      } else if (sortType == 'price') {
        purchases.sort((a, b) => isChanged
            ? a.price.compareTo(b.price)
            : b.price.compareTo(a.price));
      }
    });
  }

  void _resetSort() {
    setState(() {
      _selectedSort = null;
      isChanged = true;
      purchases = [
        Purchase(title: 'My title', price: 100, date: DateTime(2024, 7, 3)),
        Purchase(title: 'My title2', price: 1002, date: DateTime(2024, 2, 3)),
        Purchase(
            title: 'My title3', price: 1421002, date: DateTime(2021, 2, 3)),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchases'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.filter_alt),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.close,
                                            color: Colors.teal),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                      const Text(
                                        'Filters',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _resetSort();
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Reset',
                                          style: TextStyle(color: Colors.teal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Sort order',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ListTile(
                                    leading: const Icon(Icons.sort_by_alpha),
                                    title: const Text('By name'),
                                    trailing: Icon(
                                      _selectedSort == 'title' && isChanged
                                          ? Icons.arrow_downward
                                          : Icons.arrow_upward,
                                      color: _selectedSort == 'title'
                                          ? Colors.teal
                                          : Colors.grey,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _selectedSort = 'title';
                                        isChanged = !isChanged;
                                        _sortList(_selectedSort!);
                                      });
                                    },
                                  ),
                                  const Divider(),
                                  ListTile(
                                    leading: const Icon(Icons.event),
                                    title: const Text('By date of purchase'),
                                    trailing: Icon(
                                      _selectedSort == 'date' && isChanged
                                          ? Icons.arrow_downward
                                          : Icons.arrow_upward,
                                      color: _selectedSort == 'date'
                                          ? Colors.teal
                                          : Colors.grey,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _selectedSort = 'date';
                                        isChanged = !isChanged;
                                        _sortList(_selectedSort!);
                                      });
                                    },
                                  ),
                                  const Divider(),
                                  ListTile(
                                    leading: const Icon(Icons.attach_money),
                                    title: const Text('By cost'),
                                    trailing: Icon(
                                      _selectedSort == 'price' && isChanged
                                          ? Icons.arrow_downward
                                          : Icons.arrow_upward,
                                      color: _selectedSort == 'price'
                                          ? Colors.teal
                                          : Colors.grey,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _selectedSort = 'price';
                                        isChanged = !isChanged;
                                        _sortList(_selectedSort!);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: purchases.length,
              itemBuilder: (context, index) {
                final purchase = purchases[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(purchase.title,
                            style: const TextStyle(fontSize: 18)),
                        Text('Price: \$${purchase.price}'),
                        Text(
                            'Purchased at: ${purchase.date.toIso8601String().split('T').first}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
