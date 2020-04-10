From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE PATCH 0/5] detect invalid branches in the IR
Date: Fri, 10 Apr 2020 20:49:13 +0200
Message-ID: <20200410184918.64692-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45745 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgDJStb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Apr 2020 14:49:31 -0400
Received: by mail-wr1-f50.google.com with SMTP id v5so3240057wrp.12
        for <linux-sparse@vger.kernel.org>; Fri, 10 Apr 2020 11:49:29 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's not allowed to do a goto into an expression statement.
For exemple, it's not well defined what should happen if such
an expression is not otherwise reachable and/or can be optimized
away. For such situations GCC issues an error, clang doesn't
and produce a valid IR but spare produce an invalid IR with
branches to unexisting BBs.

The goal of the patches in this series is:
*) To detect such gotos and issue a sensible error.
*) To make the IR somehow valid. Since the original
   expression has been optimized away, the IR replace
   the goto by a branch to itself.

-- Luc

base-commit: 79f7ac984473d031dfb9cef00119c2d542d0d4a6
-- 
2.26.0
