 function stop = curvefittingPlotIterates(x,optimValues,state)
        % Output function that plots the iterates of the optimization algorithm.
    
     %   Copyright 2010 The MathWorks, Inc.    
       persistent x0 r;
       if nargin == 1
       showPlot(x(1).X,x(1).X0{:},x(1).Fval)
       else
          switch state
             case 'init' % store initial point for later use
                   x0 = x;
                case 'done'
                    if ~(optimValues.iteration == 0)
                        % After optimization, display solution in plot title
                        r = optimValues.resnorm;
                        showPlot(x,x0,r)
                   end
           end
        end
        if nargout > 0
            stop = false;
           clear function
        end
    end
    
 