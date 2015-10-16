@app.config [
  '$routeProvider'
  '$locationProvider'
  ($routeProvider, $locationProvider) ->
    $routeProvider
    .when '/',
      templateUrl: 'home/index.html',
      controller: 'HomeController'
      controllerAs: 'homeCtrl'

    .otherwise
      redirectTo: '/'

    $locationProvider.html5Mode true
]