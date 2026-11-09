import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 0;
  final double _ticketPrice = 7.50;
  String _orderMessage = '';

  void _increaseQuantity() {
    setState(() {
      if (_ticketQuantity > 0) {
        _orderMessage = '$_ticketQuantity tickets added to your order.';
      } else {
        _orderMessage = 'Please select the number of tickets.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(appTitle, style: cinemaHeaderStyle),
          backgroundColor: cinemaSurface,
          iconTheme: const IconThemeData(color: cinemaBrand),
          elevation: 0,
        ),
        drawer: const NavDrawer(),
        body: Container(
            child: Column(
          children: [
            Text(
              'The Avengers (2012)',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              'S.H.I.E.L.D. leader Nick Fury is compelled to launch the Avengers programme when Loki poses a threat to planet Earth. But the superheroes must learn to work together if they are to stop him in time.',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text(
              'Runtime: 143 minutes |  Age Rating: 12A',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Thursday 22 October 2026, 18:00",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Southsea Cinema Room',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Tickets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                DropdownMenu<int>(
                  initialSelection: 0,
                  onSelected: (int? value) {
                    setState(() {
                      _ticketQuantity = value ?? 0;
                      _orderMessage = '';
                    });
                  },
                  dropdownMenuEntries: List.generate(
                    6,
                    (index) => DropdownMenuEntry<int>(
                      value: index,
                      label: '$index',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                    child: Text('Adult (£7.50)',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )))
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Total: £${(_ticketQuantity * _ticketPrice).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              onPressed: _increaseQuantity,
              child: const Text('Add To Order'),
            ),
            const SizedBox(height: 16),
            if (_orderMessage.isNotEmpty)
              Text(_orderMessage,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ))
          ],
        )));
  }
}
