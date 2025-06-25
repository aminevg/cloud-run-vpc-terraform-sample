import { randomUUIDv7 } from "bun"

const server = Bun.serve({
  port: process.env.BACKEND_PORT ?? "3000",
  routes: {
    "/random-uuid": (req) => {
      return new Response(randomUUIDv7());
    }
  }
})

console.log(`Server is running on ${server.url}`);