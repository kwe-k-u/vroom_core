import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vroom_core/models/app_state.dart';
import 'package:vroom_core/models/bus.dart';
import 'package:vroom_core/models/payment_receipt.dart';
import 'package:vroom_core/utils/constants.dart';
import 'package:vroom_core/widgets/custom_button.dart';


class BusTile extends StatelessWidget {
  final Bus bus;
  final void Function() onPressed;
  const BusTile({
    Key? key,
    required this.bus,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onPressed,
      // onTap: (){
      //   showDialog(
      //       context: context,
      //       barrierColor: ashesiGrey.withOpacity(0.8),
      //       builder: (context)=>  BusDetails(bus)
      //   );
      // },
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

                //left column
                Column(
                  children: [
                    Placeholder(
                      fallbackWidth: size.width * 0.3,
                      fallbackHeight: size.height * 0.13,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(bus.busRegistrationNumber,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    )
                  ],
                ),

                //middle column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DestinationWidget(
                      label: "from",
                      location:" bus.pickup.name",
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
                      location: "bus.dropOff.name",
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomButton(
                      text: "Book",
                      onPressed: (){
                        //todo figure out
                        // Navigator.push(context,
                        //     MaterialPageRoute(
                        //         builder: (context)=> PaymentInfo(
                        //           type: PaymentType.standard,
                        //             email: context.read<AppState>().auth!.currentUser!.email!,
                        //             name: context.read<AppState>().auth!.currentUser!.displayName!
                        //         )
                        //     )
                        // );
                      },
                      radius: 8,
                    ),
                    const Spacer(flex: 2,),
                    RichText(text: TextSpan(
                      text: "GHC ",
                      style: Theme.of(context).textTheme.labelLarge!
                        .copyWith(fontSize: 16),
                      children: [
                        TextSpan(
                          text: "3.00",
                          style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w600,
                            fontSize: 24
                          )
                        )
                      ]
                    )),
                    const Spacer()
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
