From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Question about Sparse Linear form and pseudos
Date: Sun, 20 Aug 2017 15:54:47 +0100
Message-ID: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:35394 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753018AbdHTOys (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 10:54:48 -0400
Received: by mail-ua0-f171.google.com with SMTP id q42so27876212uad.2
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 07:54:48 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am trying to get to grips with the Sparse Linear format and the use
of pseudos.

1) A Sparse document says that pseudos are akin to SSA variables. Is
that a true statement - i.e. do pseudos follow the discipline that
only one assignment to a pseudo is allowed. As pseudos have also
different sub-types - does this statement apply to all pseudo types or
only some sub types?

2) In a recent conversation it was stated that the baseline Linear
output from Sparse is already in SSA form. That implies that all
pseudos used are in SSA form already. However we know that in the
baseline line IR phi nodes may not be present. In LLVM the initial IR
lacks phi nodes too - instead local stack memory and load/store
sequences are used. However LLVM IR is still SSA at this stage. When
it is said that the baseline Linear IR is already SSA is it in this
sense?

Thanks and Regards
Dibyendu
