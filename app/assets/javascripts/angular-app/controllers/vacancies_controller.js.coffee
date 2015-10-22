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
      $scope.vacancy = data
    )
])

@app.controller("VacanciesNewController", [
  '$scope'
  '$state'
  'VacancyService'
  ($scope, $state, VacancyService)->

    $scope.save=->
      VacancyService.create(vacancy: $scope.object).then(->
        $state.transitionTo('vacancies.index')
      )
])

@app.controller("VacanciesEditController", [
  '$scope'
  '$stateParams'
  '$state'
  'VacancyService'
  ($scope, $stateParams, $state, VacancyService)->

    $scope.object = VacancyService.show($stateParams.id).then( (data)->
      $scope.object = data
      $scope.object.available_to = new Date(new Date($scope.object.available_to).getTime() - (new Date()).getTimezoneOffset()*60000)
      $scope.object.skill_ids = data.skills.map((val)-> val.id)
      delete $scope.object.skills
    )

    $scope.save=->
      $scope.object.vacancy =
        name: $scope.object.name
        available_to: $scope.object.available_to
        salary: $scope.object.salary
        phone: if $scope.object.phone then $scope.object.phone else null
        email: if $scope.object.email then $scope.object.email else null
        skill_ids: $scope.object.skill_ids

      $scope.object.put().then(->
        $state.transitionTo('vacancies.show', id: $stateParams.id)
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

    .state 'vacancies.new',
      url: '/new'
      views:
        '':
          templateUrl: 'vacancies/new.html'
          controller: 'VacanciesNewController'
        'form@vacancies.new':
          templateUrl: 'vacancies/form.html'
        'skills@vacancies.new':
          templateUrl: 'skills/skills_nested.html'
          controller: 'SkillsNestedController'

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

    .state 'vacancies.edit',
      url: '/{id}/edit'
      views:
        '':
          templateUrl: 'vacancies/edit.html'
          controller: 'VacanciesEditController'
        'form@vacancies.edit':
          templateUrl: 'vacancies/form.html'
        'skills@vacancies.edit':
          templateUrl: 'skills/skills_nested.html'
          controller: 'SkillsNestedController'

]
