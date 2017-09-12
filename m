From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Experimenting with dmrC as backend for Lua
Date: Tue, 12 Sep 2017 13:00:53 +0100
Message-ID: <CACXZuxfq7-GZX_CjPCtFnt1GoUzDhH4mvy8Hpt9sULdL-K=RvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:38755 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdILMA4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 08:00:56 -0400
Received: by mail-ua0-f173.google.com with SMTP id l24so14764227uaa.5
        for <linux-sparse@vger.kernel.org>; Tue, 12 Sep 2017 05:00:55 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I have a JIT implementation for Lua that uses LLVM. Creating the LLVM
IR by hand is tedious and error prone, as well as makes it harder to
implement things because it is difficult to make changes.

I have started a new implementation that generates C "assembler" code
and then uses dmrC to translate to machine code. This has several
practical advantages:

1. Much easier to understand and maintain the intermediate C code.
2. Can re-target to LLVM or another JIT engine - in my experiments I
am using NanoJIT to start with - without having to change the layer
that compiles from Lua to JIT!

Of course the added translation from C to the IR used by the JIT
engine is an extra step, and I have not yet benchmarked this against
hand-written IR.

This is still work in progress, but it is looking promising already.

One interesting thing is that the generated C code only has gotos - no
higher level structured programming concepts!


Regards
Dibyendu
