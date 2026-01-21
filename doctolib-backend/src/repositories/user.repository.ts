import prisma from '../prisma/client'
import type { CreateUserDTO, UpdateUserDTO } from "../types/user"
import { PractitionerSpecialty, UserRole } from '../../prisma/generated'

export const userRepository = {
    create: (data: CreateUserDTO) => (
        prisma.user.create({ data })
    ),

    findAll: () => (
        prisma.user.findMany()
    ),

    findById: (id: string) => (
        prisma.user.findUnique({ where: { id } })
    ),
    
    update: (id: string, data: UpdateUserDTO) => (
        prisma.user.update({ where: { id }, data })
    ),

    delete: (id: string) => (
        prisma.user.delete({ where: { id } })
    ),

    findPractitioners: async () => {
    return await prisma.user.findMany({
        where: { role: UserRole.PRACTITIONER },
        select: {
            id: true,
            firstname: true,
            lastname: true,
            specialty: true
        }
    })
    },

    updateSpecialty: (id: string, specialty: string) => (
        prisma.user.update({
            where: { id },
            data: { specialty: specialty as PractitionerSpecialty }
        })
    )
}