import express from "express"
import userRoutes from "./routes/user/user.routes"
import appointementRoutes from "./routes/appointement/appointement.routes"
import authRoutes from "./routes/auth/auth.routes"

const app = express()

app.use(express.json())

app.use("/users", userRoutes)
app.use("/appointements", appointementRoutes)
app.use("/auth", authRoutes)

export default app