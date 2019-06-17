<template>
  <div>
    <b-form
      @submit="onSubmit"
      @reset="onReset"
    >
      <b-form-group
        d="input-group-1"
        label="Email address:"
        label-for="input-1"
        description="We'll never share your email with anyone else."
      >
        <b-form-input
          id="input-1"
          v-model="form.email"
          type="email"
          required
          placeholder="Enter email"
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
export default {
  data() {
    return {
      show: true,
      form: {
        email: ""
      }
    };
  }
};
</script>
