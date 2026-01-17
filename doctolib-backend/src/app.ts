import express from "express"
import userRoutes from "./routes/user/user.routes"
import appointementRoutes from "./routes/appointement/appointement.routes"

const app = express()

app.use(express.json())

app.use("/users", userRoutes)
app.use("/appointements", appointementRoutes)

export default app