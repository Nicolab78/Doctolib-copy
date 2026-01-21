import { api } from "./api"
import type { User, UserCreateDTO, UserUpdateDTO } from "../types/user"

export const userService = {
  getMe: async (): Promise<User> => {
    const response = await api.get<User>("/auth/me")
    return response.data
  },

  getById: async (id: string): Promise<User> => {
    const response = await api.get<User>(`/users/${id}`)
    return response.data
},

  create: async (data: UserCreateDTO): Promise<User> => {
    const response = await api.post<User>("/users", data)
    return response.data
  },

  update: async (id: string, data: UserUpdateDTO): Promise<User> => {
    const response = await api.put<User>(`/users/${id}`, data)
    return response.data
  },

  updateSpecialty: async (specialty: string): Promise<User> => {
    const response = await api.put<User>("/users/me/specialty", { specialty })
    return response.data
  },

  getAllPractitioners: async (): Promise<User[]> => {
    const response = await api.get<User[]>("/users/practitioners")
    return response.data
  }
}