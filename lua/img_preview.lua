local M = {}

local IMAGE_EXTS = {
  png = true,
  jpg = true,
  jpeg = true,
  gif = true,
  webp = true,
  bmp = true,
  svg = true,
  tiff = true,
  tif = true,
  ico = true,
  avif = true,
}

local URL_PATTERNS = {
  "https?://[%w_.~!*:@&+$,/%%#%-=?%[%]{}]+",
  "file://[%w_./%-]+",
  "/[%w_./%-]+%.(%a+)",
}

local function is_image_url(url, ext)
  local url_path = url:match("^https?://[^?#]+") or url:match("^file://[^?#]+") or url
  local url_ext = ext or url_path:match("%.([%a%d]+)$")
  return url_ext and IMAGE_EXTS[url_ext:lower()]
end

local function clean_url(url)
  url = url:gsub("^[['\"]+", ""):gsub("[)'\",;]+$", "")
  while url:sub(-1) == "." do
    url = url:sub(1, -2)
  end
  return url
end

--- Find non-overlapping image URL matches in a line
---@return {url:string, s:number, e:number}[]
local function find_image_urls(line)
  local matches, claimed = {}, {}
  for _, pat in ipairs(URL_PATTERNS) do
    local start = 1
    while true do
      local s, e, ext = line:find(pat, start)
      if not s then
        break
      end
      local overlaps = false
      for _, r in ipairs(claimed) do
        if s <= r[2] and e >= r[1] then
          overlaps = true
          break
        end
      end
      if not overlaps then
        local url = clean_url(line:sub(s, e))
        if is_image_url(url, ext) then
          matches[#matches + 1] = { url = url, s = s, e = e }
        end
        claimed[#claimed + 1] = { s, e }
      end
      start = e + 1
    end
  end
  table.sort(matches, function(a, b)
    return a.s < b.s
  end)
  return matches
end

--- Image URL on the current line, preferring the one under the cursor
function M.get_url_on_line()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local matches = find_image_urls(line)
  for _, m in ipairs(matches) do
    if col >= m.s and col <= m.e then
      return m.url
    end
  end
  return matches[1] and matches[1].url or nil
end

--- All unique image URLs in the current buffer
function M.get_image_urls()
  local urls, seen = {}, {}
  for l, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    for _, m in ipairs(find_image_urls(line)) do
      if not seen[m.url] then
        seen[m.url] = true
        urls[#urls + 1] = { url = m.url, lnum = l }
      end
    end
  end
  return urls
end

function M.preview_all_images()
  local items = M.get_image_urls()
  if #items == 0 then
    return
  end
  for _, item in ipairs(items) do
    item.text = item.url
    item.file = item.url
    item.pos = { item.lnum, 0 }
  end
  Snacks.picker({
    source = "image_urls",
    items = items,
    format = function(item, _)
      local name = item.text:match("/([^/]+)$") or item.text
      return {
        { name, "SnacksPickerFile" },
        { " :" .. item.pos[1], "SnacksPickerComment" },
      }
    end,
    preview = function(ctx)
      ctx.preview:reset()
      ctx.preview:set_title(ctx.item.text:match("/([^/]+)$") or ctx.item.text)
      Snacks.image.buf.attach(ctx.buf, { src = ctx.item.text })
    end,
    confirm = function(picker, item)
      picker:close()
      vim.api.nvim_win_set_cursor(0, { item.pos[1], 0 })
    end,
  })
end

function M.preview_image()
  local text
  if vim.fn.mode():match("[vV\22]") then
    local previous_register = vim.fn.getreg("v", 1, true)
    local previous_register_type = vim.fn.getregtype("v")
    vim.cmd('noau normal! "vy"')
    text = vim.trim(vim.fn.getreg("v"))
    vim.fn.setreg("v", previous_register, previous_register_type)
  else
    text = M.get_url_on_line()
    if not text then
      return
    end
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.max(1, math.min(100, vim.o.columns - 4))
  local height = math.max(1, math.min(20, vim.o.lines - 4))
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "cursor",
    width = width,
    height = height,
    col = 0,
    row = 0,
    style = "minimal",
    border = vim.g.border,
  })

  local placement = Snacks.image.placement.new(buf, text, {
    pos = { 1, 1 },
    auto_resize = true,
  })

  local closed = false
  local close_preview = function()
    if closed then
      return
    end
    closed = true
    if placement then
      placement:close()
    end
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  vim.keymap.set("n", "q", close_preview, { buffer = buf })
  vim.keymap.set("n", "<esc>", close_preview, { buffer = buf })
  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(win),
    once = true,
    callback = close_preview,
  })
end

return M
