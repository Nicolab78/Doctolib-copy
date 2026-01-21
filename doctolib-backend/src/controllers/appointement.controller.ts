import { appointmentService } from "../services/appointment.service";
import type { Request, Response } from "express";

type IdParam = { id: string }

export const appointmentController = {
    create: async (req: Request, res: Response) => {
        try{
            const appointment = await appointmentService.createAppointment(req.body)
            res.status(201).json(appointment)

        } catch (err: any){
            res.status(400).json({ error: err.message })
        }
    },

    list: async (req: Request, res: Response) => {
        try{
            const appointments = await appointmentService.getAppointments()
            res.status(200).json(appointments)
        } catch (err: any) {
            res.status(400).json({ error: err.message})
        }

    },

    get: async (req: Request<IdParam>, res: Response) => {
        try{
            const appointment = await appointmentService.getAppointment(req.params.id)
            res.status(200).json(appointment)
        }catch (err: any){
            res.status(400).json({ error: err.message })
        }
    },

    me: async (req: Request, res: Response) => {
    try {
        const userId = req.user.id
        const role = req.user.role

        const appointments = await appointmentService.getForUser(userId, role)
        res.status(200).json(appointments)

    } catch (err: any) {
        res.status(400).json({ error: err.message })
    }
},
    

    update: async (req: Request<IdParam>, res: Response) => {
        try{
            const updatedappointment = await appointmentService.updateAppointment(req.params.id, req.body)
            res.status(200).json(updatedappointment)
        } catch (err: any) {
            res.status(400).json({ error: err.message})
        }
    },

    delete: async (req: Request<IdParam>, res: Response) => {
        try{
            await appointmentService.deleteAppointment(req.params.id)
            res.status(204).send()
        } catch ( err: any) {
            res.status(400).json({ error: err.message })
        }
    }

}