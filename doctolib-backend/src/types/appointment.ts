export interface CreateAppointmentDto {
    patientId: string
    practitionerId: string
    date: Date
    type: 'VISIO' | 'PRESENTIEL'
}

export interface UpdateAppointmentDto {
    patientId?: string
    practitionerId?: string
    date?: Date
    type?: 'VISIO' | 'PRESENTIEL'
    status?: 'SCHEDULED' | 'CANCELLED' | 'DONE'
}