void main(){
//  var foot=new Massage("foot");
//  var back=new Massage("back");
//  var special=new Massage("special");
//
//  foot.doMassage();
//  back.doMassage();
//  special.doMassage();

var f=massageFactory("foot");
f.doMassage();
}

//顶级函数
Massages massageFactory(String type){
  switch(type){
    case "foot":
      return new footan();
  }
}

abstract class Massages{
  void doMassage(){
    print("按摩");
  }
}

class footan extends Massages{
  void doMassage(){
    print("脚底按摩");
  }
}



abstract class Massage{
  factory Massage(String type){
    switch(type){
      case "foot":
        return new FootMasage();
      case "back":
        return new BackMasage();
      case "special":
        return new SpecialMasage();
    }
  }
  void doMassage();
}

class FootMasage implements Massage{
  @override
  void doMassage() {
    print("foot");
  }
  
}
class BackMasage implements Massage{
  @override
  void doMassage() {
   print("back");
  }

}
class SpecialMasage implements Massage{
  @override
  void doMassage() {
    print("special");
  }

}