From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 0/7] fixes for rare issues
Date: Tue, 1 Aug 2017 22:46:02 +0200
Message-ID: <CAExDi1Tq2SuzS9iCyR0ct00uw8ACnGBiAND58drfeXSUoFd5LQ@mail.gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qk4cRLtKmPxSVCEe9WJLEb8VajdCiokNV=ic4YALvKcqw@mail.gmail.com>
 <CAExDi1TQh2kFXbyMgX_1tTG0b2F-k-_+CNDJeiKiBW0T0Q4nEA@mail.gmail.com>
 <CAExDi1Qoq21smgUvkqmdTxeJwdYJikC8taFYTdzBmx6Zea5tYg@mail.gmail.com> <CAExDi1Sm1dUM3FQ838_5kr2maejva6tzc8NYzRtxV1KprgijhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33015 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbdHAUqD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 1 Aug 2017 16:46:03 -0400
Received: by mail-qt0-f180.google.com with SMTP id a18so16416384qta.0
        for <linux-sparse@vger.kernel.org>; Tue, 01 Aug 2017 13:46:03 -0700 (PDT)
In-Reply-To: <CAExDi1Sm1dUM3FQ838_5kr2maejva6tzc8NYzRtxV1KprgijhA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Michael Stefaniuc <mstefani@mykolab.com>

On Tue, Aug 1, 2017 at 12:42 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

>> One of the thing I haven't tested is the performance.
>> Several things here can make things slower:
>> - REPEAT_CFG_CLEANUP is now set after every call to rewrite_branch()
>>   (and will then trigger at some point a call to kill_unreachable_bbs())
>> - kill_unreachable_bbs() set REPEAT_CSE is a BB have been deleted
>>   (which may trigger another CSE cycle possibly not present before)
>> - the bb_depends_on() change add some code with looping through
>>   the BB's instructions, nothing really heavy but still some more code
>>   to run
>> All these are needed though.
>
> And indeed I see that some tests that took me 38s now take 48s.
> I'll look tomorrow for the real cause and see what can be done there.

OK. That was a false alert, I was still running with debug on.

-- Luc
