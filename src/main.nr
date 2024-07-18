global CANDIDATE_COUNT = 10;
global VOTER_COUNT = 2;

fn main(token_budget: u32, votes: [u32; CANDIDATE_COUNT]) {
    check_within_budget(token_budget, votes);
}

fn check_within_budget(token_budget: u32, votes: [u32; CANDIDATE_COUNT]) {
    let mut tokens_spent = 0;

    for vote in votes {
        tokens_spent += vote * vote;
    }

    assert(token_budget > tokens_spent);
}

fn sum_votes(all_votes: [u32; CANDIDATE_COUNT * VOTER_COUNT]) -> [u32; CANDIDATE_COUNT] {
    let mut total_votes = [0; CANDIDATE_COUNT];

    for i in 0..VOTER_COUNT {
        for j in 0..CANDIDATE_COUNT {
            total_votes[j] = total_votes[j] + all_votes[i * CANDIDATE_COUNT + j];
        }
    }
    total_votes
}


// #[test]
// fn test_main() {
//     main(1, 2);

//     // Uncomment to make test fail
//     // main(1, 1);
// }
