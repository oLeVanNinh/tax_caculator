require 'pry'

module PersonalTaxIncome
  extend self

  def get_family_deduction(number_of_people_dependent)
    9000000 + 3600000 * number_of_people_dependent
  end

  def get_insurance_deduction(total_income)
    social_insurance_rate = 0.08
    health_insurance_rate = 0.015
    voluntary_insurance_rate = 0.01
    total_income * (social_insurance_rate + health_insurance_rate + voluntary_insurance_rate)
  end

  def get_taxable_income(total_income, family_deduction, insurance_deduction)
    taxable_income = total_income - family_deduction - insurance_deduction
    taxable_income < 0 ? 0 : taxable_income
  end

  def get_personal_income_tax(taxable_income)
    percent_rate, constant_tax_reduce_number = get_coefficient_for_tax_caculation(taxable_income)
    taxable_income * percent_rate - constant_tax_reduce_number
  end

  def get_coefficient_for_tax_caculation(taxable_income)
    case
    when taxable_income < 0
      [0, 0]
    when taxable_income <= 5000000
      [0.05, 0]
    when taxable_income <= 10000000
      [0.1, 250000]
    when taxable_income <= 18000000
      [0.15, 750000]
    when taxable_income <= 32000000
      [0.2, 1650000]
    when taxable_income <= 52000000
      [0.25, 3250000]
    when taxable_income <= 80000000
      [0.3, 5850000]
    else
      [0.35, 9850000]
    end
  end
end
