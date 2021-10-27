import 'package:flutter/material.dart';
import 'package:plants_app/bloc/CouterBloc.dart';
import 'package:plants_app/couter/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  
  @override
  Widget build(BuildContext context) {
   

    return BlocProvider<CouterBloc>(
        create: (context) => CouterBloc(),
        child: BlocBuilder<CouterBloc, int>(
          builder: (context, numOfItems) {
            final CouterBloc couterBloc = context.read<CouterBloc>();
            return Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                   margin: EdgeInsets.only(right: 18),
                  width: 20,
                  child: IconButton(
                      onPressed: () {
                        couterBloc.add(CouterEvent.decre);
                        setState(() {});
                      },
                      icon: Icon(Icons.remove)),
                ),
                Container(
                    width: 20,
                    // ignore: unnecessary_brace_in_string_interps
                    child: Text(
                      '${numOfItems}',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    )),
                Container(
                  width: 20,
                  child: IconButton(
                      onPressed: () {
                        couterBloc.add(CouterEvent.incre);
                        setState(() {});
                      },
                      icon: Icon(Icons.add)),
                )
              ],
            ));
          },
        ));
  }}