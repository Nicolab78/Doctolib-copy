<template>
    <div class="page">
        <h1>Login</h1>

        <form v-on:submit.prevent="submit">
            <input v-model="email" type="email" placeholder="Email"/>
            <input v-model="password" type="password" placeholder="Mot de passe"/>
            <button type="submit">Se connecter</button>
        </form>
    </div>
</template>

<script setup lang="ts">
import { ref } from "vue";
import { authService } from "../services/auth.service";
import { useRouter } from "vue-router";
import type { LoginDTO } from "../types/auth";
import { useAuth } from "../composables/useAuth";
const { login } = useAuth();

const email = ref("");
const password = ref("");
const router = useRouter();

async function submit() {
  const payload: LoginDTO = {
    email: email.value,
    password: password.value
  };

  try {
    const data = await authService.login(payload);
    login(data.user, data.token);
    router.push("/");

    console.log("Login success:", data);
  } catch (err: any) {
    console.error("Login error:", err.response?.data || err);
  }
}
</script>