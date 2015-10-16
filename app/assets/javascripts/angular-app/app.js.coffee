@app = angular.module('employmentAgency', [
  'templates'
  'ngResource'
  'ngSanitize'
  'restangular'
  'ui.router'
])

@app.config([
  'RestangularProvider'
  (RestangularProvider)->

    RestangularProvider
    .setBaseUrl('/api')
    .setRequestSuffix('.json')
])

@app.run(->
  console.log 'employmentAgency app running'
)
