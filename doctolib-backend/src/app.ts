import express from "express"
import userRoutes from "./routes/user/user.routes"
import appointmentRoutes from "./routes/appointment/appointment.routes"
import authRoutes from "./routes/auth/auth.routes"
import cors from "cors";

const app = express()

app.use(cors({
  origin: "*", // pour tester, on ouvre tout
  methods: ["GET", "POST", "PUT", "DELETE"],
  allowedHeaders: ["Content-Type", "Authorization"],
}));

app.use(express.json())

app.use("/users", userRoutes)
app.use("/appointments", appointmentRoutes)
app.use("/auth", authRoutes)

export default app