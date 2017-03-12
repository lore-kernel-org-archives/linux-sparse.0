From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm error in GEP offset
Date: Sun, 12 Mar 2017 15:01:23 +0000
Message-ID: <CACXZuxd=VaN_vi_+XkR1EuLgcc3QY4TQ9_vzsG-pCK_2r1=21g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:38575 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934115AbdCLPBZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 11:01:25 -0400
Received: by mail-it0-f41.google.com with SMTP id m27so19483054iti.1
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 08:01:24 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

The memops offset field in sparse linearized instruction is unsigned,
which is causing invalid memory access in sparse-llvm. A workaround
for this is to cast the offset to int in calc_memop_addr() function in
sparse-llvm:

 off = LLVMConstInt(int_type, (int) insn->offset, 0);

However, perhaps the offset should not be unsigned in the first place.

Regards
Dibyendu
