From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm the LLVM IR for select instruction fails due to different types
Date: Tue, 14 Mar 2017 16:07:40 +0000
Message-ID: <CACXZuxcGKmEbv=Umh26U=Uermy+n1f2A9_ZmBYJHE15WBYPFrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37862 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbdCNQHm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Mar 2017 12:07:42 -0400
Received: by mail-it0-f46.google.com with SMTP id g138so2512338itb.0
        for <linux-sparse@vger.kernel.org>; Tue, 14 Mar 2017 09:07:42 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

LLVM complains when the operands of a select are not the same type. I
think it is okay to cast one of the operands to the type of the other
- on the basis that subsequent operations will cast things anyway.

Regards
Dibyendu
