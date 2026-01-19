import prisma from "../prisma/client";
import type { CreateAppointementDto } from "../types/appointement";
import type { UpdateAppointementDto } from "../types/appointement";

export const appointementRepository ={
    create: (data: CreateAppointementDto) =>
        prisma.appointement.create({data}),

    findAll: () =>
        prisma.appointement.findMany(),

    findById: (id: string) =>
        prisma.appointement.findUnique({ where : { id }}),

    update: (id: string, data: UpdateAppointementDto) =>
        prisma.appointement.update({ where: {id}, data}),

    delete: (id: string) =>
        prisma.appointement.delete({ where: {id}})
}