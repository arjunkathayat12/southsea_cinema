import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/ticket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';

void main() {
  final BasketRepository basket = BasketRepository.instance;

  setUp(() {
    basket.clear();
  });

  testWidgets('BasketView displays empty message when basket is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: BasketView(),
      ),
    );

    expect(find.text('Your basket is empty.'), findsOneWidget);
    expect(find.text('Checkout'), findsNothing);
  });

  testWidgets('BasketView displays tickets and total correctly',
      (WidgetTester tester) async {
    const TicketItem ticket = TicketItem(
      movieTitle: 'The Avengers (2012)',
      quantity: 2,
      ticketPrice: 7.50,
    );

    basket.addTicket(ticket);

    await tester.pumpWidget(
      const MaterialApp(
        home: BasketView(),
      ),
    );

    expect(find.text('The Avengers (2012)'), findsOneWidget);
    expect(find.text('2 tickets × £7.50'), findsOneWidget);
    expect(find.text('Total Tickets: 2'), findsOneWidget);
    expect(find.text('Total: £15.00'), findsOneWidget);
    expect(find.text('Checkout'), findsOneWidget);
  });

  testWidgets('BasketView removes ticket when delete button is pressed',
      (WidgetTester tester) async {
    const TicketItem ticket = TicketItem(
      movieTitle: 'The Avengers (2012)',
      quantity: 2,
      ticketPrice: 7.50,
    );

    basket.addTicket(ticket);

    await tester.pumpWidget(
      const MaterialApp(
        home: BasketView(),
      ),
    );

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pump();

    expect(find.text('Your basket is empty.'), findsOneWidget);
    expect(basket.getTickets(), isEmpty);
  });

  testWidgets('BasketView clears all tickets when Clear Basket is pressed',
      (WidgetTester tester) async {
    const TicketItem ticket = TicketItem(
      movieTitle: 'The Avengers (2012)',
      quantity: 2,
      ticketPrice: 7.50,
    );

    basket.addTicket(ticket);

    await tester.pumpWidget(
      const MaterialApp(
        home: BasketView(),
      ),
    );

    await tester.tap(find.text('Clear Basket'));
    await tester.pump();

    expect(find.text('Your basket is empty.'), findsOneWidget);
    expect(basket.getTickets(), isEmpty);
  });

  testWidgets('Checkout clears basket and displays confirmation message',
      (WidgetTester tester) async {
    const TicketItem ticket = TicketItem(
      movieTitle: 'The Avengers (2012)',
      quantity: 2,
      ticketPrice: 7.50,
    );

    basket.addTicket(ticket);

    await tester.pumpWidget(
      const MaterialApp(
        home: BasketView(),
      ),
    );

    await tester.tap(find.text('Checkout'));
    await tester.pump();

    expect(basket.getTickets(), isEmpty);

    expect(find.text('Your basket is empty.'), findsOneWidget);

    expect(
      find.text('Thanks, your order is on its way'),
      findsOneWidget,
    );

    expect(find.text('Checkout'), findsNothing);
  });
}
