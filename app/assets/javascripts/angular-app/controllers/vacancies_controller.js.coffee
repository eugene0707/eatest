@app.controller("VacanciesIndexController", [
  '$scope'
  'VacancyService'
  ($scope, VacancyService)->
    $scope.vacancies = VacancyService.index()
    $scope.delete = (data, message)->
      return if !confirm(message)
      VacancyService.destroy(data).then(->
        $scope.vacancies = VacancyService.index()
      )

])

@app.config [
  '$stateProvider'
  ($stateProvider) ->

    $stateProvider
    .state 'vacancies',
      abstract: true
      url: '/vacancies'
      template: '<div ui-view />'

    .state 'vacancies.index',
      url: ''
      templateUrl: 'vacancies/index.html'
      controller: 'VacanciesIndexController'

    .state 'vacancies.show',
      url: '/{id}'
      templateUrl: 'vacancies/show.html'
      controller: 'VacanciesShowController'

    .state 'vacancies.new',
      url: '/new'
      templateUrl: 'vacancies/new.html'
      controller: 'VacanciesNewController'

    .state 'vacancies.edit',
      url: '/{id}/edit'
      templateUrl: 'vacancies/edit.html'
      controller: 'VacanciesEditController'

]
