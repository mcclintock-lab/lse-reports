ReportTab = require 'reportTab'
templates = require '../templates/templates.js'
_partials = require '../node_modules/seasketch-reporting-api/templates/templates.js'
partials = []
for key, val of _partials
  partials[key.replace('node_modules/seasketch-reporting-api/', '')] = val


class OverviewTab extends ReportTab
  name: 'Overview'
  className: 'overview'
  template: templates.overview
  dependencies: ['Size']
  render: () ->
    sizes = @recordSet('Size', 'Size').toArray()[0]
    size_sqkm = sizes['SIZE_SQKM']
    # setup context object with data and render the template from it
    context =
      sketch: @model.forTemplate()
      sketchClass: @sketchClass.forTemplate()
      attributes: @model.getAttributes()
      admin: @project.isAdmin window.user
      size_sqkm: size_sqkm
    
    @$el.html @template.render context, @partials
    @enableLayerTogglers(@$el)



module.exports = OverviewTab