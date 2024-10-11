# Noir Voting System - Practice Project

This repository contains a practice project demonstrating how to implement a simple voting system using the Noir programming language. Noir is a zero-knowledge proof (ZKP) focused language that allows developers to create private and verifiable computations. The goal of this project is to provide a hands-on example for learning how to build applications using Noir.

## Project Overview


This project implements a basic voting system where users can vote anonymously, and their votes are validated in zero-knowledge. The project showcases how to create and verify ZK circuits using Noir. It’s a great starting point for those interested in exploring Noir and understanding how ZKP-based voting mechanisms work.

### Features:

- Anonymous Voting: Voters can submit their votes without revealing their identity.
- Vote Validation: All votes are verified using a ZKP to ensure integrity and correctness.
- Simple Circuit Design: Easy-to-understand Noir circuits to help developers get familiar with the language and ZK concepts.

## Requirements

- Noir installed on your machine.
- Basic understanding of zero-knowledge proofs and Noir syntax.

## Setup Instructions

1. Clone the repository:
``` bash 
git clone https://github.com/RastkoCBS/noir-practice-voting.git
```

2. Install Noir: Follow the installation guide on the [official website](https://noir-lang.org/docs).

3. Navigate to the project directory:
``` bash
cd noir-practice-voting
```
4. Compile the Noir circuits:
``` bash
nargo check
```

### How the Voting System Works
1. A user casts a vote by providing input through a Noir circuit.
2. The system validates the vote without revealing the voter's identity or choice.
3. Zero-knowledge proofs ensure the votes are counted correctly and securely.

### Future Improvements
1. Add more complex vote counting mechanisms.
2. Integrate with a frontend to simulate a real-world voting application.
3. Implement additional privacy features like tallying votes in zero-knowledge.

## Contributing
Feel free to fork this repository, submit issues, or contribute via pull requests. This project is for educational purposes and any contributions to improve or expand upon it are welcome!

## License
This project is open-source and available under the MIT License.
