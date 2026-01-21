<template>
  <div class="profil">
    <h1>Mon profil</h1>

    <div v-if="user">
      <p><strong>Nom :</strong> {{ user.firstname }} {{ user.lastname }}</p>
      <p><strong>Email :</strong> {{ user.email }}</p>
      <p><strong>Rôle :</strong> {{ user.role }}</p>

      <button @click="logout">Se déconnecter</button>

      <!-- Spécialité praticien -->
      <div v-if="user.role === 'PRACTITIONER'" class="specialty">
        <label>Spécialité</label>

        <select v-model="specialty">
          <option disabled value="">Choisir une spécialité</option>
          <option v-for="s in specialties" :key="s" :value="s">
            {{ s }}
          </option>
        </select>

        <button @click="update" :disabled="loading">
          {{ loading ? "..." : "Mettre à jour" }}
        </button>

        <p v-if="message">{{ message }}</p>
      </div>

      <!-- Rendez-vous -->
      <div class="appointments">
        <h2>Mes rendez-vous</h2>

        <div 
          v-for="a in appointments" 
          :key="a.id" 
          class="appointment-card"
        >
          <p><strong>Date :</strong> {{ formatDate(a.date) }}</p>

          <p v-if="a.practitioner">
            <strong>Praticien :</strong>
            {{ a.practitioner.firstname }} {{ a.practitioner.lastname }}
          </p>

          <p v-if="a.patient">
            <strong>Patient :</strong>
            {{ a.patient.firstname }} {{ a.patient.lastname }}
          </p>

          <p><strong>Statut :</strong> {{ a.status }}</p>

          <div v-if="user.role === 'PRACTITIONER'">
            <select v-model="a.status" @change="updateStatus(a)">
              <option value="SCHEDULED">Programmé</option>
              <option value="CANCELLED">Annulé</option>
              <option value="DONE">Terminé</option>
            </select>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue"
import { useAuth } from "../composables/useAuth"
import { userService } from "../services/user.service"
import { appointmentService } from "../services/appointment.service"

const { user, logout } = useAuth()

const specialty = ref(user.value?.specialty || "")
const message = ref("")
const loading = ref(false)

const appointments = ref<any[]>([])

const specialties = [
  "GENERALIST",
  "CARDIOLOGIST",
  "DENTIST",
  "DERMATOLOGIST",
  "PEDIATRICIAN",
  "OPHTALMOLOGIST"
]

onMounted(async () => {
  if (!user.value) return
  appointments.value = await appointmentService.getMine()
})

const update = async () => {
  loading.value = true
  message.value = ""

  try {
    const updated = await userService.updateSpecialty(specialty.value)
    
    localStorage.setItem("user", JSON.stringify(updated))
    user.value = updated

    message.value = "Spécialité mise à jour"
  } catch (err: any) {
    message.value = err.response?.data?.error || "Erreur"
  } finally {
    loading.value = false
  }
}

async function updateStatus(a: any) {
  await appointmentService.update(a.id, { status: a.status })
}

function formatDate(date: string) {
  return new Date(date).toLocaleString("fr-FR", {
    dateStyle: "medium",
    timeStyle: "short"
  })
}
</script>

<style scoped>
.profil {
  max-width: 500px;
  margin: 0 auto;
}

.specialty {
  margin-top: 20px;
}

.appointments {
  margin-top: 30px;
}

.appointment-card {
  border: 1px solid #ddd;
  padding: 12px;
  border-radius: 8px;
  margin-bottom: 15px;
}
</style>