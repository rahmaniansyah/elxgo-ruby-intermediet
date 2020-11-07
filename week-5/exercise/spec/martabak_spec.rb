require './models/martabak'

describe Martabak do
 it "is delicious" do
 martabak = Martabak.new("martabak cokelat is delicious")
 taste = martabak.taste
 expect(taste).to eq("martabak cokelat is delicious")
 end
end