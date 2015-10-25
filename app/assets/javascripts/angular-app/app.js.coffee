@app = angular.module('employmentAgency', [
  'templates'
  'ngResource'
  'ngSanitize'
  'restangular'
  'ui.router'
  'angular-loading-bar'
  'ui.bootstrap'
  'ui.mask'
])

@app.config([
  'RestangularProvider'
  (RestangularProvider)->

    RestangularProvider
    .setBaseUrl('/api')
    .setRequestSuffix('.json')
])

@app.run([
  '$rootScope'
  'Restangular'
  ($rootScope, Restangular)->
    Restangular.setErrorInterceptor((response)->
      $rootScope.flash_message=
        id: Date.now()
        type: 'danger'
        data: response.data
      $rootScope.$applyAsync(->
        $rootScope.flash_message = {}
      )
      true
    )

    console.log 'employmentAgency app running'
])
