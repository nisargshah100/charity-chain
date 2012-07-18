class App.Controller.Navbars extends Spine.Controller

  constructor: ->
    super
    @render()
    @events()
    
  events: ->
    $("#signout_link").live('click', @signOut)

  render: ->
    @user_email = user_email()
    $(".navbar").html @view('navbar')(@)
  
  signOut: ->
    $.ajax {
      type: 'DELETE',
      url: '/sessions/destroy'
    }
    location.href = '/'
    