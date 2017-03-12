From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Error handling in sparse-llvm
Date: Sun, 12 Mar 2017 19:40:18 +0000
Message-ID: <CACXZuxcU4ZQ0=D67F4EkqyFKANQVjhSxfSzsqdzXbNXYsGXGfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:36609 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934652AbdCLTkU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 15:40:20 -0400
Received: by mail-io0-f174.google.com with SMTP id l7so73454009ioe.3
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 12:40:19 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

At present there are a bunch of asserts for scenarios not handled by
Sparse LLVM backend. A more robust error handling method is needed
that works even in release builds, and doesn't abort the process.
Given the way the code is structured currently, I was thinking maybe
it will be easiest to use setjmp/longjmp mechanism to terminate the
LLVM backend on error. I am not sure that this entirely safe with LLVM
as the LLVM code is C++ - I think it might be okay as long as the LLVM
module / context is properly disposed at the end.

Regards
Dibyendu
