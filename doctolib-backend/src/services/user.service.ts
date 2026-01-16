import { userRepository } from "../repositories/user.repository";
import type { CreateUserDTO, UpdateUserDTO } from "../types/user";
import bcrypt from 'bcrypt'

export const userService = {
    async createUser(payload: CreateUserDTO) {
        const hashed = await bcrypt.hash(payload.password, 10)

        return userRepository.create({
            ...payload,
            password: hashed,
        })
    },

    getUsers(){
        return userRepository.findAll();
    },

    getUser(id: string){
        return userRepository.findById(id);
    },

    async updateUser(id: string, data: UpdateUserDTO){
        let updatedData = {...data}

        if(data.password){
            updatedData.password = await bcrypt.hash(data.password, 10)
        }

        return userRepository.update(id, updatedData)
    },

    deleteUser(id: string){
        return userRepository.delete(id);
    }


}