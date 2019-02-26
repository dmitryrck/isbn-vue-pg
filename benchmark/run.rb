require "benchmark/ips"

codes = [
  "978014300723",
  "978140289462",
  "978156619909",
  "978186197271",
  "978186197876",
  "978316148410",
]

Benchmark.ips do |x|
  x.report("RubyIsbn") do
    codes.each do |code|
      RubyIsbn.new(isbn: code).save
    end

    ActiveRecord::Base.connection.execute("truncate ruby_isbns;")
  end
  x.report("PgIsbn") do
    codes.each do |code|
      PgIsbn.new(isbn: code).save
    end

    ActiveRecord::Base.connection.execute("truncate pg_isbns;")
  end
  x.compare!
end
