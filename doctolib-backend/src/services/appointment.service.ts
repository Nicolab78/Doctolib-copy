import { appointmentRepository } from "../repositories/appointment.repository";
import type { CreateAppointmentDto, UpdateAppointmentDto } from "../types/appointment";

export const appointmentService = {

    createAppointment(data: CreateAppointmentDto) {
        return appointmentRepository.create(data);
    },

    getAppointments() {
        return appointmentRepository.findAll();
    },

    getAppointment(id: string) {
        return appointmentRepository.findById(id);
    },
    
    getForUser(userId: string, role: "PATIENT" | "PRACTITIONER") {
        return appointmentRepository.findForUser(userId, role)
    },

    updateAppointment(id: string, data: UpdateAppointmentDto) {
        return appointmentRepository.update(id, data);
    },

    deleteAppointment(id: string) {
        return appointmentRepository.delete(id);
    }
};