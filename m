From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Tue, 11 Jul 2017 22:04:08 +0100
Message-ID: <CACXZuxerM5i33YgKn=GfnWQe+pViCUfUmJ10sz0K-+PjG28uwA@mail.gmail.com>
References: <CANeU7QmpvfZutvnSwrjH7ZYXhw3S3HDh19eHXkBGY7oz7ADtmw@mail.gmail.com>
 <CANeU7Q=d_+QD+MSGyYqwL82M2RdC_AFVaeR-y87z3U3OKjNBKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:32805 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932536AbdGKVEK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Jul 2017 17:04:10 -0400
Received: by mail-wr0-f171.google.com with SMTP id r103so6047461wrb.0
        for <linux-sparse@vger.kernel.org>; Tue, 11 Jul 2017 14:04:09 -0700 (PDT)
In-Reply-To: <CANeU7Q=d_+QD+MSGyYqwL82M2RdC_AFVaeR-y87z3U3OKjNBKw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

On 11 July 2017 at 21:53, Christopher Li <sparse@chrisli.org> wrote:
> Ping, Any taker want to review or suggest alternative
> way to fix the nested loop delete bug?
>
>> Instead of marking the entry deleted. I just use a duplicate
>> version of the list->list[] when doing the loop. It will have
>> unwanted effect that iterator will issue some ptr are already
>> deleted. Other than that, it is very straight forward.
>>

I think that duplicating a list because that list is being modified is
quite a sensible thing to do. My only suggestion would be that perhaps
you could have a dup() step that is separate so that you can use the
normal iterator macro after duplicating.

Regards
Dibyendu
