import { userService } from "../services/user.service"
import type { Request, Response } from "express"

type IdParam = { id: string }
type RoleParam = { role: string }

type AuthUser = {
  id: string
  role: string
}

export const userController = {
  create: async (req: Request, res: Response) => {
    try {
      const user = await userService.createUser(req.body)
      res.status(201).json(user)
    } catch (err: any) {
      res.status(400).json({ error: err.message })
    }
  },

  list: async (req: Request, res: Response) => {
    try {
      const users = await userService.getUsers()
      res.status(200).json(users)
    } catch (err: any) {
      res.status(400).json({ error: err.message })
    }
  },

  get: async (req: Request<IdParam>, res: Response) => {
    try {
      const user = await userService.getUser(req.params.id)
      res.status(200).json(user)
    } catch (err: any) {
      res.status(400).json({ error: err.message })
    }
  },

  update: async (req: Request<IdParam>, res: Response) => {
    try {
      const updatedUser = await userService.updateUser(req.params.id, req.body)
      res.status(200).json(updatedUser)
    } catch (err: any) {
      res.status(400).json({ error: err.message })
    }
  },

  delete: async (req: Request<IdParam>, res: Response) => {
    try {
      await userService.deleteUser(req.params.id)
      res.status(204).send()
    } catch (err: any) {
      res.status(400).json({ error: err.message })
    }
  },

  listPractitioners: async (req: Request, res: Response) => {    
    try {
        const practitioners = await userService.getPractitioners()
        res.status(200).json(practitioners)
    } catch (err: any) {
        res.status(400).json({ error: err.message })
    }
  },

  updateSpecialty: async (req: Request, res: Response) => {
    try {
      const user = req.user as AuthUser
      const updated = await userService.updateSpecialty(user.id, req.body.specialty)
      res.status(200).json(updated)
    } catch (err: any) {
      res.status(400).json({ error: err.message })
    }
  }
}