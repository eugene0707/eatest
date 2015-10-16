@app.factory('BaseService', [ ->

  class BaseService
    constructor: (@restangular, @route) ->

    index: (params) ->
      @restangular.all(@route).getList(params).$object

    show: (id) ->
      @restangular.one(@route, id).get()

    getView: (id) ->
      @restangular.one(@route, id).one(@route + 'view').get()

    update: (updatedResource) ->
      updatedResource.put().$object

    create: (newResource) ->
      @restangular.all(@route).post(newResource)

    destroy: (object) ->
      @restangular.one(@route, object.id).remove()

    @extend: (service) ->
      service:: = Object.create(BaseService::)
      service::constructor = service

])
