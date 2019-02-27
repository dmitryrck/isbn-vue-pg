<template>
  <div class="container">
    <div class="py-5 text-center">
      <h2>ISBN-13 check digit calculation</h2>

      <p class="lead">
        Read more in <a href="https://en.wikipedia.org/wiki/International_Standard_Book_Number">Wikipedia</a>
      </p>
    </div>

    <RouterView />

    <footer class="my-5 pt-5 text-muted text-center text-small">
      <p class="mb-1">&copy; 2017-2019 Dmitry L Rocha</p>
      <ul class="list-inline">
        <li class="list-inline-item"><a href="https://github.com/dmitryrck/isbn-vue-pg">Source code</a></li>
      </ul>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
.bd-placeholder-img {
  font-size: 1.125rem;
  text-anchor: middle;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

@media (min-width: 768px) {
  .bd-placeholder-img-lg {
    font-size: 3.5rem;
  }
}
</style>
