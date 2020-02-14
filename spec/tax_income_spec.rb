describe "say hello" do
  it "return 2 message" do
    tax_income = TaxIncome.say_hello
    expect(tax_income).to eq("2")
  end
end
