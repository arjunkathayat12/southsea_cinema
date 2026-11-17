import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';
import 'package:southsea_cinema/models/ticket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

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
    if (_ticketQuantity > 0) {
      final TicketItem ticket = TicketItem(
        movieTitle: 'The Avengers (2012)',
        quantity: _ticketQuantity,
        ticketPrice: _ticketPrice,
      );

      BasketRepository.instance.addTicket(ticket);

      setState(() {
        _orderMessage = '$_ticketQuantity tickets added to your basket.';
      });
    } else {
      setState(() {
        _orderMessage = 'Please select the number of tickets.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: Column(
        children: [
          Text(
            'The Avengers (2012)',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'S.H.I.E.L.D. leader Nick Fury is compelled to launch the Avengers programme when Loki poses a threat to planet Earth. But the superheroes must learn to work together if they are to stop him in time.',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Runtime: 143 minutes | Age Rating: 12A',
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
                child: Text(
                  'Adult (£7.50)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
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
          PrimaryButton(
            label: 'Add To Order',
            onPressed: _increaseQuantity,
          ),
          const SizedBox(height: 16),
          if (_orderMessage.isNotEmpty)
            Text(
              _orderMessage,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
