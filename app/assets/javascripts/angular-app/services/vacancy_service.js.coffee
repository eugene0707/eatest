@app.factory('VacancyService', [
  'Restangular'
  'BaseService'
  (restangular, BaseService) ->

    VacancyService= ->
      BaseService.call(@, restangular, 'vacancies')

    BaseService.extend(VacancyService)
    new VacancyService
])
