class GestureState{}


class GestureInitialState extends GestureState{
int scale=6;
    GestureInitialState(this.scale);

}
class GestureNewState extends GestureState{
   final int scale;
    GestureNewState(this.scale);

}