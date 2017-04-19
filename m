From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] CSE: relax type checking in hashing/compare
Date: Tue, 18 Apr 2017 17:32:25 -0700
Message-ID: <CANeU7QmbJTuZ5B_9V3ns7d67KZLcK229SGc2OWBdCcCLeZ6TqQ@mail.gmail.com>
References: <20170217000608.6433-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=Uv0Xb=9PvpSdeoe4epMD0d5UTHED+xx2N7e7XmDkY9w@mail.gmail.com> <20170227094013.pevbixjonnebaaxa@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37828 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757817AbdDSAc0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Apr 2017 20:32:26 -0400
Received: by mail-it0-f54.google.com with SMTP id a140so4478649ita.0
        for <linux-sparse@vger.kernel.org>; Tue, 18 Apr 2017 17:32:26 -0700 (PDT)
In-Reply-To: <20170227094013.pevbixjonnebaaxa@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Feb 27, 2017 at 1:40 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Feb 27, 2017 at 04:11:44PM +0800, Christopher Li wrote:
>> On Fri, Feb 17, 2017 at 8:06 AM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>> > I'm missing something?
>> >
>> > If not, then the following simple patch should be correct.
>>
>> This patch is missing a S-O-B. Can you add one?
>
> I did this purposely because it was a RFC.
> Also:
> - I still have some doubts about this patch
> - It won't solve anything, only allow more CSE (but maybe more than
>   really wanted)
> - There is no urgency at all.
>
> So I think it would be better to not include it in the coming release
> and instead let it ripe a little bit.

I am catching up with the patches in the order it was send out. I will
leave this
one alone then.

Chris
