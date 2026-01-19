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
import type { LoginDTO } from "../types/auth";

const email = ref("");
const password = ref("");

async function submit() {
  const payload: LoginDTO = {
    email: email.value,
    password: password.value
  };

  try {
    const data = await authService.login(payload);
    console.log("Login success:", data);
  } catch (err) {
    console.error("Login error:", err);
  }
}
</script>