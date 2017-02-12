From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 0/8] fix uses of killed instructions
Date: Mon, 13 Feb 2017 00:25:45 +0100
Message-ID: <CAExDi1RcL5J_hKxS_7R2s+fNq_YCLab6PaWr2QHMbx6sygij8w@mail.gmail.com>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
 <CAExDi1RJ8rPE7n7eGmBRnSe3FudW28HF7DkVErmVmniZrwSQJQ@mail.gmail.com>
 <20170208165055.ibu47j2axwi2j53f@macpro.local> <CANeU7Qkc1qShbgresJbRZbORuzzcMR28vPvv38kwFxHiE15ZLQ@mail.gmail.com>
 <20170208213544.ahkbsgvikwdb7nsu@macpro.local> <CANeU7Qn9CqWmQ-VUY928xm2fogqMGpfEbaBw+LrtfDbOrLTNfQ@mail.gmail.com>
 <20170208222805.c77ilwchxpg2vnx4@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:32777 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdBLXZr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:25:47 -0500
Received: by mail-qk0-f193.google.com with SMTP id 11so12356705qkl.0
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:25:46 -0800 (PST)
In-Reply-To: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 8, 2017 at 11:28 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Feb 09, 2017 at 06:13:46AM +0800, Christopher Li wrote:
>> I see. So what happen is that the git am rejects it while
>> the patch program has not problem apply the patch. So I take
>> the patched version, which was wrong in terms of conflict resolution.
>>
>> I go through my logs, similar things happen in the following two commit.
>>
>> 684710647 testsuite: check patterns presence or absence in output
>> 49118f27e2 testsuite: check the nbr of times a pattern should be present
>>
>> "git am" initial rejects it but the patch program accepts it.
>>
>> Can you double check this two changes sounds correct to you?
>> I did take a second look, seems normal to me.
>
> I just checked, two chunks of the second of these patches are in
> another place than what I have here in my original tree but
> it's equivalent regarding functionality.

Sigh. I was a bit short on time when checking this and the diff I looked
at was somehow misleading but in fact the functionality is not at all equivalent
although all the tests did the expected result.

I'm resending a respin of the two concerned series.

Luc
