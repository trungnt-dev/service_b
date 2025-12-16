# service_b/Dockerfile
FROM elixir:1.15-alpine AS builder
WORKDIR /app
COPY . .
RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get --only prod
ENV MIX_ENV=prod
RUN mix release

FROM alpine:3.21
RUN apk add --no-cache libstdc++ ncurses-libs openssl
WORKDIR /app
COPY --from=builder /app/_build/prod/rel/service_b ./
CMD ["bin/service_b", "start"]