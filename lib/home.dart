import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.0),
          children: [

            // Bill Display Box

            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(13.0),
                  border: Border.all(color: Colors.grey.shade300)
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total Per Person",
                      style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",
                        style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold
                    ),
                    )
                  ],
                ),
              ),
            ),

            // Functional Box

            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.grey.shade200,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [

                  // Bill Amount

                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: " Bill Amount",
                      prefixText: "\$ ",
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exceptions) {
                        _billAmount = 0.0;
                      }
                    },
                  ),

                  // Split b/w person

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Split",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if(_personCounter > 1){
                                    _personCounter --;
                                  }
                                  else{
                                    // do nothing
                                  }
                                });
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.shade300,
                                ),
                                child: Center(
                                  child: Text(
                                      "-",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("$_personCounter",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  _personCounter++;
                                });
                              },
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey.shade300,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  // Tip Counter

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tip",
                        style: TextStyle(color: Colors.grey.shade700),),
                        Text("\$ ${(calculateTotalTip(_billAmount, _tipPercentage)).toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 20.0, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  
                  // Slider Section
                  
                  Column(
                    children: [
                      Text("$_tipPercentage%",
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                        ),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.deepPurpleAccent,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double value){
                              setState(() {
                                _tipPercentage = value.round();
                              });
                      })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalTip(double billAmount, int tipPercent){
    double totalTip = 0.0;

    if(billAmount < 0 || billAmount.toString().isEmpty || billAmount == null)
      {
        //no go!
      }
    else
      {
        totalTip = (billAmount * tipPercent) / 100;
      }

    return totalTip;
  }

  calculateTotalPerPerson(double billAmount, int person, int tipPercent){
    var totalPerPerson = (billAmount + calculateTotalTip(billAmount, tipPercent)) / person;
    return totalPerPerson.toStringAsFixed(2);
  }

}
