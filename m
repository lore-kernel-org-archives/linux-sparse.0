From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Update on dmr_C project
Date: Fri, 31 Mar 2017 01:30:27 +0100
Message-ID: <CACXZuxeDk+nyFb1548_rc5j27iBgT8awL6yz4PQpQStih1G19w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:36493 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934931AbdCaAaf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 20:30:35 -0400
Received: by mail-it0-f50.google.com with SMTP id e75so4233816itd.1
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 17:30:34 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

Just a quick update on dmr_C project.

+ I am now able to compile minilua using sparse-llvm (dmr_C version)
and run a simple hello.lua script. Even running a simple Lua script
like this entails quite a lot, so I am really pleased to hit this
milestone.

+ The sparse-llvm functionality is now exposed as a library function.

+ All functions with external linkage have been renamed to have prefix of dmrC_.

+ I was finally able to complete the change to ptrlist so that almost
all global state is now gone. There are some static int counters
remaining that I need to fix.

I wanted to thank you for the help given to me over the past few
weeks, and of course for creating Sparse in the first place.

Although there is still more testing to do, and bugs to fix, I will
now start work in parallel on a different backend to sparse that does
not use LLVM. I will report progress when there is something to show.

Thanks and Regards
Dibyendu
