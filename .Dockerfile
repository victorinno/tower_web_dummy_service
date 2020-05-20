FROM rustlang/rust:nightly
MAINTAINER rotc21@gmail.com

WORKDIR /var/www/dummy/

COPY Cargo.toml Cargo.toml
COPY ./src/. /src/

RUN ls -la /src/*

RUN cargo build --release

ENTRYPOINT [ "./target/release/tower_web_dummy_service" ]