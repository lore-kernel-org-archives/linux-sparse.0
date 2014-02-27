From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V2] sparse: Allow override of sizeof(bool) warning
Date: Thu, 27 Feb 2014 12:26:14 -0800
Message-ID: <faa9e231-d561-417b-8b8b-95192cb0e56a@email.android.com>
References: <1393462087.24588.50.camel@joe-AO722> <530E8C2E.7080307@zytor.com> <1393466619.24588.65.camel@joe-AO722> <20140227022857.GC23659@thin> <1393469594.24588.71.camel@joe-AO722> <20140227025845.GA25145@thin> <530EB103.5070406@zytor.com> <1393472326.24588.82.camel@joe-AO722> <20140227040050.GA8449@nicira.com> <530EBCED.9020705@zytor.com> <20140227042636.GA9592@nicira.com> <530EBFC7.9030309@zytor.com> <CANeU7Q=RNXR00bQcPzJYTOcZmRSn3U31ZcadPTHu6Y_Uk0UnYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60005 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbaB0U0t (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 27 Feb 2014 15:26:49 -0500
In-Reply-To: <CANeU7Q=RNXR00bQcPzJYTOcZmRSn3U31ZcadPTHu6Y_Uk0UnYw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Ben Pfaff <blp@nicira.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

I would.

On February 27, 2014 12:22:45 PM PST, Christopher Li <sparse@chrisli.org> wrote:
>On Wed, Feb 26, 2014 at 8:32 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> Quite frankly, this is silly in my opinion, *and* it is not
>guaranteed
>> by C either (read about "trap representations").
>>>
>> Anything that moves data around in a generic fashion.  It can be as
>> simple as:
>>
>>         memcpy(foo, bar, sizeof *foo);
>
>OK. I get it nobody wants a sizeof(_Bool) warning.
>
>I am going to apply this patch.
>
>Should we change the default to off then?
>
>Thanks.
>
>Chris

-- 
Sent from my mobile phone.  Please pardon brevity and lack of formatting.
