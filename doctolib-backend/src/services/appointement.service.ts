import { appointementRepository } from "../repositories/appointement.repository";
import type { CreateAppointementDto, UpdateAppointementDto } from "../types/appointement";

export const appointementService = {

    createAppointement(data: CreateAppointementDto) {
        return appointementRepository.create(data);
    },

    getAppointements() {
        return appointementRepository.findAll();
    },

    getAppointement(id: string) {
        return appointementRepository.findById(id);
    },

    updateAppointement(id: string, data: UpdateAppointementDto) {
        return appointementRepository.update(id, data);
    },

    deleteAppointement(id: string) {
        return appointementRepository.delete(id);
    }
};