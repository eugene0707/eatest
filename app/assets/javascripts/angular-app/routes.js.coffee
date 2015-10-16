@app.config [
  '$stateProvider'
  '$urlRouterProvider'
  '$locationProvider'
  ($stateProvider, $urlRouterProvider, $locationProvider) ->

    $urlRouterProvider
      .otherwise '/'

    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: 'home/index.html'
        controller: 'HomeController'

    #$locationProvider.html5Mode true
]
