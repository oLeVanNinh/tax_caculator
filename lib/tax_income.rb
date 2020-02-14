module TaxIncome
  extend self

  def say_hello
    "2"
  end

  def get_taxable_income
    @total_income - @reduce_1 - @reduce_2
  end
end
