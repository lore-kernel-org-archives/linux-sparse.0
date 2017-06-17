From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Application of sparse - using dmrC in Lua
Date: Sat, 17 Jun 2017 17:59:05 +0100
Message-ID: <CACXZuxfmcQHfGtJG+h_apjMwOoC8EOuUptAE6cpVjB-P6w+S-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33213 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdFQQ7H (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Jun 2017 12:59:07 -0400
Received: by mail-wr0-f180.google.com with SMTP id r103so52279807wrb.0
        for <linux-sparse@vger.kernel.org>; Sat, 17 Jun 2017 09:59:07 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am pleased to report that I have a hello world coming out of C code,
JIT compiled via dmrC from inside Lua. Here is what the Lua script
looks like:

https://github.com/dibyendumajumdar/ravi/blob/master/ravi-tests/dmrc_test.lua

And here is another use of Sparse - this time extracting the symbols
into a Lua table.

local somecode = [[
extern int adder(int a, int b);

int adder(int a, int b)
{
return a+b;
}
]]

local symbols = dmrc.getsymbols(somecode)

table_print(symbols)

The output goes like this:

[1] => table
    (
       [1] => table
           (
              [startcol] => 17
              [endline] => 1
              [file] => buffer
              [type] => function
              [id] => 1
              [endcol] => 31
              [builtintype] => int
              [arguments] => table
                  (
                     [1] => table
                         (
                            [startcol] => 18
                            [endline] => 1
                            [file] => buffer
                            [ident] => a
                            [id] => 2
                            [endcol] => 23
                            [builtintype] => int
                            [startline] => 1
                            [alignment] => 4
                            [offset] => 0
                            [bitsize] => 32
                            [type] => node
                         )
                     [2] => table
                         (
                            [startcol] => 25
                            [endline] => 1
                            [file] => buffer
                            [ident] => b
                            [id] => 3
                            [endcol] => 30
                            [builtintype] => int
                            [startline] => 1
                            [alignment] => 4
                            [offset] => 0
                            [bitsize] => 32
                            [type] => node
                         )
                  )
              [alignment] => 4
              [offset] => 0
              [bitsize] => 32
              [startline] => 1
           )
       [startline] => 1
       [basetype] => 1
       [extern] => 1
       [toplevel] => 1
       [offset] => 0
       [bitsize] => 32
       [signed] => 1
       [endline] => 1
       [file] => buffer
       [ident] => adder
       [id] => 0
       [endcol] => 31
       [prototype] => 1
       [type] => node
       [startcol] => 12
       [addressable] => 1
       [alignment] => 4
    )

<truncated>
