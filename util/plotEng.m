function fig = plotEng(thrustCurve)
  fig = figure('visible','off');
  clf;
  hold on;
  plot(thrustCurve.time,thrustCurve.thrust,'color','b','linestyle','-');
  plot(thrustCurve.time,thrustCurve.thrust,'color','r','marker','s','linestyle','none');
  xlabel("Time [s]");
  ylabel("Thrust [N]");
  title("Thrust curve");
  grid on;
  hold off;
  set(fig,'visible','on');
end