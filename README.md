Poseidon Hash
========

A Ruby implementation of ZK-SNARK friendly hash function [Poseidon](https://www.poseidon-hash.info/) 


Installation
------------

### Bundler

Add the gem to your Gemfile:

```ruby
gem 'poseidon_hash'
```

### Manual

Invoke the following command from your terminal:

```bash
gem install poseidon_hash
```

### Usage

```ruby
arity = 4
input = [1503630248886929420551238620595986459413104881269505529735919576753875242303, 4398046511124, 0, 0]

Poseidon::Hash.new.hash(input, arity)
```

## Contributing

If you have problems or improvements, please create a [GitHub Issue](https://github.com/nhannvu19/poseidon_hash/issues).

Thank you, contributors!

## License

This code is free to use under the terms of the MIT license.
