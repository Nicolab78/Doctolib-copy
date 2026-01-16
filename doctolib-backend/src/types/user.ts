export interface CreateUserDTO {
    email: string
    password: string
    firstname: string
    lastname: string
    phone?: string
    role: 'PATIENT'|'PRACTICIONNER' 
}

export interface UpdateUserDTO {
    email?: string
    password?: string
    firstname?: string
    lastname?: string
    phone?: string
    role?: 'PATIENT'|'PRACTICIONNER' 
}

