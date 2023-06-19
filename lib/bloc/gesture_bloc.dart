import 'package:flutter_bloc/flutter_bloc.dart';

import 'gesture_state.dart';
import 'gesture_event.dart';


class GestureBloc extends Bloc<GestureEvent,GestureState>{
     int scale =6;

     GestureBloc():super(GestureInitialState(6)){
         on<ScaleUpDownEvent> ((event,emit){
              if (event.upDownVal>1 && scale!=6){
        scale=scale+1;
        emit(GestureNewState(scale));

      }
      else if (event.upDownVal>1 && scale==6){

        emit(GestureNewState(scale));
     
      }
       else if (event.upDownVal<1 && scale==1){
        emit(GestureNewState(scale));

      }
       else if (event.upDownVal>1 && scale==1){
        scale = scale+1;
        emit(GestureNewState(scale));
      }
      else{
         scale = scale-1;
        emit(GestureNewState(scale));

      }
         
         }
         );
     }

}
