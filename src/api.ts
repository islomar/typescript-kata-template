import express, { Request, Response, Application } from "express";

export const app: Application = express();

app.get("/", (req: Request, res: Response) => {
    res.json({
        status: "success",
    });
});

export const server = app.listen(4000, () => console.log("listening on port 4000"));
