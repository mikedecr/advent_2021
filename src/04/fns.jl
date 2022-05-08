# Functions

function is_axis_bingo(axis, draws)
    all((value in draws) for value in axis)
end


function check_bingo(card, draws)
    # iterate on both rows and columns
    iter_card_axes = Iterators.flatten(((eachrow(card), eachcol(card))))
    # check axis for each axis
    bingo_axes = Iterators.map(axis -> is_axis_bingo(axis, draws), iter_card_axes)
    any(bingo_axes)
end

# returns winning card if bingo
function play_bingo_round(cards, draws)
    bingos = map(card -> check_bingo(card, draws), cards)
    @assert (sum(bingos) in [0, 1]) "No unique winner"
    if any(bingos)
        # why did we have an additional index here?
        return cards[bingos][1]
    end
end

# iterate rounds over a "stream" of draws, return winning card + pulls
function play_bingo(cards, stream)
    winner = nothing
    pulls = []
    local remaining_pulls = copy(stream)
    while isnothing(winner)
        push!(pulls, popfirst!(remaining_pulls))
        winner = play_bingo_round(cards, pulls)
    end
    return (winner, pulls)
end


# calculate score
function winning_score(card, pulls)
    unmatched = map(n -> n * !(n in pulls), card)
    sum(unmatched) * last(pulls)
end

