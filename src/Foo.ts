export class Foo {
    private readonly GREETING = "Hi";

    constructor(private readonly name: string) {}

    greet(): string {
        return `${this.GREETING} ${this.name} from TypeScript Kata Template!`;
    }
}
