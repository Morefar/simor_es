module ContractsHelper
  def contract_periodicity(periodicity)
    case periodicity
    when 1
      return t 'contracts.form.months'
    when 3
      return t 'contracts.form.quarters'
    when 6
      return t 'contracts.form.semesters'
    when 12
      return t 'contracts.form.years'
    end
  end
end
