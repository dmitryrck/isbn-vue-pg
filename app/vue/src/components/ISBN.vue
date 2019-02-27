<template>
  <div class="row">
    <div class="col-md-4 order-md-2 mb-4">
      <h4 class="d-flex justify-content-between align-items-center mb-3">
        <span class="text-muted">Examples</span>
      </h4>

      <ul class="list-group mb-3">
        <li class="list-group-item d-flex justify-content-between lh-condensed">
          <div><h6 class="my-0">Code: 978014300723</h6></div>
          <span>Digit: 4</span>
        </li>

        <li class="list-group-item d-flex justify-content-between lh-condensed">
          <div><h6 class="my-0">Code: 978186197271</h6></div>
          <span>Digit: 2</span>
        </li>

        <li class="list-group-item d-flex justify-content-between lh-condensed">
          <div><h6 class="my-0">Code: 978186197876</h6></div>
          <span>Digit: 9</span>
        </li>
      </ul>
    </div>

    <div class="col-md-8 order-md-1">
      {{ error }}<br>

      <form novalidate>
        <div class="row">
          <div class="col-md-5 mb-3">
            <label for="isbn">ISBN</label>

            <input
              id="isbn"
              v-model="isbn"
              class="form-control"
              :disabled="disabled"
              :name="isbn"
              autofocus=autofocus
              placeholder="ISBN (12 numbers)"
              type="text"
            >
          </div>

          <div class="col-md-3 mb-3">
            <label for="digit">Digit</label>

            <input
              id="digit"
              v-model="digit"
              class="form-control"
              disabled="disabled"
              :name="digit"
              type="text"
            >
          </div>

          <div class="col-md-4 mb-3">
            <label for="complete_isbn">Complete ISBN</label>

            <input
              id="complete_isbn"
              v-model="completeIsbn"
              class="form-control"
              disabled="disabled"
              :name="complete_isbn"
              type="text"
            >
          </div>
        </div>

        <hr>

        <button
          @click.prevent="getDigit()"
          class="btn btn-primary"
          :disabled="disabled"
        >
          Get digit
        </button>
      </form>
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
          this.disabled = false
        })
        .catch( (error) => {
          this.error = error
          this.digit = null
          this.disabled = false
        })
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
