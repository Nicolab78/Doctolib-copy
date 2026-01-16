import { Router } from "express"
import { userController } from "../../controllers/user.controller"

const router = Router()

router.post("/create", userController.create)
router.get("/all", userController.list)
router.get("/:id", userController.get)
router.put("/:id", userController.update)
router.delete("/:id", userController.delete)

export default router