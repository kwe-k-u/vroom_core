import 'package:flutter/material.dart';


class TicketReciept extends StatelessWidget {
  const TicketReciept({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: SizedBox(
        height: size.height * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.asset("assets/ashesi_logo_white.png"),
              title: Text("Ticket ID: NX-265-6584"),
              subtitle: Text("Paid with Momo"),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Passenger"),
                  Text("#25", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),)
                ],
              ),
            ),

            Center(child: _QRCode()),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("Amount paid", style: Theme.of(context).textTheme.titleSmall,),
                      Text("GHC 3.00", style: Theme.of(context).textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.w600),)
                    ],
                  ),
                )
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(text: TextSpan(
                  text: "Passenger:  ",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                        text: "Dr Ibrahim Asante",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)
                    )
                  ]
              )),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(text: TextSpan(
                  text: "Arrival Location:  ",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                        text: "Ashesi University, Berekuso",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)
                    )
                  ]
              )),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(text: TextSpan(
                  text: "Departure Location:  ",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                        text: "Christ The King, Accra",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)
                    )
                  ]
              )),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Text("Bus information",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(text: TextSpan(
                  text: "Registration number:  ",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                        text: "GR 2245-15",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)
                    )
                  ]
              )),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(text: TextSpan(
                  text: "Driver name:  ",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                        text: "Emmanuel Mensah",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)
                    )
                  ]
              )),
            ),

          ],
        ),
      ),
    );
  }
}






class _QRCode extends StatelessWidget {
  const _QRCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.qr_code, size: 100,),
        Text("Ticket used"),],
    );
  }
}
