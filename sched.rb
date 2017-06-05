
require 'z3'

# Model
# - Slots are organized into consecurive sequences
# - Each sequence is part of a track
# - Each track is part of a day
# - Each slot has a time
#
# Hard
# - No speaker can speak twice at the same time
# - Multi-blocks take up consecutive slots
# - Only one talk-block per slot


