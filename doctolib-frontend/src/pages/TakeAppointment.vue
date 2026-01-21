<template>
  <div class="page">
    <h1>Prendre rendez-vous</h1>

    <div v-if="practitioner" class="pract-card">
      <h2>{{ practitioner.firstname }} {{ practitioner.lastname }}</h2>
      <p>Spécialité : {{ practitioner.specialty }}</p>
    </div>

    <form class="form" @submit.prevent="submit">
      <label>Date</label>
      <input type="date" v-model="date" required />

      <label>Heure</label>
      <input type="time" v-model="time" required />

      <button type="submit">Confirmer le rendez-vous</button>
    </form>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue"
import { useRoute, useRouter } from "vue-router"
import { userService } from "../services/user.service"
import { appointmentService } from "../services/appointment.service"

const route = useRoute()
const router = useRouter()

const practId = route.query.pract as string

const practitioner = ref<any>(null)
const me = ref<any>(null)

const date = ref("")
const time = ref("")

onMounted(async () => {
  me.value = await userService.getMe()
  practitioner.value = await userService.getById(practId)
})

async function submit() {
  const appointmentData = {
    patientId: me.value.id,
    practitionerId: practId,  
    date: new Date(`${date.value}T${time.value}`),
    type: "PRESENTIEL" as const
  }
    
  try {
    await appointmentService.create(appointmentData)
    alert("Rendez-vous confirmé")
    router.push("/profil")
  } catch (error: any) {
    console.error("Erreur:", error)
    console.log("Réponse serveur:", error.response?.data)
  }
}
</script>

<style scoped>
.page {
  max-width: 600px;
  margin: 0 auto;
}

.pract-card {
  padding: 15px;
  border: 1px solid #ddd;
  border-radius: 8px;
  margin-bottom: 20px;
}

.form {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

button {
  padding: 10px;
  background: #3b82f6;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}
</style>