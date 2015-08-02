From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 3/3] Add NOWARN and NOERR compile conditions
Date: Sun, 2 Aug 2015 19:22:18 -0400
Message-ID: <55BEA62A.6070604@redhat.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
 <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
 <20150730025502.GA1692@x> <55BA0E4E.7000508@redhat.com>
 <CANeU7Qm=nv85N6MWZ=Lo=OLWEmyEOOk84AHbBwFAgfUfhBonbg@mail.gmail.com>
 <55BCA8D2.1040808@redhat.com>
 <CANeU7QkK5N8Jskcq9J1ODCeZEQYSAJTW-6PdKg1uuZeNXPYKTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44245 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbbHBXWV (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 2 Aug 2015 19:22:21 -0400
In-Reply-To: <CANeU7QkK5N8Jskcq9J1ODCeZEQYSAJTW-6PdKg1uuZeNXPYKTA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 08/01/2015 02:45 PM, Christopher Li wrote:
> On Sat, Aug 1, 2015 at 4:09 AM, Tony Camuso <tcamuso@redhat.com> wrote:
>>
>> I've since submitted a runtime patch (3/3 V3) with a switch as a
>> response to this patch, but it basically does the same thing here.
>>
>> Consider the case where the source contains something like this...
>>
>>          struct foo {
>>                  union {
>>                          int number;
>>                          int *pointer;
>>                  };
>>          };
>>
>> There being no ident for the union within the struct, we get the warning,
>> "missing identifier in declaration" etc.
>>
>
> I can't reproduce the warning with the chrisl repo master branch.
>
> That being said, if there is indeed a bug in sparse, it should be a
> separate patch. It changes the parsing behavior.
>
> Thanks
>
> Chris
>

Here's one that might be a sparse bug.

/work/linux/fs/bio.i:5368:26: error: Expected ) at end of cast operator
/work/linux/fs/bio.i:5368:26: error: got __int128

Here is the kernel source in include/linux/math64.h that causes the error.

static inline __attribute__((no_instrument_function)) u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
{
  return (u64)(((unsigned __int128)a * mul) >> shift);
}

