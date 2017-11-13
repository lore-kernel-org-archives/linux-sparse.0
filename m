From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 0/2] V2 llvm constant value pseudo size fix
Date: Mon, 13 Nov 2017 23:27:54 +0800
Message-ID: <CANeU7QknH=xpuButjBpVved131s8Kw4AJRZZGTBDLN+LBH_H9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:43205 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753003AbdKMP1z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Nov 2017 10:27:55 -0500
Received: by mail-yw0-f179.google.com with SMTP id y75so13727070ywg.0
        for <linux-sparse@vger.kernel.org>; Mon, 13 Nov 2017 07:27:55 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

Per Luc's feed back. This is the more complete version
of the pseudo-size-value branch.

I add the second patch to allow sparse-llvm to use
the new size store in constant value pseudo.

The whole series is very simple, only two patches.
It directly address the problem of sparse-llvm wasn't
able to get the integer size from constant value pseudo.

I am consider this as better alternative compare to OP_PUSH.
- OP_PUSH break byte code compatibility at source level, this does not.
- OP_PUSH has more instruction (more memory).
- OP_PUSH only cover constant value used in function call.
  this cover all usage of constant value.

It pass the "make check" test ( I have to fix a problem with
the bool type which is 1 bit integer). The V1 pass the kernel
checker test with no change to output.

Dibyendu, can you give this series some test since you report
it?

The git url:
https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=pseudo-sized-value-v2

Chris
