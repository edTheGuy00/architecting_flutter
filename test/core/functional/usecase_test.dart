import 'package:dartz/dartz.dart';
import 'package:flutter_architecture_example/core/failure/failure.dart';
import 'package:flutter_architecture_example/core/functional/usecase.dart';
import 'package:test/test.dart';

const String TEST_RESULT = "results ok";
const String FAILURE = "not ok";

void main() {
	final testUseCase = TestUseCase();
	Either<Failure, TestResults> success;
	Either<Failure, TestResults> fail;

	testUseCase(5, (e) => success = e);
	testUseCase(null, (e) => fail = e);

	test('verify is success', () {
		expect(success, TypeMatcher<Right>());
	});

	test('verify results', () {
		expect(success.getOrElse(() => TestResults("Not OK")).result, TEST_RESULT);
	});

	test('verify is failure', () {
		expect(fail, TypeMatcher<Left>());
	});

	test('test failure message', () {
		TestFailure failure;
		fail.fold((f) => failure = f, (e) {});
		expect(failure.message, FAILURE);
	});

}

class TestResults {
	final String result;
	TestResults(this.result);
}

class TestFailure extends Failure {
	@override
  String get message => FAILURE;
}

class TestUseCase extends UseCase<int, TestResults> {
  @override
  Future<Either<Failure, TestResults>> execute(int params) {
    // calls api, database, computation, etc.
		if (params != null) {
			return Future.delayed(Duration.zero, () => Right(TestResults(TEST_RESULT)));
		} else return Future.delayed(Duration.zero, () => Left(TestFailure()));
  }
}