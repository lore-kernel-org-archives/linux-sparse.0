From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm casts needed on function call arguments and returns
Date: Tue, 14 Mar 2017 10:48:53 +0000
Message-ID: <CACXZuxd79XySoaYR5wckhx3KfQELV-gg5hWyTS5Q5i+=zOh6Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34411 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdCNKsz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Mar 2017 06:48:55 -0400
Received: by mail-io0-f182.google.com with SMTP id b140so7605773iof.1
        for <linux-sparse@vger.kernel.org>; Tue, 14 Mar 2017 03:48:54 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

It appears that both function call arguments and returns from
functions need to be cast to the expected type in sparse-llvm. This
may be because the linearizer is eliminating casts - I am not sure.
From LLVM perspective two pointers to different base types are not the
same - similarly various integer types and floating types are not
interchangeable.

By adding casts to store operations (both op_store and op_phisrc) as
well as in function call arguments the number of errors I am getting
when compiling 'minilua' has reduced significantly. However still 192
errors remain (but hopefully many will go with the next fix!).

Of course even with all errors being fixed it doesn't mean that the
generated code is right. Only when I run the program on Lua test suite
it will become apparent whether the generated code is correct or not.

Regards
Dibyendu
