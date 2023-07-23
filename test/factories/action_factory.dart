import 'package:built_collection/built_collection.dart';
import 'package:nowu/models/Action.dart';

import 'factory.dart';
import 'cause_factory.dart';

class ListActionFactory extends ModelFactory<ListAction> {
	@override
	ListAction generate() {
		return ListAction((action) => action
			..id = faker.randomGenerator.integer(100)
			..title = faker.lorem.sentence()
			..actionType = ActionTypeEnum.VOLUNTEER
			..causes = ListBuilder(CauseFactory().generateList(length: 1))
			..time = faker.randomGenerator.integer(10)
			..createdAt = faker.date.dateTime()
		);
	}
}

class ActionFactory extends ModelFactory<Action> {
	@override
	Action generate() {
		return Action((action) => action
			..id = faker.randomGenerator.integer(100)
			..title = faker.lorem.sentence()
			..actionType = ActionTypeEnum.VOLUNTEER
			..causes = ListBuilder([
				CauseFactory().generate()
			])
			..isCompleted = faker.randomGenerator.boolean()
			..time = faker.randomGenerator.integer(10)
			..createdAt = faker.date.dateTime()
		);
	}
}
