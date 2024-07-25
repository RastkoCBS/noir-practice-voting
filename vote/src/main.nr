use dep::std;

// Global constants defining the number of candidates and voters
global CANDIDATE_COUNT = 10;
global VOTER_COUNT = 2;

// Function to check if the total votes are within the given token budget
fn check_within_budget(token_budget: u32, votes: [u32; CANDIDATE_COUNT]) {
    let mut tokens_spent = 0; // Initialize the tokens spent counter

    // Calculate the total tokens spent by summing the square of each vote
    for vote in votes {
        tokens_spent += vote * vote;
    }

    // Ensure the total tokens spent does not exceed the token budget
    assert(token_budget > tokens_spent);
}

// Function to calculate the Pedersen commitment for a ballot
fn calculate_ballot_commitment(secret: Field, votes: [u32; CANDIDATE_COUNT]) -> Field {
    let mut transcript = [0; CANDIDATE_COUNT + 1]; // Initialize the transcript array
    transcript[0] = secret; // Set the first element of the transcript to the secret

    // Convert each vote to a Field element and add to the transcript
    for i in 0..CANDIDATE_COUNT {
        transcript[i + 1] = votes[i] as Field;
    }

    // Compute and return the x-coordinate of the Pedersen commitment
    std::hash::pedersen_commitment(transcript).x
}

// Main function to validate the token budget and calculate the ballot commitment
fn main(token_budget: u32, votes: [u32; CANDIDATE_COUNT], secret: Field) -> pub Field {
    check_within_budget(token_budget, votes); // Validate the token budget

    calculate_ballot_commitment(secret, votes) // Calculate and return the ballot commitment
}

#[test]
fn test_check_within_budget() {
    let token_budget = 500;
    let votes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    check_within_budget(token_budget, votes);
}

#[test]
fn test_calculate_ballot_commitment() {
    let secret = 1;
    let votes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    let commitment = calculate_ballot_commitment(secret, votes);

    let expected_commitment: Field = 12676019597806020065447891055726303977947669756601994211670686731294852130065;

    assert(commitment == expected_commitment);
}

#[test]
fn test_main() {
    let token_budget = 500;
    let votes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    let secret = 1;
    let expected_commitment = calculate_ballot_commitment(secret, votes);
    let result = main(token_budget, votes, secret);

    assert(result == expected_commitment);
}
