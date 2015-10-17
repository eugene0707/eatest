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

@app.controller("VacanciesShowController", [
  '$scope'
  '$stateParams'
  'VacancyService'
  ($scope, $stateParams, VacancyService)->
    $scope.vacancy = VacancyService.show($stateParams.id).then( (data)->
      $scope.vacancy = data;
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
      views:
        '':
          templateUrl: 'vacancies/index.html'
          controller: 'VacanciesIndexController'
        'vacancies_table@vacancies.index':
          resolve:
            params: ->
              items: 'vacancies'
              editable: 'true'
          templateUrl: 'shared/vacancies_table.html'
          controller: 'TableController'

    .state 'vacancies.show',
      url: '/{id}'
      views:
        '':
          templateUrl: 'vacancies/show.html'
          controller: 'VacanciesShowController'
        'skills_table@vacancies.show':
          resolve:
            params: ->
              items: 'vacancy.skills'
              editable: 'false'
          templateUrl: 'shared/skills_table.html'
          controller: 'TableController'
        'strict_applicants_table@vacancies.show':
          resolve:
            params: ->
              items: 'vacancy.strict_applicants'
              editable: 'false'
          templateUrl: 'shared/applicants_table.html'
          controller: 'TableController'
        'partial_applicants_table@vacancies.show':
          resolve:
            params: ->
              items: 'vacancy.partial_applicants'
              editable: 'false'
          templateUrl: 'shared/applicants_table.html'
          controller: 'TableController'

    .state 'vacancies.new',
      url: '/new'
      templateUrl: 'vacancies/new.html'
      controller: 'VacanciesNewController'

    .state 'vacancies.edit',
      url: '/{id}/edit'
      templateUrl: 'vacancies/edit.html'
      controller: 'VacanciesEditController'

]
