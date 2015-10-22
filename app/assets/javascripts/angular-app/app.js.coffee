@app = angular.module('employmentAgency', [
  'templates'
  'ngResource'
  'ngSanitize'
  'restangular'
  'ui.router'
  'angular-loading-bar'
  'ui.bootstrap'
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
    $rootScope.flash_messages = new Array()
    Restangular.setErrorInterceptor((response)->
      $rootScope.flash_messages.push(
        id: Date.now()
        type: 'danger'
        data: response.data
      )
      true
    )

    console.log 'employmentAgency app running'
])
