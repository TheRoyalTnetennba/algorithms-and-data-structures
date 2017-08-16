require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  perms = string.chars.permutation.to_a
  perms.each do |word|
    return true if word == word.reverse
  end
  return false
end
