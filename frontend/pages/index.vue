<template>
  <v-container grid-list-md text-xs-center>
    <v-layout wrap>
      <v-flex my-3 xs12 sm6 offset-sm3 v-for="(article, index) in articles" :key="index">
        <v-card>
          <v-card-title primary-title>
            <div>
              <h3 class="headline mb-0">{{article.title}}</h3>
              <div>{{ article.content }}</div>
            </div>
          </v-card-title>

          <v-card-actions>
            <v-btn flat color="orange">Share</v-btn>
            <v-btn flat color="orange">Explore</v-btn>
          </v-card-actions>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
export default {
  // components: {  },
  async asyncData({ $axios }) {
    const articles = await $axios.$get("/articles");
    return { articles };
  },
  data() {
    return {
      articles: []
    };
  }
};
</script>
