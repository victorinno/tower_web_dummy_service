# ------------------------------------------------------------------------------
# Cargo Build Stage
# ------------------------------------------------------------------------------

FROM rust:latest as cargo-build

RUN apt-get update

RUN apt-get install musl-tools -y

RUN rustup target add x86_64-unknown-linux-musl

WORKDIR /usr/src/tower_web_dummy_service

COPY Cargo.toml Cargo.toml

RUN mkdir src/

RUN echo "fn main() {println!(\"if you see this, the build broke\")}" > src/main.rs

RUN RUSTFLAGS=-Clinker=musl-gcc cargo build --release --target=x86_64-unknown-linux-musl

RUN rm -f target/x86_64-unknown-linux-musl/release/deps/tower_web_dummy_service*

COPY . .

RUN RUSTFLAGS=-Clinker=musl-gcc cargo build --release --target=x86_64-unknown-linux-musl

# ------------------------------------------------------------------------------
# Final Stage
# ------------------------------------------------------------------------------

FROM alpine:latest

RUN addgroup -g 1000 tower_web_dummy_service

RUN adduser -D -s /bin/sh -u 1000 -G tower_web_dummy_service tower_web_dummy_service

WORKDIR /home/tower_web_dummy_service/bin/

COPY --from=cargo-build /usr/src/tower_web_dummy_service/target/x86_64-unknown-linux-musl/release/tower_web_dummy_service .

RUN chown tower_web_dummy_service:tower_web_dummy_service tower_web_dummy_service

USER tower_web_dummy_service

CMD ["./tower_web_dummy_service"]
