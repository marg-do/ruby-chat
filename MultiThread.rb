module MultiThread
  @@module_function = [
    :forkIO,
    :killThread
  ]

  def forkIO(fn)
    Thread.start(fn) do |fn|
      fn.call
    end
  end

  def killThread(thread)
    Thread.kill(th)
  end

  @@module_function.each do |fn|
    module_function fn
  end
end
