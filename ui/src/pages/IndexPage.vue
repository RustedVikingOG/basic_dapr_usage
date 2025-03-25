<template>
  <q-page class="row items-center justify-evenly">
    <q-card dark>
      <q-card-section>
        <q-btn dark @click="getWords" label="Get Words" />
      </q-card-section>
      <q-card-section>
        <q-input dark v-model="words" label="Words" />
      </q-card-section>
    </q-card>
  </q-page>
</template>

<script setup lang="ts">
import axios from 'axios';
import { ref } from 'vue';

defineOptions({
  name: 'IndexPage'
});

const words = ref<string>('');

const getWords = async (): Promise<string> => {
  // const response = await axios.get('http://localhost:5000/');
  // words.value = response.data.message;
  // return response.data.message;
  try {
    // For development, use a relative URL if you configure a proxy in your Quasar/Vue config
    // or use API_URL from environment variables for different environments
    const response = await axios.get('http://localhost:5000/');
    words.value = response.data.message;
    return response.data.message;
  } catch (error) {
    console.error('Error fetching data:', error);
    words.value = 'Error: Could not fetch data';
    return 'Error: Could not fetch data';
  }
};

</script>
