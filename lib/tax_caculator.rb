require_relative './tax_income'

class TaxCaculator
  include PersonalTaxIncome
  def get_number(obj_name)
    print "Enter #{obj_name}: "
    number = gets.chomp
    number = validate_input_number(number)
    Integer(number)
  end

  def validate_input_number(numb)
    loop do
      break if numb =~ /^-?[0-9]+$/
      puts "Invalid, input again"
      numb = gets.chomp
    end

    numb
  end

  def run
    total_income = get_number("total income")
    number_of_dependent_people = get_number("amount of dependent people")
    family_deduction = get_family_deduction(number_of_dependent_people)
    insurance_deduction = get_insurance_deduction(total_income)
    taxable_income = get_taxable_income(total_income, family_deduction, insurance_deduction)
    personal_tax_income = get_personal_income_tax(taxable_income)
    puts "Your personal tax income is #{personal_tax_income}"
  end
end
