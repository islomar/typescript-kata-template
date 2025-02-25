import request from "supertest";
import {app, server} from "../src/api";

describe("api", () => {

    afterEach(() => {
        server.close();
    });


    it('should xxx', async () => {

        const response = await request(app).get("/");

        expect(response.status).toEqual(200);
    });
});