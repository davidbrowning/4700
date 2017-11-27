use std::io;

fn main() {
    println!("Guess the number");
    println!("Input Guess:");
    let mut guess = String::new();
    io::stdin().read_line(&mut guess)
      .expect("Failed to readline");
    println!("You guessed: {}", guess);
}
