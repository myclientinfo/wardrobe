@Wardrobe.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.PostView extends App.Views.ItemView
    template: "post/base/templates/form"

    initialize: ->
      @tagsShown = false

    events:
      "click .publish" : "save"
      "click .js-toggle" : "toggleDetails"
      "click .icon-tags" : "toggleTags"
      "click .js-setdate" : "setPublishDate"
      "change .js-active" : "changeBtn"

    modelEvents:
      "change:_errors"  : "changeErrors"

    templateHelpers:
      submitBtnText: ->
        "Publish Post" if not @active? # When no model is set.
        if @active is "1" then "Publish Post" else "Save Post"

    onShow: ->
      @setUpEditor()
      @setUpTags()
      @setupCalendar()

      if @model.isNew()
        $('#slug').slugify('#title')
        @$("#publish_date").val "Now"
      else
        publish = moment(@model.get("publish_date"), "YYYY-MM-DD HH:mm")
        @$("#publish_date").val publish.format("MMM Do, YYYY h:mm A")

    setUpEditor: ->
      toolbar = [
        'bold', 'italic', '|'
        'quote', 'unordered-list', 'ordered-list', '|'
        'link', 'image', '|'
        'undo', 'redo', '|', 'tags', 'calendar'
      ]

      @editor = new Editor
        toolbar: toolbar

      @editor.render(document.getElementById("content"))

      @$('.editor-statusbar')
        .find('.lines').html(@editor.codemirror.lineCount())
        .find('.words').html(@editor.codemirror.getValue().length)
        .find('.cursorActivity').html(@editor.codemirror.getCursor().line + ':' + @editor.codemirror.getCursor().ch)

    setUpTags: ->
      App.request "tag:entities", (tags) =>
        @$("#js-tags").selectize
          # theme: "contacts"
          persist: true
          maxItems: null
          valueField: "tag"
          labelField: "tag"
          searchField: ["tag"]
          options: tags.toJSON()
          render:
            item: (item) ->
              "<div><i class='icon-tag'></i> #{item.tag}</div>"
            option: (item) ->
              "<div><i class='icon-tag'></i> #{item.tag}</div>"
          create: (input) ->
            return "tag" : input

    toggleTags: (e) ->
      if @tagsShown
        @$('.editor-toolbar a, .editor-toolbar i').show()
        @$(".tags-bar").hide();
      else
        @$('.editor-toolbar a, .editor-toolbar i').hide()
        @$('.icon-tags').show()
        @$(".tags-bar").show()
        @$("js-tags").focus()

      @tagsShown = !@tagsShown

    setupCalendar: ->
      @$(".icon-calendar").qtip
        show:
          event: 'click'
        content:
          text: $("#date-form").html()
        position:
          at: "right center"
          my: "left center"
          viewport: $(window) # Keep the tooltip on-screen at all times
          effect: false # Disable positioning animation
        events:
          render: (event, api) ->
            $(".js-date").each ->
              $(this).val $("#publish_date").val()
            $(".js-setdate").click (e) ->
              e.preventDefault()
              pubDate = $(e.currentTarget).parent().find('input')
              $("#publish_date").val pubDate
              $('.icon-calendar').qtip('hide')

        hide: "unfocus"
      , event

    setPublishDate: (e) ->
      e.preventDefault()
      alert "here"
      pubDate = $("#date").val()
      $("#publish_date").val pubDate
      @$(".icon-calendar").popover('hide')

    save: (e) ->
      e.preventDefault()

      data =
        title: @$('#title').val()
        slug: @$('#slug').val()
        active: @$('input[type=radio]:checked').val()
        content: @editor.codemirror.getValue()
        tags: @$("#js-tags").val()
        publish_date: @$("#publish_date").val()

      @processFormSubmit data

    processFormSubmit: (data) ->
      @model.save data,
        collection: @collection

    # Show the errors based on validation failure.
    changeErrors: (model, errors, options) ->
      if _.isEmpty(errors) then @removeErrors() else @addErrors errors

    addErrors: (errors = {}) ->
      @$("#js-errors").show().find("span").html("<strong>Error</strong> Please fix the following errors")
      for name, error of errors
        @addError error

    addError: (error) ->
      sm = $("<li>").text(error)
      @$("#js-errors span").append sm

    removeErrors: ->
      @$("#js-errors").hide()

    collapse: (@$toggle) ->
      @$toggle.data("dir", "up").addClass("icon-chevron-sign-right").removeClass("icon-chevron-sign-down")
      @$(".details.hide").hide()

    expand: (@$toggle) ->
      @$toggle.data("dir", "down").addClass("icon-chevron-sign-down").removeClass("icon-chevron-sign-right")
      @$(".details.hide").show()

    toggleDetails: (e) ->
      @$toggle = $(e.currentTarget)
      if @$toggle.data("dir") is "up"
        @expand @$toggle
      else
        @collapse @$toggle

    # Toggle the save button text based on status
    changeBtn: (e) ->
      if e.currentTarget.value is "1"
        @$(".publish").text("Publish Post")
      else
        @$(".publish").text("Save Post")