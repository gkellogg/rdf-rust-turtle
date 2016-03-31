extern crate rlibc;

#[no_mangle]
// Parses N-Triples and N-Quads from the input stream and yields 3- or 4-tuples
pub extern fn parse_nt(n: i32) -> i32 {
    // ...
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
    }
}
