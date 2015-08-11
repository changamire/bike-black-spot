def validate_params?(params, permitted, required)
  params_permitted?(params, permitted) && params_required?(params, required)
end

def params_permitted?(params, permitted)
  params.keys.each do |param|
    return false unless permitted.include?(param.to_s)
    return false if params[param].nil? || params[param] ==''
  end
  return true
end

def params_required?(params, required)
  required.each do |req|
    return false if params[req.to_sym].nil?
  end
  return true
end

