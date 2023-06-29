module Poseidon
  class Hash
    include Constant

    def s_box(x)
      p = 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001
      a = (x * x) % p
      b = (a * a) % p
      (x * b) % p
    end

    def dotprod(a, b)
      p = 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001
      raise 'Length of a and b must be equal' unless a.length == b.length

      res = 0
      for i in 0...a.length
        res += ((a[i] * b[i]) % p)
      end
      res % p
    end

    def matrix_multiply(m, x)
      b = []
      raise 'M must be a square matrix' unless m.length == m[0].length
      raise 'Length of M and x must be equal' unless m.length == x.length

      for i in 0...x.length
        b << dotprod(m[i], x)
      end
      b
    end

    def perm(input_words, t)
      p = 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001
      raise 'Length of input_words must be equal to t' unless input_words.length == t

      rp = get_RP(t)
      rf = 4
      m = get_mds(t)
      rc = get_round_constants(t)
      state_words = input_words.dup

      rc_counter = 0
      # First full rounds
      for r in 0...rf
        # Round constants, nonlinear layer, matrix multiplication
        for i in 0...t
          state_words[i] = (state_words[i] + rc[rc_counter]) % p
          rc_counter += 1
        end
        for i in 0...t
          state_words[i] = s_box(state_words[i])
        end
        state_words = matrix_multiply(m, state_words)
      end

      # Middle partial rounds
      for r in 0...rp
        # Round constants, nonlinear layer, matrix multiplication
        for i in 0...t
          state_words[i] = (state_words[i] + rc[rc_counter]) % p
          rc_counter += 1
        end
        state_words[0] = s_box(state_words[0])
        state_words = matrix_multiply(m, state_words)
      end

      # Last full rounds
      for r in 0...rf
        # Round constants, nonlinear layer, matrix multiplication
        for i in 0...t
          state_words[i] = (state_words[i] + rc[rc_counter]) % p
          rc_counter += 1
        end
        for i in 0...t
          state_words[i] = s_box(state_words[i])
        end
        state_words = matrix_multiply(m, state_words)
      end

      raise 'rc_counter must be equal to length of RC' unless rc_counter == rc.length

      state_words
    end

    def hash(input, arity)
      raise 'The length of the input must be equal to the arity' unless input.length == arity

      copied_input = input.dup
      state = [0] + copied_input
      output = perm(state, arity + 1)
      output[0]
    end

    def linear_hash_many(inputs, arity = 16)
      # base case
      if inputs.length <= arity
        base_hash_inputs = inputs + ([0] * (arity - inputs.length))
        current_hash = hash(base_hash_inputs, arity)
        remaining_inputs = []
      else
        base_hash_inputs = inputs[0...arity]
        remaining_inputs = inputs[arity..-1]
        current_hash = hash(base_hash_inputs, arity)
      end

      while remaining_inputs.length > 0
        if remaining_inputs.length <= arity - 1
          hash_inputs = [current_hash] + remaining_inputs + ([0] * (arity - remaining_inputs.length - 1))
          remaining_inputs = []
          current_hash = hash(hash_inputs, arity)
        else
          hash_inputs = [current_hash] + remaining_inputs[0...arity - 1]
          remaining_inputs = remaining_inputs[arity - 1..-1]
          current_hash = hash(hash_inputs, arity)
        end
      end

      current_hash
    end
  end
end
