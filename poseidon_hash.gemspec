Gem::Specification.new do |s|
  s.name        = "poseidon_hash"
  s.version     = "1.0.0"
  s.summary     = "Poseidon hash function"
  s.description = "Ruby implementation of Poseidon hash function"
  s.authors     = ["Nhan Vu"]
  s.email       = "nhannvu.19@gmail.com"
  s.files = Dir['{lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.homepage    = "https://github.com/nhannvu19/poseidon_hash"
  s.license     = "MIT"

  if s.respond_to?(:metadata)
    s.metadata["homepage_uri"] = s.homepage
    s.metadata["source_code_uri"] = s.homepage
  end

  s.required_ruby_version = '>= 2.1.0'
end
