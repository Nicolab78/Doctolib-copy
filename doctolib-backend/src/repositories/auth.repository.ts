import prisma from "../prisma/client";
import type { RegisterDto } from "../types/auth";

export const authRepository = {
  findByEmail: (email: string) => {
    return prisma.user.findUnique({ where: { email } });
  },

  createUser: (data: RegisterDto & { password: string }) => {
    return prisma.user.create({ data });
  }
};