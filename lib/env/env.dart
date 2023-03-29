abstract class Env {
  Env._();
  String get baseUrl;
  String get token;

  factory Env.prod() => Prod._();
}

class Prod extends Env {
  Prod._() : super._();
  @override
  String get baseUrl =>
      'https://shubham-gupta-16.github.io/flutter_ecommerce_demo/demo-api';

  //this token is fake as the server doesn't need it, it will be useful when dealing with real apis
  @override
  String get token =>
      'IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz';
}
