# service_a/Dockerfile
FROM elixir:1.18-alpine AS builder

WORKDIR /app

# [QUAN TRỌNG] Cài thêm git và công cụ build để tránh lỗi khi tải thư viện
RUN apk add --no-cache git build-base

COPY . .
RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get --only prod
ENV MIX_ENV=prod
RUN mix release

FROM alpine:3.21
# [QUAN TRỌNG] Cài đủ thư viện hệ thống
RUN apk add --no-cache libstdc++ ncurses-libs openssl libgcc

WORKDIR /app
COPY --from=builder /app/_build/prod/rel/service_a ./

# [BẮT BUỘC] Phải có dòng này container mới chạy lệnh start được
CMD ["bin/service_b", "start"]