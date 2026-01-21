import { createRouter, createWebHistory } from "vue-router";
import Home from "../pages/Home.vue";
import Register from "../pages/Register.vue";
import Login from "../pages/Login.vue";
import Profil from "../pages/Profil.vue";
import Appointment from "../pages/Appointment.vue";
import TakeAppointment from "../pages/TakeAppointment.vue";

export const router = createRouter ({
    history: createWebHistory(),
    routes: [
        { path: "/", name: "home", component: Home },
        { path: "/login", name: "login", component: Login },
        { path: "/register", name: "register", component: Register },
        { path: "/profil", name: "profil", component: Profil},
        { path: "/appointments", name: "appointment", component: Appointment},
        { path: "/takeappointment", name: "takeappointment", component: TakeAppointment}


        
    ]


})
