import type { Request, Response } from "express";
import { authService } from "../services/auth.service";

export const authController = {
    register: async (req: Request, res: Response) => {
        try{
            const user = await authService.register(req.body);
            res.status(201).json(user);
        } catch (err: any) {
            res.status(400).json({ error: err.message});
        }
    },

    login: async (req: Request, res: Response) => {
        try{
            const user = await authService.login(req.body);
            res.status(200).json(user);
        } catch (err: any) {
            res.status(400).json({ error: err.message});
        }

    }
}