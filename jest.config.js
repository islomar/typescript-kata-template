module.exports = {
    preset: 'ts-jest',
    testMatch: ["**/tests/**/*.test.ts"],
    transform: {
        "\\.ts$": "@swc/jest",
    },
    moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],
    transformIgnorePatterns: ['<rootDir>/node_modules/'],
};
