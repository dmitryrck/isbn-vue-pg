require "rails_helper"

describe PgIsbn do
  subject { PgIsbn.new(isbn: "978014300723", digit: nil) }

  context "when digit is a nil value" do
    it "should set the digit" do
      subject.save
      expect(subject.reload.digit).to eq "4"
    end
  end

  context "when digit is an empty string" do
    subject { PgIsbn.new(isbn: "978186197271", digit: "") }

    it "should set the digit" do
      subject.save
      expect(subject.reload.digit).to eq "2"
    end
  end

  # TODO
  # Verify if this is a valid feature.
  # In some cases it may be better to do the `insert` with the values instead
  # of calculating everything in pg.
  context "when digit is already (wrong) set" do
    subject { PgIsbn.new(isbn: "978186197876", digit: "0") }

    it "should set the digit" do
      subject.save
      expect(subject.reload.digit).to eq "9"
    end
  end
end
