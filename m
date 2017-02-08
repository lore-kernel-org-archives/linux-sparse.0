From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 0/8] fix uses of killed instructions
Date: Thu, 9 Feb 2017 06:13:46 +0800
Message-ID: <CANeU7Qn9CqWmQ-VUY928xm2fogqMGpfEbaBw+LrtfDbOrLTNfQ@mail.gmail.com>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
 <CAExDi1RJ8rPE7n7eGmBRnSe3FudW28HF7DkVErmVmniZrwSQJQ@mail.gmail.com>
 <20170208165055.ibu47j2axwi2j53f@macpro.local> <CANeU7Qkc1qShbgresJbRZbORuzzcMR28vPvv38kwFxHiE15ZLQ@mail.gmail.com>
 <20170208213544.ahkbsgvikwdb7nsu@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35959 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdBHWNr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Feb 2017 17:13:47 -0500
Received: by mail-it0-f41.google.com with SMTP id c7so112225633itd.1
        for <linux-sparse@vger.kernel.org>; Wed, 08 Feb 2017 14:13:47 -0800 (PST)
In-Reply-To: <20170208213544.ahkbsgvikwdb7nsu@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 9, 2017 at 5:35 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> Strange. That is the only patch I found in my series.
>
> Well, it was the rigth patch in the sense that it had the right
> log message and stuff but the resulting diff was only correct
> within a 1 line context. With a 3 lines context 'git am' or
> a pure 'patch < ...' should have given a conflict as one of
> the patch that was initialy just after it
> (1856b3461 "fix killing OP_CAST & friends") made also some
> changes in the same lines and these two patch have now been
> exchanged.

I see. So what happen is that the git am rejects it while
the patch program has not problem apply the patch. So I take
the patched version, which was wrong in terms of conflict resolution.

I go through my logs, similar things happen in the following two commit.

684710647 testsuite: check patterns presence or absence in output
49118f27e2 testsuite: check the nbr of times a pattern should be present

"git am" initial rejects it but the patch program accepts it.

Can you double check this two changes sounds correct to you?
I did take a second look, seems normal to me.

Any way, your new version of patch is applied in sparse-next.

Chris
