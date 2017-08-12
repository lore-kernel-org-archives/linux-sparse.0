From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse-llvm test cases
Date: Sat, 12 Aug 2017 09:59:03 -0400
Message-ID: <CANeU7Qk-E0nxpoLs=H4Srt=ot+vsXPv5ff5nPp18UiJOrL=oNw@mail.gmail.com>
References: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
 <CANeU7Q=zF9hRqnNCN-+p0Y64yfkyaBvroeSP7faM4DSWW2RW5g@mail.gmail.com>
 <CACXZuxdvBVV+gDzWmFs=FA_s5Ric1djbF7mLNiea06SaSiqUOQ@mail.gmail.com>
 <CANeU7Qn-EWg+QPTij874YzR3OVvrgdH4SkwjoU3_ekjr+CPJjg@mail.gmail.com> <CACXZuxcoLbnfKuAT2y3ocqzmUWOxjLZNr_NRGG6ok03gYyUoOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34365 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbdHLN7E (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 09:59:04 -0400
Received: by mail-yw0-f177.google.com with SMTP id s143so35830005ywg.1
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 06:59:03 -0700 (PDT)
In-Reply-To: <CACXZuxcoLbnfKuAT2y3ocqzmUWOxjLZNr_NRGG6ok03gYyUoOg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Sat, Aug 12, 2017 at 9:46 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Yes, Python is an option. I guess now-a-days it is available on all platforms.
>

If python works for you, my current simple python script can be extend
to support more instruction understanding. I did not use it for testing
purpose. I use it to import the IR into python so I can run some experiment
algorithms in python. The function requirement to import the IR is very
similar here so we can reuse some code.

Chris
