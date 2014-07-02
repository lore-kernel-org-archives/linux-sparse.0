From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCHv2 0/3] catch non-sign-extended '~' brainos
Date: Wed, 2 Jul 2014 01:51:25 -0700
Message-ID: <CANeU7Q=RV4xC8REQg_LP5VJz9-WB-+o6UEo5N2Fea9Y2WqdSnA@mail.gmail.com>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
	<1402386847-23477-1-git-send-email-phil@dovecot.fi>
	<20140627111900.GA19158@phil.dovecot.net>
	<CANeU7QkVj1gm3wQ6r1=akKX9W1cQvE3Un32CD=1UBecFCaq18Q@mail.gmail.com>
	<20140630085603.GB19158@phil.dovecot.net>
	<CANeU7Q=Z=Xac_T3JRAyqo_fF4LAKD-MM41NYz+nDstDutcVUfA@mail.gmail.com>
	<20140701113035.GC19158@phil.dovecot.net>
	<CANeU7QnQHzUHwP3imkcX2JX0NrR50rYjjXdObO1D03oHXQ82aA@mail.gmail.com>
	<20140702074329.GD19158@phil.dovecot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:65097 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbaGBIv0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Jul 2014 04:51:26 -0400
Received: by mail-qg0-f45.google.com with SMTP id a108so4318366qge.18
        for <linux-sparse@vger.kernel.org>; Wed, 02 Jul 2014 01:51:25 -0700 (PDT)
In-Reply-To: <20140702074329.GD19158@phil.dovecot.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Phil Carmody <phil@dovecot.fi>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jul 2, 2014 at 12:43 AM, Phil Carmody <phil@dovecot.fi> wrote:
>
> Do you care about the precise type of the value?
> If you do, then it may be ugly, but it's pretty much obligatory.
> And if you don't care about the precise type...

Yes, I make a mistake on my macro. But alignment can be
precise being unsigned. In a 32 bit system, what if I want to make
a 2G align memory? Your signed alignment will force to be a
negative value. Which is not precise.

>> I don't consider alignment being 4U as wrong by itself. The key question
>> is how you use it.
>
> Absolutely. And doing a ~ and then an up-cast is using it dangerously.
> Isn't that what sparse is supposed to be checking for?

Well, you still need to get the false positive rate down. Currently then
signal to noise ratio is too low. I would not recommend turning it on
by default. Did you find some real bug in that 500 error report? Real
bug I mean it produce actually bug on the object code it generated.

>
>> if we introduce:
>>
>> #define ALIGNMASK(align)   (size_t)(~((align) -1))
>>
>> And we always use the macro to create mask from alignment value.
>> Then there is no need to enforce signedness of the var passed into the
>> macro. Hey, it might even read better.
>
> Put 4U in that, and it still has the flaw of creating a truncated mask.
> Put 4 in and it doesn't.

Right, I make a mistake on that macro. Good catch.  How about

#define ALIGNMASK(align)   (~((size_t)((align) -1)))

Will you be happy if I use 4U with that macro?

My point is, with the right macro, you can still use 4U to create
alignment. We don't have to fight over 4U vs 4.

Chris
