require "rails_helper"

describe RubyIsbn do
  subject do
    RubyIsbn.new(isbn: "978014300723")
  end

  it { is_expected.to be_valid }

  (1.upto(11).to_a + 13.upto(15).to_a).each do |number|
    it "should not be valid with a #{number} digit isbn" do
      subject.isbn = "1" * 10
      expect(subject).not_to be_valid
    end
  end

  it "should set the digit" do
    expect { subject.save }.to change { subject.digit }.to("4")
  end
end
