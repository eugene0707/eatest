module Api
  class SkillsController < Api::BaseController

    private

    def skill_params
      params.require(:skill).permit(:name)
    end

  end
end