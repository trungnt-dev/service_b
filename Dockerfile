# Dockerfile (Phiên bản Debian - Bao chạy)
FROM elixir:1.18.3-otp-27 AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y build-essential git && apt-get clean
COPY . .
RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get --only prod
ENV MIX_ENV=prod
RUN mix release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y libstdc++6 libncurses5 libssl-dev locales && apt-get clean
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
WORKDIR /app
COPY --from=builder /app/_build/prod/rel/service_b ./
# Sửa service_a thành service_b nếu là repo của B
CMD ["bin/service_b", "start"]