

abstract class Env{
  Env._();
  String get baseUrl;
  String get token;

  factory Env.prod() => Prod._();
}

class Prod extends Env{
  Prod._() : super._();
  @override
  String get baseUrl => 'https://shubham-php.herokuapp.com/flutter-ecommerce-demo';

  @override
  String get token => 'eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz';
}