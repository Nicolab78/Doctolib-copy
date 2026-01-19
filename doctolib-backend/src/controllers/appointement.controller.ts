import { appointementService } from "../services/appointement.service";
import type { Request, Response } from "express";

type IdParam = { id: string }

export const appointementController = {
    create: async (req: Request, res: Response) => {
        try{
            const appointement = await appointementService.createAppointement(req.body)
            res.status(201).json(appointement)

        } catch (err: any){
            res.status(400).json({ error: err.message })
        }
    },

    list: async (req: Request, res: Response) => {
        try{
            const appointements = await appointementService.getAppointements()
            res.status(200).json(appointements)
        } catch (err: any) {
            res.status(400).json({ error: err.message})
        }

    },

    get: async (req: Request<IdParam>, res: Response) => {
        try{
            const appointement = await appointementService.getAppointement(req.params.id)
            res.status(200).json(appointement)
        }catch (err: any){
            res.status(400).json({ error: err.message })
        }
    },

    update: async (req: Request<IdParam>, res: Response) => {
        try{
            const updatedappointement = await appointementService.updateAppointement(req.params.id, req.body)
            res.status(200).json(updatedappointement)
        } catch (err: any) {
            res.status(400).json({ error: err.message})
        }
    },

    delete: async (req: Request<IdParam>, res: Response) => {
        try{
            await appointementService.deleteAppointement(req.params.id)
            res.status(204).send()
        } catch ( err: any) {
            res.status(400).json({ error: err.message })
        }
    }

}