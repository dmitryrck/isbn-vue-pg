require "rails_helper"

describe RubyIsbn do
  subject do
    RubyIsbn.new(isbn: "978014300723")
  end

  it "should set the digit" do
    expect { subject.save }.to change { subject.digit }.to("4")
  end
end
