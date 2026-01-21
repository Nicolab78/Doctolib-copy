import express from "express"
import userRoutes from "./routes/user/user.routes"
import appointmentRoutes from "./routes/appointment/appointment.routes"
import authRoutes from "./routes/auth/auth.routes"
import cors from "cors";

const app = express()

app.use(cors({
  origin: "http://localhost:5173",
  credentials: true
}));

app.use(express.json())

app.use("/users", userRoutes)
app.use("/appointments", appointmentRoutes)
console.log("APPOINTMENT ROUTES LOADED")
app.use("/auth", authRoutes)

export default app