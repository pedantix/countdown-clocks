<template>
  <div>
    <b-form
      @submit.prevent="handleSubmit"
      @reset="onReset"
    >
      <b-form-group
        d="input-group-1"
        label="Title:"
        label-for="input-1"
        description="Your Event needs a title."
      >
        <b-form-input
          id="input-1"
          v-model="form.title"
          type="text"
          required
          placeholder="Enter a title"
        />
      </b-form-group>

      <b-button
        type="submit"
        variant="primary"
      >
        Submit
      </b-button>
      <b-button
        type="reset"
        variant="danger"
      >
        Reset
      </b-button>
    </b-form>
  </div>
</template>

<script>
import axios from'axios';
import { dateEncoder } from '../transformations/date-encoder';

export default {
  data() {
    return {
      show: true,
      form: {
        // Minimum Required Info
        title: "",
        date: new Date(),
        // Optional Info
        titleColor: null,
        subtitle: null,
        subtitleColor: null,
        backgroundColor: null,
        backgroundImage: null
      }
    };
  },
  methods: {
    handleSubmit(evt) {
      evt.preventDefault();
      const data = dateEncoder(this.form);
      axios.post('/', data).then(event => {
        console.log(`Success: ${event}`);
      }, error => {
        console.log(`Unhandled Error ${error}`);
      });
    }
  }
};
</script>
