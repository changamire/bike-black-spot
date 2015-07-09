def params_permitted?(params, permitted)
  params.keys.each do |param|
    return false unless permitted.include?(param)
  end
end

def params_required?(params, required)
  required.each do |req|
    return false unless params.keys.include?(req)
  end
end
