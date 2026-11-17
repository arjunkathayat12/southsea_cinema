class TicketItem {
  final String movieTitle;
  final int quantity;
  final double ticketPrice;

  const TicketItem({
    required this.movieTitle,
    required this.quantity,
    required this.ticketPrice,
  });

  double get lineTotal {
    return quantity * ticketPrice;
  }
}
