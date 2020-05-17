import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 0;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(12.5)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Total per person",style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold
                  ),),
                  Text("\'\u{20B9}' ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color:Colors.transparent,
                border:Border.all(
                  color: Colors.blueGrey.shade100
                ),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount : ",
                      prefixIcon: Icon(Icons.monetization_on)
                    ),
                  onChanged: (String value){
                      try{
                        _billAmount =  double.parse(value);
                      }catch(exception){
                        _billAmount = 0.0;
                      }
                  },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Split", style: TextStyle(
                          color: Colors.grey.shade800,
                        ),),
                        Row(
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            setState(() {
                              if (_personCounter > 1){
                                _personCounter--;
                              }else{
                                //nothing
                              }
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.all((10.0)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: Colors.purpleAccent.withOpacity(0.1)
                            ),
                            child: Center(
                              child: Text(
                                "-", style: TextStyle(
                                color: Colors.purpleAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0
                              )
                              ),
                            ),
                          ),
                        ),

                        Text("$_personCounter", style: TextStyle(
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0
                        ),),

                        InkWell(
                          onTap: (){
                            setState(() {
                              _personCounter++;
                            });
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            margin: EdgeInsets.all((10.0)),
                            decoration: BoxDecoration(
                              color: Colors.purpleAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(7.0)

                            ),
                            child: Center(
                              child: Text("+", style: TextStyle(
                                color:Colors.purpleAccent,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold
                              )),
                            ),
                          ),
                        )

                      ],
                    )
                      ],
                  ),
  //tip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Tip", style: TextStyle(
                        color: Colors.grey.shade800,
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("\'\u{20B9}' ${calculateTotalTip(_billAmount, _personCounter, _tipPercentage)}",style: TextStyle(
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                        ),),
                      )
                    ],
                  ),
                  //slider

                  Column(
                    children: [
                      Text("$_tipPercentage%",style: TextStyle(
                        color: Colors.purple,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold
                      ),),
                      Slider(
                        min: 0,
                          max: 100,
                          activeColor: Colors.purple,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value:_tipPercentage.toDouble(),
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





  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage){
    var totalPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount)/ splitBy;
    return totalPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage){
    double totalTip = 0.0;
    if(billAmount <0 || billAmount.toString().isEmpty || billAmount == null){
      //nogo
    }else{
     totalTip = (billAmount * tipPercentage)/ 100;
    }
    return totalTip;
  }
}


    
    
    