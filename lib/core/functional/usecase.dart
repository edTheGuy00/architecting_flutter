import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_example/core/failure/failure.dart';

abstract class UseCase<P, R> {

	Future<Either<Failure, R>> execute(P params);

	call(P params, Function(Either<Failure, R>) onResult) => execute(params).then(onResult);
}