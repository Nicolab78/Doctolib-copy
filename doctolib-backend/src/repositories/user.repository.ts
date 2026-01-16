import prisma from '../prisma/client'
import type { CreateUserDTO } from '../types/user'
import type { UpdateUserDTO } from '../types/user'

export const userRepository = {
    create: (data: CreateUserDTO) =>
        prisma.user.create({ data}),

    findAll: () =>
        prisma.user.findMany(),

    findById: (id: string) =>
        prisma.user.findUnique({ where : { id }}),

    update: (id: string, data: UpdateUserDTO) =>
        prisma.user.update({ where : { id }, data}),

    delete: (id: string) =>
        prisma.user.delete({ where : { id}})
}