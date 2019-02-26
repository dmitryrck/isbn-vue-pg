# Benchmark beetween RubyIsbn and PgIsbn

```terminal
$ bundle exec rails runner ./benchmark/run.rb
Warming up --------------------------------------
            RubyIsbn     1.000  i/100ms
              PgIsbn     1.000  i/100ms
Calculating -------------------------------------
            RubyIsbn      5.592  (±35.8%) i/s -     24.000  in   5.081205s
              PgIsbn      6.984  (±14.3%) i/s -     33.000  in   5.055533s

Comparison:
              PgIsbn:        7.0 i/s
            RubyIsbn:        5.6 i/s - same-ish: difference falls within error
```

The result indicates that both code have similar time execution: Pg has 9 more executions but it is not worth to maintain the code.

Maybe in the future with [JIT](https://www.postgresql.org/docs/11/jit.html) JIT compiler for PG.
