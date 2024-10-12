class BoostsController < ApplicationController
  include BubbleScoped, BucketScoped

  def create
    @bubble.boost!
  end
end
