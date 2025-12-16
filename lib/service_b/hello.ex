defmodule ServiceB.Hello do
  def say_hi do
    {:ok, hostname} = :inet.gethostname()
    "Chào Đại ca! Em là Service B đang chạy tại container: #{hostname}"
  end
end
