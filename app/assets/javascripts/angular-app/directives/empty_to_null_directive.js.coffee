@app.directive('emptyToNull', ->
  restrict: 'A'
  require: 'ngModel'
  link: (scope, elem, attrs, ctrl)->
    ctrl.$parsers.push((viewValue)->
      if(viewValue == '')
        return null
      return viewValue
    )
)
