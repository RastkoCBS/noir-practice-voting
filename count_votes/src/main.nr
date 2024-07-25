use dep::std;

// Global constants defining the number of candidates and voters
global CANDIDATE_COUNT = 10;
global VOTER_COUNT = 2;

// Function to sum votes for each candidate
fn sum_votes(votes: [u32; CANDIDATE_COUNT * VOTER_COUNT]) -> [u32; CANDIDATE_COUNT] {
    let mut total_votes = [0; CANDIDATE_COUNT]; // Initialize the total votes array

    // Iterate over each voter's votes
    for i in 0..VOTER_COUNT {
        // Sum the votes for each candidate
        for j in 0..CANDIDATE_COUNT {
            total_votes[j] = total_votes[j] + votes[i * CANDIDATE_COUNT + j];
        }
    }
    total_votes // Return the total votes for each candidate
}

// Function to check the validity of commitments
fn check_commitments(
    commitments: [Field; VOTER_COUNT],
    secrets: [Field; VOTER_COUNT],
    votes: [u32; VOTER_COUNT * CANDIDATE_COUNT]
) {
    // Iterate over each voter's commitments and secrets
    for i in 0..VOTER_COUNT {
        let mut transcript = [0; CANDIDATE_COUNT + 1]; // Initialize the transcript array
        transcript[0] = secrets[i]; // Set the first element of the transcript to the voter's secret

        // Loop through each candidate
        for j in 0..CANDIDATE_COUNT {
            // Convert the vote to a Field element and add it to the transcript
            transcript[j + 1] = votes[i * CANDIDATE_COUNT + j] as Field;
        }

        // Assert that the commitment matches the Pedersen commitment of the transcript
        assert(commitments[i] == std::hash::pedersen_commitment(transcript).x);
    }
}

// Main function to check commitments and sum votes
fn main(
    commitments: pub [Field; VOTER_COUNT],
    votes: [u32; VOTER_COUNT * CANDIDATE_COUNT],
    secrets: [Field; VOTER_COUNT]
) -> pub [u32; CANDIDATE_COUNT] {
    check_commitments(commitments, secrets, votes); // Check the commitments

    sum_votes(votes) // Sum the votes and return the result
}

#[test]
fn test_sum_votes() {
    let votes = [
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10,// Voter 1
        10, 9, 8, 7, 6, 5, 4, 3, 2, 1// Voter 2
    ];
    let expected_total_votes = [11, 11, 11, 11, 11, 11, 11, 11, 11, 11];
    let result = sum_votes(votes);
    assert(result == expected_total_votes);
}

fn calculate_ballot_commitment(secret: Field, votes: [u32; CANDIDATE_COUNT]) -> Field {
    let mut transcript = [0; CANDIDATE_COUNT + 1];
    transcript[0] = secret;

    for i in 0..CANDIDATE_COUNT {
        transcript[i + 1] = votes[i] as Field;
    }
    std::hash::pedersen_commitment(transcript).x
}

#[test]
fn test_check_commitments() {
    let secrets = [1, 2];

    let votes = [
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10,// Voter 1
        10, 9, 8, 7, 6, 5, 4, 3, 2, 1// Voter 2
    ];

    let commitments = [
        calculate_ballot_commitment(secrets[0], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]),
        calculate_ballot_commitment(secrets[1], [10, 9, 8, 7, 6, 5, 4, 3, 2, 1])
    ];
    check_commitments(commitments, secrets, votes);
}

#[test]
fn test_main() {
    let secrets = [1, 2];

    let commitments = [
        calculate_ballot_commitment(secrets[0], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]),
        calculate_ballot_commitment(secrets[1], [10, 9, 8, 7, 6, 5, 4, 3, 2, 1])
    ];

    let votes = [
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10,// Voter 1
        10, 9, 8, 7, 6, 5, 4, 3, 2, 1// Voter 2
    ];
    let expected_total_votes = [11, 11, 11, 11, 11, 11, 11, 11, 11, 11];
    let result = main(commitments, votes, secrets);
    assert(result == expected_total_votes);
}
