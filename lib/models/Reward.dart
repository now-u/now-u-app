import 'package:app/models/User.dart';

class Reward {
  int id;
  String title;
  //String _description;

  // Number required to complete action
  int successNumber;
  // Function to find out the current value
  Function getCurrentProgress;
  
  // Whether the action has ever been completed 
  bool completed;

  Reward({
    this.id, 
    this.title, 
    this.successNumber,
    this.getCurrentProgress,
  }){
    completed = getCurrentProgress() >= successNumber;
  }

  int getId() {
    return id;
  }
  String getTitle() {
    return title;
  }
 
  // Returns fractional completedness
  double getProgress() {
    if (getCurrentProgress() >= successNumber) {
      setComplete();
      return 1; 
    }
    return getCurrentProgress() / successNumber; 
  }
  // Once Completed never uncompleted
  bool getCompleted() {
    if (completed) return completed;
    completed = getCurrentProgress() >= successNumber;
    return completed;
  }

  void setComplete() {
    completed = true; 

  }
}
