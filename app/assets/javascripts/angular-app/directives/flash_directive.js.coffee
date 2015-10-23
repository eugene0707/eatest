@app.directive('flashMessages', [
  '$rootScope'
  ($rootScope)->
    restrict: 'A'
    replace: true
    templateUrl: 'shared/flash_messages.html'
    controller: ($scope, $element)->
      $scope.messages=[]
      $scope.watcher=(value)->
        return if !value || !value.type
        $scope.messages.push(value)
      $scope.close_message=(index)->
        $scope.messages.splice(index, 1)
      $scope.unwatch=$rootScope.$watch('flash_message', $scope.watcher)
      $scope.$on('$destroy', ->
        $scope.unwatch()
      )

])
