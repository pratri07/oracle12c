node[:oracle][:rdbms][:deps_12c].each do |dep|
   yum_package dep
end
