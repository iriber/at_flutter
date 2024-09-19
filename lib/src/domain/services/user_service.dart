import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/core/login_dto.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';
import 'package:agro_tracking_flutter/src/domain/services/at_core_service.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class UserService {

  final FionaLogger logger = DependencyManager().get<FionaLogger>();
  final ATCoreService coreService = DependencyManager().get<ATCoreService>();

  Future<User> login(String email, String password)async{

    User user = User.empty();

    LoginDto dto = LoginDto(email: email, password: password);

    await coreService.login(dto).then((userDto){
      user.email = userDto.email;
      user.name = userDto.name;
      user.id=userDto.id;

    }).catchError((error, stackTrace){
      _errorHandler( error, stackTrace );
    });

    return user;
  }

  void _errorHandler(error, stackTrace) {
    logger.e("User Service ERROR: ${error.toString()}");
    logger.e("$stackTrace");

  }

}