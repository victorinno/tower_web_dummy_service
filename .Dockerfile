FROM rustlang/rust:nightly

MAINTAINER rotc21@gmail.com

WORKDIR /var/www/tower_web_dummy_service/

COPY Cargo.toml Cargo.toml
COPY src/. src/

RUN cargo build --release

EXPOSE 3210

ENTRYPOINT [ "./target/release/tower_web_dummy_service" ]
