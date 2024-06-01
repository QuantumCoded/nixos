driverPackage:
let
  # https://github.com/keylase/nvidia-patch/blob/master/patch.sh
  patches = {
    "440.26" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.31" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.33.01" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.36" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.43.01" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.44" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.48.02" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.58.01" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.58.02" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.59" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.64" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.64.00" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.66.02" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.66.03" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.66.04" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.66.08" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.66.09" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.66.11" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.66.12" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.66.14" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.66.15" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.66.17" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.82" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.95.01" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.100" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "440.118.02" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "450.36.06" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "450.51" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "450.51.05" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "450.51.06" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "450.56.01" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "450.56.02" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "450.56.06" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "450.56.11" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "450.57" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "450.66" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "450.80.02" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "450.102.04" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.22.04" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.23.04" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.23.05" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.26.01" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.26.02" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.28" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.32.00" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.38" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.45.01" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.46.01" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.46.02" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.46.04" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.50.02" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.50.04" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.50.05" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.50.07" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "455.50.10" = "s/\\x85\\xc0\\x41\\x89\\xc4\\x75\\x1f/\\x31\\xc0\\x41\\x89\\xc4\\x75\\x1f/g";
    "460.27.04" = "s/\\x22\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4\\x0f\\x85/\\x22\\xff\\xff\\x31\\xc0\\x41\\x89\\xc4\\x0f\\x85/g";
    "460.32.03" = "s/\\x22\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4\\x0f\\x85/\\x22\\xff\\xff\\x31\\xc0\\x41\\x89\\xc4\\x0f\\x85/g";
    "460.39" = "s/\\x22\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4\\x0f\\x85/\\x22\\xff\\xff\\x31\\xc0\\x41\\x89\\xc4\\x0f\\x85/g";
    "460.56" = "s/\\x22\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4\\x0f\\x85/\\x22\\xff\\xff\\x31\\xc0\\x41\\x89\\xc4\\x0f\\x85/g";
    "460.67" = "s/\\x22\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4\\x0f\\x85/\\x22\\xff\\xff\\x31\\xc0\\x41\\x89\\xc4\\x0f\\x85/g";
    "460.73.01" = "s/\\x22\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4\\x0f\\x85/\\x22\\xff\\xff\\x31\\xc0\\x41\\x89\\xc4\\x0f\\x85/g";
    "460.80" = "s/\\x22\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4\\x0f\\x85/\\x22\\xff\\xff\\x31\\xc0\\x41\\x89\\xc4\\x0f\\x85/g";
    "460.84" = "s/\\x22\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4\\x0f\\x85/\\x22\\xff\\xff\\x31\\xc0\\x41\\x89\\xc4\\x0f\\x85/g";
    "460.91.03" = "s/\\x22\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4\\x0f\\x85/\\x22\\xff\\xff\\x31\\xc0\\x41\\x89\\xc4\\x0f\\x85/g";
    "465.19.01" = "s/\\xe8\\xc5\\x20\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xc5\\x20\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "465.24.02" = "s/\\xe8\\xc5\\x20\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xc5\\x20\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "465.27" = "s/\\xe8\\xc5\\x20\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xc5\\x20\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "465.31" = "s/\\xe8\\xc5\\x20\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xc5\\x20\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "470.42.01" = "s/\\xe8\\x25\\x1C\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x1C\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "470.57.02" = "s/\\xe8\\x25\\x1C\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x1C\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "470.62.02" = "s/\\xe8\\x25\\x1C\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x1C\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "470.62.05" = "s/\\xe8\\x25\\x1C\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x1C\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "470.63.01" = "s/\\xe8\\x25\\x1C\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x1C\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "470.74" = "s/\\xe8\\x25\\x1C\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x1C\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "470.82.00" = "s/\\xe8\\x25\\x1C\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x1C\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "470.86" = "s/\\xe8\\x25\\x1C\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x1C\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "470.94" = "s/\\xe8\\x25\\x1C\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x1C\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "495.29.05" = "s/\\xe8\\x35\\x1f\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x35\\x1f\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "495.44" = "s/\\xe8\\x35\\x1f\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x35\\x1f\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "495.46" = "s/\\xe8\\x35\\x1f\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x35\\x1f\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "510.39.01" = "s/\\xe8\\x15\\x1f\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x15\\x1f\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "510.47.03" = "s/\\xe8\\x15\\x1f\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x15\\x1f\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "510.54" = "s/\\xe8\\x15\\x1f\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x15\\x1f\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "510.60.02" = "s/\\xe8\\x15\\x1f\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x15\\x1f\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "510.68.02" = "s/\\xe8\\x15\\x1f\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x15\\x1f\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "510.73.05" = "s/\\xe8\\x15\\x1f\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x15\\x1f\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "510.73.08" = "s/\\xe8\\x15\\x1f\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x15\\x1f\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "510.85.02" = "s/\\xe8\\x15\\x1f\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x15\\x1f\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "510.108.03" = "s/\\xe8\\x15\\x1f\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x15\\x1f\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "515.43.04" = "s/\\xe8\\xd5\\x1e\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xd5\\x1e\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "515.48.07" = "s/\\xe8\\xd5\\x1e\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xd5\\x1e\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "515.57" = "s/\\xe8\\xd5\\x1e\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xd5\\x1e\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "515.65.01" = "s/\\xe8\\xd5\\x1e\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xd5\\x1e\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "515.76" = "s/\\xe8\\xd5\\x1e\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xd5\\x1e\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "515.86.01" = "s/\\xe8\\xd5\\x1e\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xd5\\x1e\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "515.105.01" = "s/\\xe8\\x95\\x1c\\xff\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x95\\x1c\\xff\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "520.56.06" = "s/\\xe8\\xa5\\xc8\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xa5\\xc8\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "520.61.05" = "s/\\xe8\\xa5\\xc8\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xa5\\xc8\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "525.60.11" = "s/\\xe8\\xf5\\xc6\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xf5\\xc6\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "525.60.13" = "s/\\xe8\\xf5\\xc6\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xf5\\xc6\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "525.78.01" = "s/\\xe8\\xf5\\xc6\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xf5\\xc6\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "525.85.05" = "s/\\xe8\\xf5\\xc6\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xf5\\xc6\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "525.85.12" = "s/\\xe8\\xf5\\xc6\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xf5\\xc6\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "525.89.02" = "s/\\xe8\\x65\\xc7\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x65\\xc7\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "525.105.17" = "s/\\xe8\\x55\\xc4\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x55\\xc4\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "525.116.03" = "s/\\xe8\\x55\\xc4\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x55\\xc4\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "525.116.04" = "s/\\xe8\\x55\\xc4\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x55\\xc4\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "525.125.06" = "s/\\xe8\\x55\\xc4\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x55\\xc4\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "530.30.02" = "s/\\xe8\\x15\\x6f\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x15\\x6f\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "530.41.03" = "s/\\xe8\\xc5\\x6b\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xc5\\x6b\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "535.43.02" = "s/\\xe8\\xa5\\x9e\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xa5\\x9e\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "535.54.03" = "s/\\xe8\\xa5\\x9e\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xa5\\x9e\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "535.86.05" = "s/\\xe8\\x05\\xa0\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x05\\xa0\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "535.86.10" = "s/\\xe8\\x05\\xa0\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x05\\xa0\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "535.98" = "s/\\xe8\\xa5\\x9f\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xa5\\x9f\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "535.104.05" = "s/\\xe8\\xa5\\x9f\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xa5\\x9f\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "535.104.12" = "s/\\xe8\\xa5\\x9f\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xa5\\x9f\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "535.113.01" = "s/\\xe8\\xa5\\x9f\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xa5\\x9f\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "535.129.03" = "s/\\xe8\\xa5\\x9f\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xa5\\x9f\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "535.146.02" = "s/\\xe8\\xa5\\x9f\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xa5\\x9f\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "545.23.06" = "s/\\xe8\\xc5\\x8f\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xc5\\x8f\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "545.23.08" = "s/\\xe8\\xc5\\x8f\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xc5\\x8f\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "545.29.02" = "s/\\xe8\\xc5\\x8f\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xc5\\x8f\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "545.29.06" = "s/\\xe8\\xc5\\x8f\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\xc5\\x8f\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "550.40.07" = "s/\\xe8\\x35\\x54\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x35\\x54\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "550.54.14" = "s/\\xe8\\x25\\x54\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x54\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "550.54.15" = "s/\\xe8\\x25\\x54\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x54\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "550.67" = "s/\\xe8\\x25\\x54\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x54\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "550.76" = "s/\\xe8\\x25\\x54\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x54\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "550.78" = "s/\\xe8\\x25\\x54\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x54\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
    "555.42.02" = "s/\\xe8\\x25\\x43\\xfe\\xff\\x85\\xc0\\x41\\x89\\xc4/\\xe8\\x25\\x43\\xfe\\xff\\x29\\xc0\\x41\\x89\\xc4/g";
  };
in
driverPackage.overrideAttrs ({ version, preFixup ? "", ... }: {
  preFixup = preFixup + ''
    sed -i '${
      builtins.getAttr version patches
    }' $out/lib/libnvidia-encode.so.${version}
  '';
})
