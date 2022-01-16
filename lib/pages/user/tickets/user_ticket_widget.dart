import 'package:flutter/material.dart';
import 'package:ticked/models/ticket.dart';
import 'package:ticked/pages/user/tickets/ticket_tile.dart';
import 'package:ticked/services/ticket_service.dart';

class UserTicketsWidget extends StatefulWidget {
  const UserTicketsWidget({Key? key}) : super(key: key);

  @override
  _UserTicketsWidgetState createState() => _UserTicketsWidgetState();
}

class _UserTicketsWidgetState extends State<UserTicketsWidget> {

  final ticketService = TicketService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
            child: Text(
              "BILETY",
              style: TextStyle(fontSize: 20),
            )),
        SingleChildScrollView(
          child: StreamBuilder<List<Ticket>>(
            stream: ticketService.getUserTickets(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var tickets = snapshot.data;
                if (tickets!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 200,),
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.blue,
                            child: const SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: Center(child: Text('Nie znaleziono biletów',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ))
                              ),
                            )),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      return TicketTile(
                          ticket: tickets[index],
                      );
                    }
                );
              }
                return const Center(
                child: Text('Błąd'),
              );
            },
          ),
        )
      ],
    );
  }

}
