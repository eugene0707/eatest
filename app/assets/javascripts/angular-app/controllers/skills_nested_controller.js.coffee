@app.controller("SkillsNestedController", [
  '$scope'
  'SkillService'
  ($scope, SkillService)->
    $scope.skills = SkillService.index()
    $scope.delete_skill = (data, message)->
      return if !confirm(message)
      SkillService.destroy(data).then(->
        $scope.skills = SkillService.index()
      )

    $scope.create_skill=->
      SkillService.create(skill: {name: $scope.skill_name}).then(->
        $scope.skill_name = null
        delete $scope.nested_skill
        $scope.skills = SkillService.index()
      )

    $scope.update_skill=->
      $scope.nested_skill.skill=
        name: $scope.skill_name
      $scope.nested_skill.put().then(->
        $scope.skill_name = null
        delete $scope.nested_skill
        $scope.skills = SkillService.index()
      )

    $scope.set_cursor=(skill)->
      $scope.nested_skill=skill
      if skill
        $scope.skill_name = skill.name
      else
        $scope.skill_name = null

    $scope.toggle_skill=(skill_id)->
      $scope.$parent.object={} if !$scope.$parent.object
      $scope.$parent.object.skill_ids=[] if !$scope.$parent.object.skill_ids
      skill_index=$scope.$parent.object.skill_ids.indexOf(skill_id)
      if skill_index > -1
        $scope.$parent.object.skill_ids.splice(skill_index, 1)
      else
        $scope.$parent.object.skill_ids.push(skill_id)

])
