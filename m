From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm results from trying to compile a largish program
Date: Mon, 13 Mar 2017 19:34:26 +0000
Message-ID: <CACXZuxdT9fXHnysUFUoMqe+dEuDSKHsQS3Tn8KFEfAP2cnAnJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:37811 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbdCMTe2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Mar 2017 15:34:28 -0400
Received: by mail-it0-f48.google.com with SMTP id g138so38462250itb.0
        for <linux-sparse@vger.kernel.org>; Mon, 13 Mar 2017 12:34:28 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I tried to compile a Lua implementation using sparse-llvm. This
particular implementation is called 'minilua' as it is a cut down
version of Lua 5.1.5 created by Mike Pall for the LuaJIT project.

I had to change all static initializations of course as these are
unsupported in sparse-llvm. I also had to add support for casting
floating point values to integer type in 'op_cast' implementation.

sparse-llvm managed to consume the program after these changes but
there were many LLVM errors reported, which indicates that the
generated code is incorrect.

I have saved the results from this exercise here:

https://github.com/dibyendumajumdar/dmr_c/tree/master/tests/minilua

Hopefully this will help in analysing the errors and deciding how to fix them.

Thanks and Regards
Dibyendu
