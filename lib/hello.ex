defmodule Test do
  @on_load :init

  def init() do
    :erlang.load_nif("./binding", 0)
  end

  def test(_x, _y, _width, _height) do
    raise "NIF test/4 not implemented!"
  end

  def hello(_message) do
    raise "NIF hello/1 not implemented!"
  end
end
