<template>
    <div class="page">
        <h1>Register</h1>

        <form v-on:submit.prevent="submit">
            <input v-model="firstname" type="text" placeholder="Prénom" />
            <input v-model="lastname" type="text" placeholder="Nom" />
            <input v-model="email" type="email" placeholder="Email"/>
            <input v-model="password" type="password" placeholder="Mot de passe"/>
            <input v-model="confirm" type="password" placeholder="Confirmer Mot de passe"/>
            <input v-model="phone" type="text" placeholder="Numéro de téléphone"/>

            <select v-model="role">
                <option value="PATIENT">Patient</option>
                <option value="PRACTITIONER">Praticien</option>
            </select>
            <button type="submit">S'inscrire</button>

        </form>
    </div>


</template>

<script setup lang="ts">

import { ref } from 'vue';
import { authService } from '../services/auth.service';
import type { RegisterDTO } from '../types/auth';

const firstname = ref("");
const lastname = ref("");
const email = ref("");
const password = ref("");
const confirm = ref("");
const phone = ref("");
const role = ref<"PATIENT" | "PRACTITIONER">("PATIENT");

async function submit() {
    const payload: RegisterDTO = {
        firstname: firstname.value,
        lastname: lastname.value,
        email: email.value,
        password: password.value,   
        phone: phone.value,
        role: role.value
    };

    try {
        const data = await authService.register(payload);
        console.log("REGISTER SUCCESS:", data);
    } catch (err: any) {
    console.error("REGISTER ERROR:", err.response?.data || err);
    }
}

</script>