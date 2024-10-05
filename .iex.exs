import Octos.Factory

# Octos
alias Octos.Application
alias Octos.Mailer
alias Octos.Repo

# Octos.Accounts
alias Octos.Accounts
alias Octos.Accounts.User

# Octos.Cameras
alias Octos.Cameras
alias Octos.Cameras.Camera

# OctosWeb
alias OctosWeb.Endpoint
alias OctosWeb.Router
alias OctosWeb.Temeletry

alias OctosWeb.ChangesetJSON
alias OctosWeb.ErrorJSON
alias OctosWeb.FallbackController
alias OctosWeb.UserJSON

alias OctosWeb.CameraController

# Local dot-iex file (user/environment-specific, Git-ignored)
import_file_if_available(".iex.local.exs")
