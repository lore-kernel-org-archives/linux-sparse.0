From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm test cases
Date: Fri, 11 Aug 2017 00:50:06 +0200
Message-ID: <CAExDi1TKwLKy66m35CMc4QZ5nRAbZMMmcheTrxTWxHACoPMm5Q@mail.gmail.com>
References: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
 <CANeU7Q=zF9hRqnNCN-+p0Y64yfkyaBvroeSP7faM4DSWW2RW5g@mail.gmail.com> <CACXZuxdvBVV+gDzWmFs=FA_s5Ric1djbF7mLNiea06SaSiqUOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35042 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbdHJWuH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 18:50:07 -0400
Received: by mail-oi0-f52.google.com with SMTP id e124so20180904oig.2
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 15:50:07 -0700 (PDT)
In-Reply-To: <CACXZuxdvBVV+gDzWmFs=FA_s5Ric1djbF7mLNiea06SaSiqUOQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 10:44 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Yes, the current arrangement is a stop gap. As I develop both on
> Windows and Linux, I need a portable solution so I cannot really use
> shell scripts.

People use bash with mingwin, for example. Would it be something
usable for you?

>> Another question is that, I don't know how many your test get impact
>> by the llvm versions. If it get tight to a specific version of llvm, the
>> test case has less value. People will get false positives due to different
>> llvm version.

If it begin to be the case we'll need to add a new tag telling to ignore
the test if version this or that.

> The tests are all designed to be runnable

I think this is very very important.
Of course, you're interested in LLVM output but not only.

One thing I want to have for testing linearized code is a simulator
for sparse's IR. It's even something quite easy (or at least straightforward)
to do. At least once you can associate to each phi-node's 'argument' the
parent BB they come from. This is something I'm planning to do for several
reasons.

-- Luc
