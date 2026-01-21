import prisma from "../prisma/client";
import type { CreateAppointmentDto } from "../types/appointment";
import type { UpdateAppointmentDto } from "../types/appointment";

export const appointmentRepository ={
    create: (data: CreateAppointmentDto) =>
        prisma.appointment.create({data}),

    findAll: () =>
        prisma.appointment.findMany(),

    findById: (id: string) =>
        prisma.appointment.findUnique({ where : { id }}),

    findForUser: (userId: string, role: "PATIENT" | "PRACTITIONER") => {
    if (role === "PATIENT") {
        return prisma.appointment.findMany({
            where: { patientId: userId },
            include: { practitioner: true }
        })
    }

    return prisma.appointment.findMany({
        where: { practitionerId: userId },
        include: { patient: true }
    })
    },

    update: (id: string, data: UpdateAppointmentDto) =>
        prisma.appointment.update({ where: {id}, data}),

    delete: (id: string) =>
        prisma.appointment.delete({ where: {id}})
}