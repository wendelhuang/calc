class SalaryController < ApplicationController
    PANSION_RATE_PERSON = 0.08
    MEDICARE_RATE_PERSON = 0.02
    UNEMPLOYMENT_RATE_PERSON = 0.002
    HOUSE_FUND_RATE_PERSON = 0.12

    MAX_HOUSE_FUND = 21258.0

    # 养老保险
    PANSION_RATE_COMMPANY = 0.2
    # 医疗保险
    MEDICARE_RATE_COMMPANY = 0.06
    # 失业保险
    UNEMPLOYMENT_RATE_COMMPANY = 0.015
    # 工商保险
    EMPLOYMENT_INJURY_RATE_COMMPANY = 0.005
    # 生育保险
    MATERNITY_RATE_COMMPANY = 0.008
    # 住房公积金
    HOUSE_FUND_RATE_PERSON = 0.12

    TAX_FREE_AMOUNT = 3500.0
  def index
  end
  def calc

    @amount = params[:amount].nil? ? 0 : params[:amount].to_f
    @pension = @amount * PANSION_RATE_PERSON
    @medicare = @amount * MEDICARE_RATE_PERSON
    @unemployment = @amount * UNEMPLOYMENT_RATE_PERSON
    @house_fund = @amount > MAX_HOUSE_FUND ? MAX_HOUSE_FUND*HOUSE_FUND_RATE_PERSON : @amount*HOUSE_FUND_RATE_PERSON

    @taxable_income  = @amount - @pension - @medicare - @unemployment - @house_fund - TAX_FREE_AMOUNT

    @tax_rate_table = []
    @tax_rate_table << {range: (0..0), tax_rate: 0.0, quick_deduction: 0.0}
    @tax_rate_table << {range: (1..1500), tax_rate: 0.03, quick_deduction: 0.0}
    @tax_rate_table << {range: (1501..4500), tax_rate: 0.1, quick_deduction: 105.0}
    @tax_rate_table << {range: (4501..9000), tax_rate: 0.2, quick_deduction: 555.0}
    @tax_rate_table << {range: (9001..35000), tax_rate: 0.25, quick_deduction: 1005.0}
    @tax_rate_table << {range: (35001..55000), tax_rate: 0.30, quick_deduction: 2755.0}
    @tax_rate_table << {range: (55001..80000), tax_rate: 0.35, quick_deduction: 5505.0}
    @tax_rate_table << {range: (80001..80001), tax_rate: 0.45, quick_deduction: 13505.0}

    if @taxable_income < 0
      @iterator = 0
    elsif @taxable_income > 80000
      @iterator = @tax_rate_table.length - 1
    else
      for i in 1..@tax_rate_table.length-1
        if @tax_rate_table[i][:range].include?(@taxable_income)
          @iterator = i
          break
        end
      end
    end

    @tax = @taxable_income * @tax_rate_table[@iterator][:tax_rate] - @tax_rate_table[@iterator][:quick_deduction]

    @income = @amount - @pension - @medicare - @unemployment - @house_fund - @tax
  end
end
