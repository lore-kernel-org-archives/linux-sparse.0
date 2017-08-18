From: Christopher Li <sparse@chrisli.org>
Subject: Sparse 0.5.1 is released
Date: Fri, 18 Aug 2017 15:46:03 -0400
Message-ID: <CANeU7Qn-ARUVc3jV3AwhJ-79AB92m4Qht7S-E_UXtxFf0-nSzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34608 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbdHRTqE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 15:46:04 -0400
Received: by mail-yw0-f177.google.com with SMTP id s143so64766791ywg.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 12:46:04 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Michael Stefaniuc <mstefani@mykolab.com>

It is finally there. Sparse 0.5.1 is released.

I consider this the best quality of release of sparse I ever
experienced so far. There are lots of enhancement and bug fixes
incorporate into this release.

I would like to thank every one that contributes to this release,
people who submit patches, perform testing and send bug
reports.

I want to specially thank Luc Vanoostenryck who makes this
release possible. He has 242 commits in this release, far more
than any one else.

The development effort for the next release has already began.

Finally, I would like to call for developers joining the sparse project.
If you are interested in modern compilers, reading compiler books
and want some excise. Sparse is a good project to start.

Sparse is very small, the project compiles under 10 seconds.
It can digest the full kernel source file, generate internal byte
code representation and perform check on it. All this happens in
1/10 of the time it took gcc to compile the same source file.

Here is some project ideas,
https://git.kernel.org/pub/scm/devel/sparse/sparse.git/tree/Documentation/project-ideas.md

Thanks

Chris
