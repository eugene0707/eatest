@app.controller("ApplicantsIndexController", [
  '$scope'
  'ApplicantService'
  ($scope, ApplicantService)->
    $scope.applicants = ApplicantService.index()
    $scope.delete = (data, message)->
      return if !confirm(message)
      ApplicantService.destroy(data).then(->
        $scope.applicants = ApplicantService.index()
      )

])

@app.controller("ApplicantsShowController", [
  '$scope'
  '$stateParams'
  'ApplicantService'
  ($scope, $stateParams, ApplicantService)->
    $scope.applicant = ApplicantService.show($stateParams.id).then( (data)->
      $scope.applicant = data;
    )
])

@app.controller("ApplicantsNewController", [
  '$scope'
  '$state'
  'ApplicantService'
  ($scope, $state, ApplicantService)->
    $scope.save=->
      ApplicantService.create(applicant: $scope.applicant).then(->
        $state.transitionTo('applicants.index')
      )
])

@app.controller("ApplicantsEditController", [
  '$scope'
  '$stateParams'
  '$state'
  'ApplicantService'
  ($scope, $stateParams, $state, ApplicantService)->
    $scope.applicant = ApplicantService.show($stateParams.id).then( (data)->
      $scope.applicant = data
    )

    $scope.save=->
      $scope.applicant.put().then(->
        $state.transitionTo('applicants.show', id: $stateParams.id)
      )
])

@app.config [
  '$stateProvider'
  ($stateProvider) ->

    $stateProvider
    .state 'applicants',
      abstract: true
      url: '/applicants'
      template: '<div ui-view />'

    .state 'applicants.index',
      url: ''
      views:
        '':
          templateUrl: 'applicants/index.html'
          controller: 'ApplicantsIndexController'
        'applicants_table@applicants.index':
          resolve:
            params: ->
              items: 'applicants'
              editable: 'true'
          templateUrl: 'shared/applicants_table.html'
          controller: 'TableController'

    .state 'applicants.new',
      url: '/new'
      views:
        '':
          templateUrl: 'applicants/new.html'
          controller: 'ApplicantsNewController'
        'form@applicants.new':
          templateUrl: 'applicants/form.html'

    .state 'applicants.show',
      url: '/{id}'
      views:
        '':
          templateUrl: 'applicants/show.html'
          controller: 'ApplicantsShowController'
        'skills_table@applicants.show':
          resolve:
            params: ->
              items: 'applicant.skills'
              editable: 'false'
          templateUrl: 'shared/skills_table.html'
          controller: 'TableController'
        'strict_vacancies_table@applicants.show':
          resolve:
            params: ->
              items: 'applicant.strict_vacancies'
              editable: 'false'
          templateUrl: 'shared/vacancies_table.html'
          controller: 'TableController'
        'partial_vacancies_table@applicants.show':
          resolve:
            params: ->
              items: 'applicant.partial_vacancies'
              editable: 'false'
          templateUrl: 'shared/vacancies_table.html'
          controller: 'TableController'

    .state 'applicants.edit',
      url: '/{id}/edit'
      views:
        '':
          templateUrl: 'applicants/edit.html'
          controller: 'ApplicantsEditController'
        'form@applicants.edit':
          templateUrl: 'applicants/form.html'

]
