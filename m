From: Christopher Li <sparse@chrisli.org>
Subject: sparse-next and preview of 0.5.1-rc5
Date: Fri, 14 Jul 2017 10:48:57 -0700
Message-ID: <CANeU7Qk-9RcNkWoEL5-0AKyd2Q30BvtjfivEG_KgD4kAH-aEdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36833 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdGNRzN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 14 Jul 2017 13:55:13 -0400
Received: by mail-pg0-f53.google.com with SMTP id u62so48901191pgb.3
        for <linux-sparse@vger.kernel.org>; Fri, 14 Jul 2017 10:55:13 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

I have push a preview version of 0.5.1-rc5 to sparse-next.

https://git.kernel.org/pub/scm/devel/sparse/sparse.git/log/?h=sparse-next

If no big surprise, I will push RC5 to master and tag it tomorrow.

The preview of RC5 contain the fix to the nested loop delete bug
report by Luc and other one report by the ptrlist ref count patch. The
nested loop delete bug is really happening with normal kernel checking.
I am glad that is under control now.

There is also one update from gcc attribute.

I have run the following project compilation with sparse and I haven't see
"crazy programmer" error. Linux kernel, git and gcc (for 64 bit).

Chris
