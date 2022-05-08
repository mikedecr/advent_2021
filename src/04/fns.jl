# Functions

"(bool) tests a single axis for bingo"
function is_axis_bingo(axis, pulls)
    all((value in pulls) for value in axis)
end

" (bool) applies single-axis function to a all rows/cols on a card"
function check_bingo(card, pulls)
    # iterate on both rows and columns
    iter_card_axes = Iterators.flatten(((eachrow(card), eachcol(card))))
    bingos = Iterators.map(axis -> is_axis_bingo(axis, pulls), iter_card_axes)
    any(bingos)
end

"""returns winning card if bingo"""
function play_bingo_round(cards, pulls)
    bingos = map(card -> check_bingo(card, pulls), cards)
    @assert (sum(bingos) in [0, 1]) "No unique winner"
    if any(bingos)
        # why did we have an additional index here?
        return cards[bingos][1]
    end
end

"""iterate rounds over a "stream" of pulls
   return winning card + pulled values"""
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

