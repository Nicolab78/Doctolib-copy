<template>
  <div class="page">
    <h1>Nos praticiens</h1>

    <div class="filters">
      <input
        type="text"
        placeholder="Rechercher un praticien..."
        v-model="search"
      />

      <select v-model="specialty">
        <option value="">Toutes les spécialités</option>
        <option v-for="s in specialties" :key="s" :value="s">
          {{ s }}
        </option>
      </select>
    </div>

    <div class="grid">
      <div v-for="p in filtered" :key="p.id" class="card">
        <h3>{{ p.firstname }} {{ p.lastname }}</h3>
        <p>{{ p.specialty }}</p>

        <RouterLink :to="`/takeappointment?pract=${p.id}`">
            Prendre rendez-vous
        </RouterLink>
      </div>
    </div>
  </div>
</template>

<style scoped>
.page {
  max-width: 900px;
  margin: 0 auto;
}

.filters {
  display: flex;
  gap: 20px;
  margin-bottom: 20px;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 20px;
}

.card {
  padding: 15px;
  border: 1px solid #ddd;
  border-radius: 8px;
}
</style>

<script setup lang="ts">
import { ref, computed, onMounted } from "vue"
import { userService } from "../services/user.service"
import type { User } from "../types/user"

const practitioners = ref<User[]>([])
const search = ref("")
const specialty = ref("")

const specialties = [
  "GENERALIST",
  "CARDIOLOGIST",
  "DENTIST",
  "DERMATOLOGIST",
  "PEDIATRICIAN",
  "OPHTALMOLOGIST"
]

onMounted(async () => {
  practitioners.value = await userService.getAllPractitioners()
})

const filtered = computed(() => {
  return practitioners.value.filter(p => {
    const matchName =
      (p.firstname + " " + p.lastname)
        .toLowerCase()
        .includes(search.value.toLowerCase())

    const matchSpecialty =
      specialty.value === "" || p.specialty === specialty.value

    return matchName && matchSpecialty
  })
})
</script>