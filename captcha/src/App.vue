<template>
  <div>
    <h1>Hello world</h1>
    <Captcha />
  </div>
</template>

<script>
import Captcha from './components/Captcha.vue';
export default {
  name: 'App',
  components: {
    Captcha,
  },
};
</script>

<style>
body {
  margin: 8px;
}
</style>
