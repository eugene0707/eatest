@app.factory('ApplicantService', [
  'Restangular'
  'BaseService'
  (restangular, BaseService) ->

    ApplicantService= ->
      BaseService.call(@, restangular, 'applicants')

    BaseService.extend(ApplicantService)
    new ApplicantService
])
