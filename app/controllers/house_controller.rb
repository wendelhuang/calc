class HouseController < ApplicationController
  def mortgage
  end
  def calc
    amount = params[:amount]
    rate = params[:rate]
    year = params[:year]
    method = params[:method]

    @amount = amount.to_f
    @rate = rate.to_f
    @rate_month = @rate/100/12
    @year = year.to_i
    @method=method
    
    @terms = @year*12
    @repayment = []

    # 等额本金
    if (@method=='1')
      @principle_per_month = @amount/@terms
      @principle_repaied = 0
      @interest_repaied = 0
      for i in 1..@terms
        interest = (@amount-@principle_repaied)*@rate_month
        @interest_repaied += interest
        @principle_repaied += @principle_per_month
        @repayment << {term: i,
                       principle: @principle_per_month,
                       interest: interest,
                       principle_repaied: @principle_repaied,
                       interest_repaied: @interest_repaied}
      end
    else
      @x = BigDecimal.new(@rate_month+1, 0)**@terms
      @x = @x.to_f
      @X = @amount*@rate_month*@x/(@x-1)
      @principle_repaied = 0
      @interest_repaied = 0
      for i in 1..@terms
        interest = (@amount-@principle_repaied)*@rate_month
        @interest_repaied += interest
        @principle_repaied += (@X-interest)
        @repayment << {term: i,
                       principle: @X-interest,
                       interest: interest,
                       principle_repaied: @principle_repaied,
                       interest_repaied: @interest_repaied}
      end
    end
  end
end
