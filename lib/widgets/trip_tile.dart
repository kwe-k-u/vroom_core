import 'package:vroom_core/models/trip.dart';
import 'package:vroom_core/utils/constants.dart';
import 'package:vroom_core/utils/extensions.dart';
import 'package:flutter/material.dart';


class TripTile extends StatelessWidget {
  final Trip trip;
  final void Function() onPressed;
  const TripTile({
    Key? key,
    required this.onPressed,
    required this.trip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        child: SizedBox(
          height: size.height * 0.21,
          width: size.width * 0.95,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                

                SizedBox(
                  width: size.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DestinationWidget(
                        label: "from",
                        location: trip.pickupLocation,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: ashesiRed,
                          height: double.maxFinite,
                          width: 2,
                        ),
                      ),
                      _DestinationWidget(
                        label: "to",
                        location: trip.dropOffLocation,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    RichText(text: TextSpan(
                        text: trip.tripDate.asString(),
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w600,
                        )
                    )),
                    RichText(text: TextSpan(
                      text: "Departure Time: ",
                      style: Theme.of(context).textTheme.titleSmall,
                      children: [
                        TextSpan(
                          text: trip.setOffTime.format(context),
                          style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w600,
                          )
                        )
                      ]
                    )),
                    const Spacer(),
                    Text(trip.busId, style: Theme.of(context).textTheme.headlineSmall,),
                    Text("20/${trip.capacity} seats")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class _DestinationWidget extends StatelessWidget {
  final String location;
  final String label;
  const _DestinationWidget({
    Key? key,
    required this.location,
    required this.label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(Icons.location_on_outlined, color: ashesiRed,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location, style: Theme.of(context).textTheme.labelLarge,),
            Text(label, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),),
          ],
        ),
      ],
    );
  }
}
