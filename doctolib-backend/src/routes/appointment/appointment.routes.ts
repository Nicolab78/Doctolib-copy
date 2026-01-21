import { Router } from "express";
import { appointmentController } from "../../controllers/appointement.controller";
import { authMiddleware } from "../../middleware/auth.middleware";

const router = Router()

router.get("/me", authMiddleware, appointmentController.me)
router.post("/create", appointmentController.create)
router.get("/all", appointmentController.list)
router.get("/:id", appointmentController.get)
router.put("/:id", appointmentController.update)
router.delete("/:id", appointmentController.delete)

export default router