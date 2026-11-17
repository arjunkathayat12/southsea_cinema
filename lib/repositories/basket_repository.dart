import 'package:southsea_cinema/models/ticket_item.dart';

class BasketRepository {
  BasketRepository._internal();

  static final BasketRepository instance = BasketRepository._internal();

  final List<TicketItem> _tickets = [];

  // Return all tickets in the basket
  List<TicketItem> getTickets() {
    return List<TicketItem>.unmodifiable(_tickets);
  }

  // Add a ticket to the basket
  void addTicket(TicketItem ticket) {
    _tickets.add(ticket);
  }

  // Remove a ticket using its index
  void removeTicket(int index) {
    if (index >= 0 && index < _tickets.length) {
      _tickets.removeAt(index);
    }
  }

  // Calculate the total number of tickets
  int getTotalTickets() {
    int total = 0;

    for (final TicketItem ticket in _tickets) {
      total += ticket.quantity;
    }

    return total;
  }

  int get totalTicketCount {
    return getTotalTickets();
  }

  // Calculate the total price
  double getTotal() {
    double total = 0.0;

    for (final TicketItem ticket in _tickets) {
      total += ticket.lineTotal;
    }

    return total;
  }

  // Clear the basket
  void clear() {
    _tickets.clear();
  }
}
