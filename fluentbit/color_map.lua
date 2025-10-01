function color_map(tag, timestamp, record)
  local level = record["level"] or ""
  if string.find(level, "ERROR") then
    record["color_class"] = "red"
  elseif string.find(level, "WARN") then
    record["color_class"] = "yellow"
  elseif string.find(level, "INFO") then
    record["color_class"] = "green"
  else
    record["color_class"] = "grey"
  end
  return 2, timestamp, record
end
 
 
