defmodule LiveViewMathWeb.MathLive do
  use LiveViewMathWeb, :live_view

  def mount(_params, _session, socket) do
    integer_1 = Enum.random(0..9_999_999)
    integer_2 = Enum.random(0..9_999_999)
    operator = Enum.random([:add, :subtract, :multiply])

    {:ok,
     assign(socket,
       score: 0,
       integer_1: integer_1,
       integer_2: integer_2,
       operator: operator,
       form: to_form(%{})
     )}
  end

  def render(assigns) do
    ~H"""
    <h1>MATH! BITCHES</h1>
    <p>Score: <%= @score %></p>
    <div class="flex w-full gap-10 items-center">
      <div><%="#{@integer_1} #{operator_to_string(@operator)} #{@integer_2} = "%> </div>
      <.simple_form id="submit-form" for={@form} phx-change="change" phx-submit="submit">
        <.input type="text" field={@form[:result]}/>
      </.simple_form>
    </div>
    """
  end

  def handle_event("submit", params, socket) do
    user_guess = String.to_integer(params["result"])

    socket =
      if user_guess ==
           calculate(socket.assigns.operator, socket.assigns.integer_1, socket.assigns.integer_2) do
        integer_1 = Enum.random(0..9_999_999)
        integer_2 = Enum.random(0..9_999_999)
        operator = Enum.random([:add, :subtract, :multiply])

        assign(socket,
          score: socket.assigns.score + 1,
          integer_1: integer_1,
          integer_2: integer_2,
          operator: operator,
          form: to_form(%{})
        )
      else
        assign(socket,
          form: to_form(params, errors: [result: {"Wrong result", []}])
        )
      end

    {:noreply, socket}
  end

  def handle_event("change", params, socket) do
    socket =
      case Integer.parse(params["result"]) do
        :error ->
          assign(socket,
            form: to_form(params, errors: [result: {"Must be a valid integer", []}])
          )

        _ ->
          assign(socket, form: to_form(params))
      end

    {:noreply, socket}
  end

  defp operator_to_string(operator) do
    case operator do
      :add -> "+"
      :subtract -> "-"
      :multiply -> "*"
      _ -> "Undefined"
    end
  end

  defp calculate(:add, integer_1, integer_2) do
    integer_1 + integer_2
  end

  defp calculate(:subtract, integer_1, integer_2) do
    integer_1 - integer_2
  end

  defp calculate(:multiply, integer_1, integer_2) do
    integer_1 * integer_2
  end
end
