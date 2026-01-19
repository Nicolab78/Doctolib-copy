export interface CreateAppointementDto {
  patientId: string;
  practionnerId: string;
  date: string;
  type: "VISIO" | "PRESENTIEL";
}

export interface UpdateAppointementDto {
  date?: string;
  type?: "VISIO" | "PRESENTIEL";
  status?: "SCHEDULED" | "CANCELLED" | "DONE";
}