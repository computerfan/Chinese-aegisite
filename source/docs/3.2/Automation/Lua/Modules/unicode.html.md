 `unicode`模块包含一系列为Auto4设置的辅助函数，主要用来处理 UTF-8 编码的文本。

## 用法 ##
用 `unicode = require 'aegisub.unicode'`{:.language-lua}导入函数。

## unicode.charwidth  ##
Synopsis: `width = unicode.charwidth(instring, index=1)`{:.language-lua}

Returns the number of bytes occupied by the UTF-8 encoded code points starting at position `index` in `instring`.
The character pointed to is assumed to be a prefix byte (i.e. the first byte of the code points).

The `index` parameter is optional abd defaults to 1 (one) when left out, meaning the width of the first character in `instring` will be returned.

## unicode.chars  ##
Synopsis: `for char in unicode.chars(instring) do ... end`{:.language-lua}

Returns an iterator function for looping over all code points in the given UTF-8 encoded string.
For each iteration of the loop, `char` will contain a string representing the next code point in the string. This string may be more than one byte long.

## unicode.len  ##
Synopsis: `length = unicode.len(instring)`{:.language-lua}

Determine the length in code points of the given UTF-8 encoded string.

Be aware that this function does not run in constant time, but in linear time (O(N)) proportional to the number of Unicode code points in `instring`.

## unicode.codepoint  ##
Synopsis: `val = unicode.codepoint(instring)`{:.language-lua}

Read the first unicode codepoint from `instring`.

## unicode.to_upper_case
Synopsis: `upper = unicode.to_upper_case(instring)`{:.language-lua}

Convert a string to upper case.
This function handles accents, non-latin scripts, and the like.

## unicode.to_lower_case
Synopsis: `lower = unicode.to_lower_case(instring)`{:.language-lua}

Convert a string to lower case.
This function handles accents, non-latin scripts, and the like.

## unicode.to_fold_case
Synopsis: `folded = unicode.to_fold_case(instring)`{:.language-lua}

Convert a string to fold case.
This is similar to lower case, but is locale-insensitive and gives better results for case-insensitive comparisons.


{::template name="automation_navbox" /}
