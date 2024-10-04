# :nocov:
class StaticController < ApplicationController

  def apprenticeships; end

  def hackney100; end

  def support
    redirect_to 'http://opportunities.hackney.gov.uk/'
  end

  def employers; end

  def privacy_policy; end

  def outside_hackney; end

  def referrer_outside_hackney; end

  def just_registered; end

  def unsubscribed; end

end
# :nocov:
