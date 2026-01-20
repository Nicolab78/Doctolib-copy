<script setup lang="ts">
import { useAuth } from "../composables/useAuth";

const { user, isAuthenticated, logout } = useAuth();
</script>

<template>
  <nav class="navbar">
    <div class="left">
      <RouterLink to="/">Accueil</RouterLink>
    </div>

    <div class="right">
      <template v-if="!isAuthenticated()">
        <RouterLink to="/login">Login</RouterLink>
        <RouterLink to="/register">Register</RouterLink>
      </template>

      <template v-else>
        <span>Bonjour {{ user.firstname }}</span>
        <RouterLink to="/profile">Profil</RouterLink>
        <button @click="logout">Déconnexion</button>
      </template>
    </div>
  </nav>
</template>