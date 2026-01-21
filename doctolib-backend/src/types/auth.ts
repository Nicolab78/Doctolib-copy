export interface RegisterDto {
  email: string;
  password: string;
  firstname: string;
  lastname: string;
  phone?: string;
  role: "PATIENT" | "PRACTITIONER";
}

export interface LoginDto {
  email: string;
  password: string;
}