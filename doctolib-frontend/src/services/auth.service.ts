import { api } from "./api";
import type { LoginDTO, RegisterDTO, AuthResponse } from "../types/auth";

export const authService = {
    login: async(credential: LoginDTO): Promise<AuthResponse> => {
        const response = await api.post<AuthResponse>("/auth/login", credential);
        return response.data;
    },

    register: async(credential: RegisterDTO): Promise<AuthResponse> => {
        const response = await api.post<AuthResponse>("/auth/register", credential);
        return response.data;
    }
}