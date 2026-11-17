import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  final BasketRepository _basketRepository = BasketRepository.instance;

  @override
  Widget build(BuildContext context) {
    final tickets = _basketRepository.getTickets();

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: tickets.isEmpty
          ? const Center(
              child: Text(
                'Your basket is empty.',
                style: TextStyle(fontSize: 20),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];

                      return Card(
                        color: cinemaSurface,
                        child: ListTile(
                          title: Text(
                            ticket.movieTitle,
                            style: const TextStyle(
                              color: cinemaFontWhite,
                            ),
                          ),
                          subtitle: Text(
                            '${ticket.quantity} tickets × £${ticket.ticketPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: cinemaFontMuted,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '£${ticket.lineTotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: cinemaFontWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: cinemaBrand,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _basketRepository.removeTicket(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: cinemaSurface,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Total Tickets: ${_basketRepository.getTotalTickets()}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: cinemaFontWhite,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total: £${_basketRepository.getTotal().toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: cinemaFontWhite,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _basketRepository.clear();
                          });
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Clear Basket'),
                        style: TextButton.styleFrom(
                          foregroundColor: cinemaBrand,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
