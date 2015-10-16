@app = angular.module('employmentAgency', [
  'templates'
  'ngRoute'
])

@app.config([
  '$httpProvider', ($httpProvider)->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])

@app.run(->
  console.log 'employmentAgency app running'
)
