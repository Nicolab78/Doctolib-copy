import { createRouter, createWebHistory } from "vue-router";
import Home from "../pages/Home.vue";
import Register from "../pages/Register.vue";
import Login from "../pages/Login.vue";

export const router = createRouter ({
    history: createWebHistory(),
    routes: [
        { path: "/", name: "home", component: Home },
        { path: "/login", name: "login", component: Login },
        { path: "/register", name: "register", component: Register }
    ]


})
