VNPay
========

A Ruby implementation of ZK-SNARK friendly hash function Poseidon

Introduction
------------

VNPAY Payment Gateway is an intermediate system to transmit, exchange and process payment transactions between consumers owning card, bank account or e-wallet and enterprises providing goods, services on the Internet.

Installation
------------

### Bundler

Add the Airbrake gem to your Gemfile:

```ruby
gem 'vnpay'
```

### Manual

Invoke the following command from your terminal:

```bash
gem install vnpay
```

### Usage

```ruby
arity = 4
input = [1503630248886929420551238620595986459413104881269505529735919576753875242303, 4398046511124, 0, 0]

Poseidon::Hash.new.hash(input, arity)
```

