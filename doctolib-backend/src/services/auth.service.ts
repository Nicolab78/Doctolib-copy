import bcrypt from "bcrypt"
import jwt from "jsonwebtoken";
import { authRepository } from "../repositories/auth.repository";
import { RegisterDto, LoginDto } from "../types/auth";

const JWT_SECRET = process.env.JWT_SECRET || "dev-secret";

export const authService = {
    async register(data: RegisterDto) {
        const existing = await authRepository.findByEmail(data.email);
        if (existing) throw new Error("Email existant");

        const hashed = await bcrypt.hash(data.password, 10);

        const user = await authRepository.createUser({
            ...data,
            password: hashed
        });

        return user;
    },

    async login(data: LoginDto) {

        const user = await authRepository.findByEmail(data.email);
        if (!user) throw new Error("Identifiants invalides");

        const match = await bcrypt.compare(data.password, user.password);
        if (!match) throw new Error("Identifiants invalides")

        const token = jwt.sign(
            { id: user.id, role: user.role },
            JWT_SECRET,
            { expiresIn: "7d" }
        );
        
        return { token, user}
    }
}