@app.controller("TableController", [
  '$scope'
  '$parse'
  'params'
  ($scope, $parse, params)->
    $scope.items =->
      $parse(params.items)($scope)
    $scope.editable = params.editable=='true'
])
