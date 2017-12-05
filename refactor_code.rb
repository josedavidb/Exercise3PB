class Investment < ApplicationRecord
  def monthly_pb_commission
    if (InvestmentRound::NO_FEE_ROUNDS.include?(investment_round_id) && banned_investments.flatten.include?(id)) ||
      (id.present? && id < 3814)
      0
    elsif code.present?
      monthly_amount = monthly_amount()
      monthly_wallet_amount = (wallet_amount.to_f / investment_round.periods).round(2)

      
      commission = commission() - discount()

      commission + (commission * 0.16)
    else
      monthly_amount = (amount.to_f / investment_round.periods).round(2)
      monthly_wallet_amount = (wallet_amount.to_f / investment_round.periods).round(2)

      commission = commission() - discount()
      commission + (commission * 0.16)
    end
  end

  def monthly_pb_commission_discount
    if (InvestmentRound::NO_FEE_ROUNDS.include?(investment_round_id) && banned_investments.flatten.include?(id)) ||
      (id.present? && id < 3814)
      0
    elsif code.present?
      monthly_amount = monthly_amount()

      commission_discount = monthly_amount * discount()

      commission_discount + (commission_discount * 0.16)
    else
      0
    end
  end
end

private


def commission

  if investment_round.pb_player_fee.present?

    return (monthly_amount - monthly_wallet_amount) * ((investment_round.pb_player_fee.to_f/100)

  else

    return commission = ((monthly_amount - monthly_wallet_amount) * 0.05)

  end


end

def discount

  if investment_round.pb_player_fee.present?

    return (((investment_round.pb_player_fee.to_f/100) * code.discount) / 100.to_f)

  else

    return ((0.05 * code.discount) / 100.to_f) 

end

def monthly_amount

  return monthly_amount = (amount.to_f / investment_round.periods).round(2)

end
