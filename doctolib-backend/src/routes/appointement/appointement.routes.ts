import { Router } from "express";
import { appointementController } from "../../controllers/appointement.controller";

const router = Router()

router.post("/create", appointementController.create)
router.get("/all", appointementController.list)
router.get("/:id", appointementController.get)
router.put("/:id", appointementController.update)
router.delete("/:id", appointementController.delete)

export default router