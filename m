From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse-llvm test cases
Date: Thu, 10 Aug 2017 16:59:22 -0400
Message-ID: <CANeU7Qn-EWg+QPTij874YzR3OVvrgdH4SkwjoU3_ekjr+CPJjg@mail.gmail.com>
References: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
 <CANeU7Q=zF9hRqnNCN-+p0Y64yfkyaBvroeSP7faM4DSWW2RW5g@mail.gmail.com> <CACXZuxdvBVV+gDzWmFs=FA_s5Ric1djbF7mLNiea06SaSiqUOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35364 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752800AbdHJU7X (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 16:59:23 -0400
Received: by mail-yw0-f170.google.com with SMTP id l82so12078309ywc.2
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 13:59:23 -0700 (PDT)
In-Reply-To: <CACXZuxdvBVV+gDzWmFs=FA_s5Ric1djbF7mLNiea06SaSiqUOQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Thu, Aug 10, 2017 at 4:44 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Yes, the current arrangement is a stop gap. As I develop both on
> Windows and Linux, I need a portable solution so I cannot really use
> shell scripts.

Can you use python scripts? Just asking.

> The tests are all designed to be runnable - i.e. you can generate the
> code and run it either with lli or by generating an executable - so
> they are completely independent of LLVM version. But they do need all

That is good to know. Thanks for the clarification.

> the LLVM fixes that are still pending as without those fixes most
> tests won't even compile. Nevertheless we can start incorporating
> these tests gradually so that when the LLVM fixes are all in then we
> will have a good set of tests.
>
> I would prefer to add validation of the Sparse IR as well - at present
> I record these but do not try to validate mainly as I think Sparse IR
> output is still changing so we need to get to a stable point first.

I think we should design the test frame work to take into account
for the IR changes. e.g. Ignore the IR that does not recognize.

That being said, I do wish the IR has less changes.

I am not sure how many IR changes in Luc's pending patches.
The OP_PUSH one I assume we can avoid, as I comment on
the original discussion thread.

Chris
