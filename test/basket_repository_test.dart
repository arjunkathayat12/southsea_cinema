import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/ticket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

void main() {
  final BasketRepository basket = BasketRepository.instance;

  setUp(() {
    basket.clear();
  });

  group('BasketRepository tests', () {
    test('starts with an empty basket and zero totals', () {
      expect(basket.getTickets().length, 0);
      expect(basket.getTotalTickets(), 0);
      expect(basket.totalTicketCount, 0);
      expect(basket.getTotal(), 0.0);
    });

    test('adds tickets and calculates total correctly', () {
      const TicketItem ticket1 = TicketItem(
        movieTitle: 'The Avengers (2012)',
        quantity: 2,
        ticketPrice: 7.50,
      );

      const TicketItem ticket2 = TicketItem(
        movieTitle: 'Another Movie',
        quantity: 1,
        ticketPrice: 7.50,
      );

      basket.addTicket(ticket1);
      basket.addTicket(ticket2);

      expect(basket.getTickets().length, 2);
      expect(basket.getTotalTickets(), 3);
      expect(basket.totalTicketCount, 3);
      expect(basket.getTotal(), 22.50);
    });

    test('removes tickets correctly', () {
      const TicketItem ticket = TicketItem(
        movieTitle: 'The Avengers (2012)',
        quantity: 2,
        ticketPrice: 7.50,
      );

      basket.addTicket(ticket);

      expect(basket.getTickets().length, 1);

      basket.removeTicket(0);

      expect(basket.getTickets().length, 0);
      expect(basket.getTotalTickets(), 0);
      expect(basket.getTotal(), 0.0);
    });

    test('clears all tickets from the basket', () {
      const TicketItem ticket1 = TicketItem(
        movieTitle: 'The Avengers (2012)',
        quantity: 2,
        ticketPrice: 7.50,
      );

      const TicketItem ticket2 = TicketItem(
        movieTitle: 'Another Movie',
        quantity: 1,
        ticketPrice: 7.50,
      );

      basket.addTicket(ticket1);
      basket.addTicket(ticket2);

      basket.clear();

      expect(basket.getTickets(), isEmpty);
      expect(basket.getTotalTickets(), 0);
      expect(basket.getTotal(), 0.0);
    });
  });
}
