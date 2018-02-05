class ReferrerDecorator < ApplicationDecorator
  delegate_all

  decorates :referrer

  def decorate_name
    standard_wrapper 'Name:', referrer.name
  end

  def decorate_organisation
    standard_wrapper 'Organisation or service:', OrganisationOption.display([referrer.organisation])
  end

  def decorate_email
    standard_wrapper 'Email:', h.mail_to(referrer.email)
  end

  def decorate_phone
    standard_wrapper 'Tel:', referrer.phone
  end

  def decorate_reason
    standard_wrapper 'Reason for referral:', referrer.reason
  end

end
