import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/gesture_bloc.dart';
import 'bloc/gesture_event.dart';
import 'bloc/gesture_state.dart';


void main(){
   


   runApp(MyApp());
}

class Grids extends CustomPainter {
  int grid_lines;
   Grids(this.grid_lines);
 
  
  @override
  void paint(Canvas canvas , Size size){
    final courtPaint = Paint()
      ..color = const Color(0xFF454545)
      ..strokeWidth = 2.0;

    drawCourt(canvas, size,courtPaint);
  }


   

    
  void drawCourt(
      Canvas canvas,
      Size size,
      Paint paint
      ){

    double dist = size.width/grid_lines;


double x_axis_lines =0;
  int grid_lines_copy =grid_lines;
  while(grid_lines>0){
      
      
      final p1 = Offset(0, x_axis_lines);
      final p2 = Offset(size.width,x_axis_lines);
      canvas.drawLine(p1, p2, paint);
      x_axis_lines+=dist;
      grid_lines--;
  }

double y_axis_lines =0;
  while(grid_lines_copy>0){
      final p1 = Offset(y_axis_lines, 0);
      final p2 = Offset(y_axis_lines,size.width);
      canvas.drawLine(p1, p2, paint);
      y_axis_lines+=dist;
      grid_lines_copy--;
  }
  




    // canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
    // canvas.drawLine(Offset(0, size.height * 0.25), Offset(size.width, size.height * 0.25), paint);
    // canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), paint);

    // // Draw service lines
    // canvas.drawLine(Offset(0, size.height*0.85), Offset(size.width, size.height*0.85), paint);
    // canvas.drawLine(Offset(size.width * 0.05, 0), Offset(size.width * 0.05, size.height), paint);
    // canvas.drawLine(Offset(size.width * 0.95, 0), Offset(size.width * 0.95, size.height), paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

 
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocProvider<GestureBloc>(
          create: (context)=>GestureBloc(),
          child:   MaterialApp(
      home:GridView(),
    )
          );
    
  }
}

class GridView extends StatelessWidget {
  const GridView({super.key});


  @override
  Widget build(BuildContext context) {
        List <double> onScaleUpdate = [];


    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(24.0),
          child: GestureDetector(

            
            onScaleStart: (ScaleStartDetails details){
                      
  print("on scale start ${details}");
},
onScaleUpdate: ( details){
  print("on scale update ${details.scale}");

if(details.horizontalScale!=1){

    onScaleUpdate.add(details.horizontalScale);
}


},
onScaleEnd: (ScaleEndDetails details){
  print("on scale end ${details}");
  double scales = onScaleUpdate[onScaleUpdate.length-1];
  onScaleUpdate.clear();

     BlocProvider.of<GestureBloc>(context).add(ScaleUpDownEvent(scales));
},

child: Container(
               
                  height: MediaQuery.of(context).size.height*(342)/(844),
                  width: MediaQuery.of(context).size.height*(342)/(844),
         
                   decoration: BoxDecoration(
                             color: Color(0xFF1B1C28),
    border: Border.all(
      width: 1, color:
       Color(0xFF454545)
    ),
  ),
                  child: 
              
              
             BlocBuilder<GestureBloc,GestureState>(
               builder: (context,state) {
                     if (state is GestureNewState){
                       return CustomPaint(
              
               
                    painter:Grids(state.scale)
                  
               );
                     }
                     else{
                       return CustomPaint(
              
               
                    painter:Grids(6)
                  
               );

                     }
               }


             )
           
    
          ),

          )
            
         

                

          )
  
        );

  }
}