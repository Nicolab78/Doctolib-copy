export interface CreateAppointmentDTO {
  patientId: string
  practitionerId: string
  date: Date
  type: "VISIO" | "PRESENTIEL"
}

export interface UpdateAppointmentDTO {
  date?: Date
  type?: "VISIO" | "PRESENTIEL"
  status?: "SCHEDULED" | "CANCELLED" | "DONE"
}

export interface Appointment {
  id: string
  patientId: string
  practitionerId: string
  date: Date
  type: "VISIO" | "PRESENTIEL"
  status: "SCHEDULED" | "CANCELLED" | "DONE"
  createdAt: Date
  updatedAt: Date
}