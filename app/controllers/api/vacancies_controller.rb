module Api
  class VacanciesController < Api::BaseController

    private

    def vacancy_params
      params.require(:vacancy)[:skill_ids] ||= [] if params.require(:vacancy).has_key?(:skill_ids)
      params.require(:vacancy).permit(:name, :available_to, :salary, :phone, :email, skill_ids: [])
    end

  end
end