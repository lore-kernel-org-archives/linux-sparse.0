From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 0/7] fixes for rare issues
Date: Tue, 1 Aug 2017 00:42:17 +0200
Message-ID: <CAExDi1Sm1dUM3FQ838_5kr2maejva6tzc8NYzRtxV1KprgijhA@mail.gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qk4cRLtKmPxSVCEe9WJLEb8VajdCiokNV=ic4YALvKcqw@mail.gmail.com>
 <CAExDi1TQh2kFXbyMgX_1tTG0b2F-k-_+CNDJeiKiBW0T0Q4nEA@mail.gmail.com> <CAExDi1Qoq21smgUvkqmdTxeJwdYJikC8taFYTdzBmx6Zea5tYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36788 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGaWmT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 18:42:19 -0400
Received: by mail-qt0-f182.google.com with SMTP id v29so96268128qtv.3
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 15:42:19 -0700 (PDT)
In-Reply-To: <CAExDi1Qoq21smgUvkqmdTxeJwdYJikC8taFYTdzBmx6Zea5tYg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Michael Stefaniuc <mstefani@mykolab.com>

On Tue, Aug 1, 2017 at 12:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Jul 31, 2017 at 11:54 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Mon, Jul 31, 2017 at 11:01 PM, Christopher Li <sparse@chrisli.org> wrote:
>>> On Mon, Jul 31, 2017 at 4:36 PM, Luc Van Oostenryck
>>> <luc.vanoostenryck@gmail.com> wrote:
>>>> This series contains some fixes for crashes I found during
>>>> some fuzzy-testing, as well as for some infinite loops
>>>> that may happen during simplification.
>>>
>>> Thank you so much for the patch.
>>>
>>> I have to ask, is it for review (for now) or request to pull to
>>> sparse-next (drop the previous version in sparse-next)?
>>
>> It's for review & test as one patch is really changed and two
>> are new and while small induce big changes.
>
> One of the thing I haven't tested is the performance.
> Several things here can make things slower:
> - REPEAT_CFG_CLEANUP is now set after every call to rewrite_branch()
>   (and will then trigger at some point a call to kill_unreachable_bbs())
> - kill_unreachable_bbs() set REPEAT_CSE is a BB have been deleted
>   (which may trigger another CSE cycle possibly not present before)
> - the bb_depends_on() change add some code with looping through
>   the BB's instructions, nothing really heavy but still some more code
>   to run
> All these are needed though.

And indeed I see that some tests that took me 38s now take 48s.
I'll look tomorrow for the real cause and see what can be done there.

-- Luc
