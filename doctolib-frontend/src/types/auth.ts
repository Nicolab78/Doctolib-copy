export interface LoginDTO {
  email: string;
  password: string;
}

export interface RegisterDTO {
  email: string;
  password: string;
  firstname: string;
  lastname: string;
  phone?: string;
  role: "PATIENT" | "PRACTITIONER";
}

export interface AuthResponse {
  token: string;
  user: {
    id: number;
    email: string;
    firstname: string;
    lastname: string;
    role: "PATIENT" | "PRACTITIONER";
    phone?: string;
  };
}