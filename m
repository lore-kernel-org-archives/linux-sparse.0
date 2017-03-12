From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse linear instruction offset for memops
Date: Sun, 12 Mar 2017 14:46:18 +0000
Message-ID: <CACXZuxcS5c-QS-KzDjxMD6j5MVAJfKicDaKRR6V10NQTKqHLcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:33366 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933174AbdCLOqU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 10:46:20 -0400
Received: by mail-io0-f170.google.com with SMTP id f84so70355951ioj.0
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 07:46:19 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi

I am investigating a crash in the avltree test program I mentioned
before. I noticed the following:

Linearised output:

 load.64     %r338 <- -16[%r333]

LLVM output:

  %10 = getelementptr inbounds i8, i8* %9, i64 4294967280

Instead of -16 we are getting a garbage offset. This appears to be
caused by the fact that the offset field in the instruction is
unsigned. Should the offset be a signed field instead?

Regards
Dibyendu
