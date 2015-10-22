@app.directive('flashMessages', [
  '$rootScope'
  ($rootScope)->
    scope: {}
    restrict: 'A'
    replace: true
    templateUrl: 'shared/flash_messages.html'
    link: (scope, element, attrs)->
      scope.messages=[]
      messages = scope.messages
      teststring = ''
      scope.watcher=(value)->
        return if !value || !value.type
        scope.update(value) if (value)
        $rootScope.flash_message={}
      $rootScope.$watch('flash_message', scope.watcher)
      scope.update=(value)->
        new_message=
          id: Date.now()
          type: value.type
          data: value.data
        scope.messages.push(new_message)

])