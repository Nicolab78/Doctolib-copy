import { api } from "./api"
import type { CreateAppointmentDTO, UpdateAppointmentDTO, Appointment } from "../types/appointment"

export const appointmentService = {
  create: async (data: CreateAppointmentDTO): Promise<Appointment> => {
    const response = await api.post<Appointment>("/appointments/create", data)
    return response.data
  },

  update: async (id: string, data: UpdateAppointmentDTO): Promise<Appointment> => {
    const response = await api.put<Appointment>(`/appointments/${id}`, data)
    return response.data
  },

  getById: async (id: string): Promise<Appointment> => {
    const response = await api.get<Appointment>(`/appointments/${id}`)
    return response.data
  },

  getMine: async () => {
    const response = await api.get("/appointments/me")
    return response.data
  }
}