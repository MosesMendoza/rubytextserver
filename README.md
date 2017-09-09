## A reference text-server ruby implementation
Given URLs, perform basic text manipulation on content retrieved from the URLs.

# Startup

Assumes ruby, rubygems and bundler are installed. If not, install ruby via your favorite package manager, then `gem install bundler`.

From the app directory:
```
bundle install --path .bundle
bundle exec puma -C config/config.rb
```

# Usage
```
curl -d "http://foo.com" http://localhost:9292
```

# Notes
* Uses [ruby-concurrency](https://github.com/ruby-concurrency/concurrent-ruby) for concurrent URL content retrieval. This is a new library to me - it's performance characteristics haven't been throughly vetted versus other ruby concurrency libraries.

* Defaults to an 8-worker implementation, as most modern macs have 8 CPUs
