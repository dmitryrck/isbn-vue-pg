<template>
  <div class="hello">
    {{ error }}<br>
    <label for="isbn">ISBN</label>

    <input
      id="isbn"
      v-model="isbn"
      class="form-check-input"
      :disabled="disabled"
      :name="isbn"
      autofocus=autofocus
      placeholder="ISBN (12 numbers)"
      type="text"
    >

    <button
      @click.prevent="getDigit()"
      :disabled="disabled"
    >
      Get digit
    </button>

    <div v-if="completeIsbn">
      <h1>Complete ISBN: {{ completeIsbn }}</h1>
    </div>

    <div>
      <h1>Example of valid ISBNs:</h1>

      <p>978014300723<em>4</em></p>
      <p>978186197271<em>2</em></p>
    </div>
  </div>
</template>

<script>
import axios from "axios"

export default {
  name: 'ISBN',
  methods: {
    getDigit () {
      this.disabled = true
      axios
        .post(`${process.env.API_URL}isbn`, { isbn: this.isbn })
        .then( (response) => {
          this.digit = response.data.digit
        })
        .catch( (error) => {
          this.error = error
          this.digit = null
        })

      this.disabled = false
    },
  },
  watch: {
    isbn () {
      this.digit = null
    },
  },
  computed: {
    completeIsbn () {
      if (this.isbn && this.digit) {
        return `${this.isbn}${this.digit}`
      } else {
        return ""
      }
    },
  },
  data () {
    return {
      disabled: false,
      isbn: null,
      digit: null,
      error: null,
    }
  }
}
</script>
