
load("debug.jl")

module TestGlobalScope
import Base.*
import Debug.*

function debug_hook(line::Int, file, scope::Scope) 
    print(line, ":")
    if line < 30
        if (line >  20) debug_eval(scope, :( print("\tx = ", x) )) end
        if (line >  21) debug_eval(scope, :( print("\ty = ", y) )) end

        if (line == 21) debug_eval(scope, :( x = 7; y = 8       )) end
    end
    println()
end

@debug begin
    x = 1  # line 20
    y = 2  #      21
    x      #      22
end

println("(x, y) = ", (x, y)) 


try
    @debug begin
        x=1
    end
    error("Shouldn't be able to use @debug in local scope!")
catch e
    print("@debug was disallowed in local scope, as it should.")
end

end  # module
