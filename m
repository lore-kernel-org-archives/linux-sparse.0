From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH V2 0/4] Adding selfcheck target
Date: Mon, 17 Jul 2017 22:51:43 -0400
Message-ID: <CANeU7Q=pWm7VHmg_Tb+7K1dd-y86D9bQnX3_KJNO16fGHj2N7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34137 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdGRCvp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 17 Jul 2017 22:51:45 -0400
Received: by mail-pf0-f181.google.com with SMTP id q85so4149779pfq.1
        for <linux-sparse@vger.kernel.org>; Mon, 17 Jul 2017 19:51:44 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

This is  the updated version of the selfcheck.

Merge some change submit by Ramsay Jones.
I also fix some warning report by selfcheck. That is the 4th path.

This is the current selfcheck warning on Linux:

     CHECK    pre-process.c
pre-process.c:712:25: warning: Variable length array is used.
pre-process.c:2019:28: warning: Variable length array is used.
     CHECK    symbol.c
     CHECK    lib.c
lib.c:194:6: error: symbol 'error_die' redeclared with different type
(originally declared at lib.h:98) - different modifiers
lib.c:203:6: error: symbol 'die' redeclared with different type
(originally declared at lib.h:94) - different modifiers

This one is hard to fix. It is reporting the difference in NORETURN attribute.
The NORETURN should not be a modifier, it is an attribute.
The other issue here is that, sparse haven't handle merging the
difference instance
of the incremental declare properly.

I also have this:
     CHECK    sparse-llvm.c
/usr/include/bits/mathinline.h:134:55: warning: obsolete struct
initializer, use C99 syntax
/usr/include/bits/mathinline.h:146:59: warning: obsolete struct
initializer, use C99 syntax
/usr/include/bits/mathinline.h:153:64: warning: obsolete struct
initializer, use C99 syntax

That is a system header file which I can't fix in sparse.

Chris
