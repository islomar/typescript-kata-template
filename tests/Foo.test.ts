import { Foo } from "../src/Foo";

describe("Foo", () => {
    it("can be instantiated without throwing errors", () => {
        const randomFooInstantiator = () => {
            new Foo("Anna");
        };

        expect(randomFooInstantiator).not.toThrow(TypeError);
    });

    it("greets", () => {
        const randomFoo = new Foo("John");

        const expectedGreeting = "Hi John from TypeScript Kata Template!";

        expect(randomFoo.greet()).toEqual(expectedGreeting);
    });
});
