export interface User {
  id: string
  firstname: string
  lastname: string
  email: string
  role: "PATIENT" | "PRACTITIONER"
  specialty?: string | null
  createdAt: string
  updatedAt: string
}

export interface UserCreateDTO {
  firstname: string
  lastname: string
  email: string
  password: string
  role: "PATIENT" | "PRACTITIONER"
}

export interface UserUpdateDTO {
  firstname?: string
  lastname?: string
  email?: string
  password?: string
  role?: "PATIENT" | "PRACTITIONER"
  specialty?: string | null
}