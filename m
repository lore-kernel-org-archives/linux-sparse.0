From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 3/3] Add NOWARN and NOERR compile conditions
Date: Mon, 3 Aug 2015 07:47:29 -0400
Message-ID: <55BF54D1.7070907@redhat.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
 <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
 <20150730025502.GA1692@x> <55BA0E4E.7000508@redhat.com>
 <CANeU7Qm=nv85N6MWZ=Lo=OLWEmyEOOk84AHbBwFAgfUfhBonbg@mail.gmail.com>
 <55BCA8D2.1040808@redhat.com>
 <CANeU7QkK5N8Jskcq9J1ODCeZEQYSAJTW-6PdKg1uuZeNXPYKTA@mail.gmail.com>
 <55BEA62A.6070604@redhat.com> <87lhdsmx8p.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbbHCLra (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 3 Aug 2015 07:47:30 -0400
In-Reply-To: <87lhdsmx8p.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 08/03/2015 07:23 AM, Nicolai Stange wrote:
> Hi Tony,
>
> Tony Camuso <tcamuso@redhat.com> writes:
>> Here's one that might be a sparse bug.
>>
>> /work/linux/fs/bio.i:5368:26: error: Expected ) at end of cast operator
>> /work/linux/fs/bio.i:5368:26: error: got __int128
>>
>> Here is the kernel source in include/linux/math64.h that causes the error.
>>
>> static inline __attribute__((no_instrument_function)) u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
>> {
>>   return (u64)(((unsigned __int128)a * mul) >> shift);
>> }
>
> This one is probably triggered by running sparse on gcc -E output.
>
> The mul_u64_u32_shr() implementation cited by you is protected by a
>    #if ... && defined(__SIZEOF_INT128__)
> in include/linux/math64.h
>
> __SIZEOF_INT128__ is #define'd by gcc but not by sparse.
>
>
> The reason for your parsing error messages is probably that
> declaration_specifiers() does not eat up the __int128, leaving this one
> to cast_expression().
>
> Could you please confirm that you did indeed run sparse on gcc -E
> output?
>
> Thank you,
>
> Nicolai

Yes, we are using -E to generate preprocessor output.

