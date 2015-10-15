module Api
  class ApplicantsController < Api::BaseController

    private

    def applicant_params
      params.require(:applicant).permit(:name, :phone, :email, :is_active, :salary, skill_ids: [])
    end

  end
end