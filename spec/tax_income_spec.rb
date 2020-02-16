describe "PersonalTaxIncome" do
  describe "#get_coefficient_for_tax_caculation" do
    subject(:coefficient_for_tax_caculation) { PersonalTaxIncome.get_coefficient_for_tax_caculation(taxable_income) }
    context "when the taxable number is less than 0" do
      let(:taxable_income)  { -rand(10000) }
      it "should return 0 for both rate and constant" do
        percent_rate, tax_reduce_number = coefficient_for_tax_caculation
        expect(percent_rate).to eq(0)
        expect(tax_reduce_number).to eq(0)
      end
    end

    context "when the taxable number is greater than 0 and less than 5000000" do
      let(:taxable_income)  { rand(0..5000000) }
      it "should return 5% for rate and 0 for tax reduce number" do
        percent_rate, tax_reduce_number = coefficient_for_tax_caculation
        expect(percent_rate).to eq(0.05)
        expect(tax_reduce_number).to eq(0)
      end
    end

    context "when the taxable number is greater than 5000000 and less than 10000000" do
      let(:taxable_income)  { rand(5000000..10000000) }
      it "should return 10% for rate and 250000 for tax reduce number" do
        percent_rate, tax_reduce_number = coefficient_for_tax_caculation
        expect(percent_rate).to eq(0.1)
        expect(tax_reduce_number).to eq(250000)
      end
    end

    context "when the taxable number is greater than 10000000 and less than 18000000" do
      let(:taxable_income)  { rand(10000000..18000000) }
      it "should return 15% for rate and 750000 for tax reduce number" do
        percent_rate, tax_reduce_number = coefficient_for_tax_caculation
        expect(percent_rate).to eq(0.15)
        expect(tax_reduce_number).to eq(750000)
      end
    end

    context "when the taxable number is greater than 18000000 and less than 32000000" do
      let(:taxable_income)  { rand(18000000..32000000) }
      it "should return 20% for rate and 1650000 for tax reduce number" do
        percent_rate, tax_reduce_number = coefficient_for_tax_caculation
        expect(percent_rate).to eq(0.2)
        expect(tax_reduce_number).to eq(1650000)
      end
    end

    context "when the taxable number is greater than 32000000 and less than 52000000" do
      let(:taxable_income)  { rand(32000000..52000000) }
      it "should return 25% for rate and 3250000 for tax reduce number" do
        percent_rate, tax_reduce_number = coefficient_for_tax_caculation
        expect(percent_rate).to eq(0.25)
        expect(tax_reduce_number).to eq(3250000)
      end
    end

    context "when the taxable number is greater than 52000000 and less than 80000000" do
      let(:taxable_income)  { rand(52000000..80000000) }
      it "should return 30% for rate and 5850000 for tax reduce number" do
        percent_rate, tax_reduce_number = coefficient_for_tax_caculation
        expect(percent_rate).to eq(0.3)
        expect(tax_reduce_number).to eq(5850000)
      end
    end

    context "when the taxable number is greater than 80000000" do
      let(:taxable_income)  { rand(80000000..(10 * 80000000)) }
      it "should return 30% for tax rate and 9850000 for tax reduce number" do
        percent_rate, tax_reduce_number = coefficient_for_tax_caculation
        expect(percent_rate).to eq(0.35)
        expect(tax_reduce_number).to eq(9850000)
      end
    end
  end

  describe "get_personal_income_tax" do
    subject { PersonalTaxIncome.get_personal_income_tax(taxable_income) }
    context "when taxable income is 0" do
      let(:taxable_income) { 0 }
      it { is_expected.to eq(0) }
    end

    context "when taxable income is from 0 to 5000000" do
      context "when taxable income is 1000000" do
        let(:taxable_income) { 1000000 }
        it { is_expected.to eq(50000) }
      end

      context "when taxable income is 5000000" do
        let(:taxable_income) { 5000000 }
        it { is_expected.to eq(250000) }
      end
    end

    context "when taxable income is from 5000001 to 10000000" do
      context "when taxable income is 7000000" do
        let(:taxable_income) { 7000000 }
        it { is_expected.to eq(450000) }
      end

      context "when taxable income is 1000000" do
        let(:taxable_income) { 10000000 }
        it { is_expected.to eq(750000) }
      end
    end

    context "when taxable income is from 10000000 to 18000000" do
      context "when taxable income is 7000000" do
        let(:taxable_income) { 12000000 }
        it { is_expected.to eq(1050000) }
      end

      context "when taxable income is 1800000" do
        let(:taxable_income) { 18000000 }
        it { is_expected.to eq(1950000) }
      end

      context "when taxable income is from 18000000 to 32000000" do
        context "when taxable income is 19000000" do
          let(:taxable_income) { 19000000 }
          it { is_expected.to eq(2150000) }
        end

        context "when taxable income is 32000000" do
          let(:taxable_income) { 32000000 }
          it { is_expected.to eq(4750000) }
        end
      end

      context "when taxable income is from 32000000 to 52000000" do
        context "when taxable income is 40000000" do
          let(:taxable_income) { 40000000 }
          it { is_expected.to eq(6750000) }
        end

        context "when taxable income is 52000000" do
          let(:taxable_income) { 52000000 }
          it { is_expected.to eq(9750000) }
        end
      end

      context "when taxable income is from 52000000 to 80000000" do
        context "when taxable income is 60000000" do
          let(:taxable_income) { 60000000 }
          it { is_expected.to eq(12150000) }
        end

        context "when taxable income is 80000000" do
          let(:taxable_income) { 80000000 }
          it { is_expected.to eq(18150000) }
        end
      end

      context "when taxable income is greater than 80000000" do
        context "when taxable income is 81000000" do
          let(:taxable_income) { 81000000 }
          it { is_expected.to eq(18500000) }
        end

        context "when taxable income is 200000000" do
          let(:taxable_income) { 200000000 }
          it { is_expected.to eq(60150000) }
        end
      end
    end
  end

  describe "#get_family_deduction" do
    context "when number of people dependent is 0" do
      it "should return 9000000" do
        expect(PersonalTaxIncome.get_family_deduction(0)).to eq(9000000)
      end
    end

    context "when number of people dependent is 1" do
      it "should return 9000000" do
        expect(PersonalTaxIncome.get_family_deduction(1)).to eq(12600000)
      end
    end

    context "when number of people dependent is 2" do
      it "should return 9000000" do
        expect(PersonalTaxIncome.get_family_deduction(2)).to eq(16200000)
      end
    end
  end

  describe "#get_insurance_deduction" do
    subject { PersonalTaxIncome.get_insurance_deduction(total_income) }
    context "when total income is 0" do
      let(:total_income) { 0 }
      it { is_expected.to eq(0) }
    end

    context "when total income is 12600000" do
      let(:total_income) { 12600000 }
      it { is_expected.to eq(1323000) }
    end

    context "when total income is 287803021" do
      let(:total_income) { 287803021 }
      it { is_expected.to eq(30219317.205) }
    end
  end
end
