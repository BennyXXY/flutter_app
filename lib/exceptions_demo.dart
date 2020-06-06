//void main(){
//  //throw new FormatException("时间格式错误！");
//  //throw new NullThrownError();
//  //throw "这是一个异常对象！";
//
////  try{
////    throw new NullThrownError();
////  }on Exception catch(e){
////    print("error 异常类型捕获");
////  } catch(e , s){
////    print(e);
////    print(s);
////  }
//
////var point =Point.fromJson({"x":1,"y":2});
////print([point.x,point.y]);
//
////var point=Point.alonXAxis(1);
////print(point.x);
//
////Child child=Child.fromJson(12, 12);
////print([child.x,child.y]);
//}

class Point{
  num x;
  num y;
  Point(this.x,this.y);

  //命名构造函数
  Point.fromJson(Map json){
    x=json["x"];
    y=json["y"];
  }

  //重定向构造函数使用 ：调用其他函数
  Point.alonXAxis(num x) : this(x,0);//就是在次基础上从新引到了别的构造函数上
}
/**
 * 调用超类构造函数
 */
class Child extends Parent {
  int x;
  int y;
  //若超类没有默认构造函数， 需要手动调用超类其他构造函数
  Child(x, y) : super.fromJson(x, y) {
    //调用父类构造函数的参数无法访问 this
    print('子类构造函数');
  }

  //在构造函数的初始化列表中使用super()，需要把它放到最后
  Child.fromJson(x, y)
      : x = x,
        y = y,
        super.fromJson(x, y) {
    print('子类命名构造函数');
  }
}

class Parent {
  int x;
  int y;

  //父类命名构造函数不会传递
  Parent.fromJson(x, y)
      : x = x,
        y = y {
    print('父类命名构造函数');
  }
}

void main(){

}

/**
 * 工厂构造函数
 */
class Sington{
  String name;
  static Sington _cach;
  //工厂构造函数无法使用this
  //工厂构造函数不能生成实例，通过代码决定返回的实例对象
  factory Sington([String name="Sington"]){
    if(Sington._cach==null){
      Sington._cach=new Sington._newObject(name);
    }
    return Sington._cach ??= Sington._newObject(name);
  }
  Sington._newObject(this.name);
}

