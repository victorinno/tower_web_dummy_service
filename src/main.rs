#[macro_use]
extern crate tower_web;
extern crate tokio;

use tower_web::{ServiceBuilder};

#[derive(Clone, Debug)]
pub struct Dummy;

impl_web! {
    impl Dummy {
        #[get("/")]
        #[content_type("json")]
        fn hello_world(&self) -> Result<String, ()> {
            Ok(format!("Got: {}", "Dummy get."))
        }
    }
}

pub fn main() {
    let addr = "127.0.0.1:3210".parse().expect("Invalid address");
    println!("Listening on http://{}", addr);

    ServiceBuilder::new()
        .resource(Dummy)
        .run(&addr)
        .unwrap();
}
