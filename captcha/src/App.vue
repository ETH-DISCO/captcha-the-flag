<template>
  <div>
    <p>solve me if you can!</p>
    <br>
    <Captcha />
  </div>
</template>

<script>
import Captcha from "./components/Captcha.vue";
export default {
  name: "App",
  components: {
    Captcha,
  },
};
</script>

<style>
body {
  margin: 5em;
}
</style>
