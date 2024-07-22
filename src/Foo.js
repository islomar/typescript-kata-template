export class Foo {
	constructor(name) {
		this.name = name;
		this.GREETING = "Hi";
	}

	greet() {
		return `${this.GREETING} ${this.name} from TypeScript Kata Template!`;
	}
}
