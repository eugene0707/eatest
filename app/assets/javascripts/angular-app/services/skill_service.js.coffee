@app.factory('SkillService', [
  'Restangular'
  'BaseService'
  (restangular, BaseService) ->

    SkillService= ->
      BaseService.call(@, restangular, 'skills')

    BaseService.extend(SkillService)
    new SkillService
])
