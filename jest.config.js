module.exports = {
	preset: "ts-jest",
	testMatch: ["**/tests/**/*.test.ts"],
	transform: {
		"\\.ts$": "@swc/jest",
	},
	moduleFileExtensions: ["ts", "tsx", "js", "jsx", "json", "node"],
	transformIgnorePatterns: ["<rootDir>/node_modules/"],
	coverageDirectory: "<rootDir>/coverage",
	collectCoverageFrom: [
		"<rootDir>/src/**/*.ts"
	],
	testPathIgnorePatterns: ["<rootDir>/node_modules", "<rootDir>/vendor"],
	coverageReporters: ["text-summary", "html"],
};
