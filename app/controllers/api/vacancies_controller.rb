module Api
  class VacanciesController < Api::BaseController

    private

    def vacancy_params
      params.require(:vacancy).permit(:name, :available_to, :salary, :phone, :email, skill_ids: [])
    end

  end
end