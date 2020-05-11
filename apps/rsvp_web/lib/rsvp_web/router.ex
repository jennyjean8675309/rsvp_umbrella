defmodule RsvpWeb.Router do
  use RsvpWeb, :router

  # the browser pipeline performs several default actions on the http request
  # plugs interact with the request data
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # if we were to put this plug in the pipeline :browser (above), our website would constantly redirect to login (if no one was logged in), and eventually our site would crash
  # we solve this by creating a new pipeline for authorized pages only, which include all of the events pages
  # to do that, we created a new scope for our of our events pages, and set them up to pipe_through the authorized pipeline

  # You can also allow users to view everything on your pages, but only allow them to create a new event if they are logged in - see the commented line 4 of event_controller to see how to do this
  pipeline :authorized do
    plug :browser
    plug RsvpWeb.AuthorizedPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RsvpWeb do
    pipe_through :browser

    get "/", PageController, :index
    
    get "/login", LoginController, :index
    post "/login", LoginController, :login
    get "/logout", LoginController, :logout, as: :logout
  end

  scope "/events", RsvpWeb do
    pipe_through :authorized

    get "/", EventController, :list
    get "/new", EventController, :create
    post "/new", EventController, :add
    get "/:id", EventController, :show
    post "/:id/reserve", EventController, :reserve
    post "/:id/rsvp", EventController, :rsvp
  end

  # Other scopes may use custom stacks.
  # scope "/api", RsvpWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: RsvpWeb.Telemetry
    end
  end
end
