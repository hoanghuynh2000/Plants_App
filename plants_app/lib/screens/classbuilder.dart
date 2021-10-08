import 'package:plants_app/screens/home.dart';
import 'package:plants_app/screens/rules.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors =
    <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor as Constructor<Object>;
}

class ClassBuilder {
  static void registerClasses() {
    register<Home>(() => Home());
    register<Rules>(() => Rules());
    // register<Notifications>(() => Notifications());
  }

  static dynamic fromString(String type) {
    return _constructors[type]!();
  }
}
