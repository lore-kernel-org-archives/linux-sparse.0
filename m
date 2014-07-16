From: Christopher Li <sparse@chrisli.org>
Subject: Re: [sparse PATCH RFC] Revert "Revert "sparse: Bump up sizeof(_Bool)
 to 8 bits""
Date: Tue, 15 Jul 2014 20:21:40 -0700
Message-ID: <CANeU7QngLBOJ-uMV0DFY6sqyi=SbTGJZ6TNZZYnY1jsVsUf12w@mail.gmail.com>
References: <1405439200-27515-1-git-send-email-jlayton@primarydata.com>
	<CANeU7QnRHvOQHHE2EEWNSUEwFRv66gmHfNXmgZxN+_J7=iPbHg@mail.gmail.com>
	<20140715222350.028a7bf6@f20.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:56459 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbaGPDVk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Jul 2014 23:21:40 -0400
Received: by mail-qc0-f179.google.com with SMTP id r5so245565qcx.38
        for <linux-sparse@vger.kernel.org>; Tue, 15 Jul 2014 20:21:40 -0700 (PDT)
In-Reply-To: <20140715222350.028a7bf6@f20.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jeff.layton@primarydata.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>

On Tue, Jul 15, 2014 at 7:23 PM, Jeff Layton
<jeff.layton@primarydata.com> wrote:
> On Tue, 15 Jul 2014 12:51:02 -0700
>> --- a/target.h
>> +++ b/target.h
>> @@ -49,7 +49,7 @@ extern int enum_alignment;
>>
>>  static inline int bits_to_bytes(int bits)
>>  {
>> -       return bits >= 0 ? bits / bits_in_char : -1;
>> +       return bits >= 0 ? (bits + bits_in_char - 1) / bits_in_char : -1;
>>  }
>>
>
> This makes the bitfield.c validation test fail:
>
>      TEST     bitfield to integer promotion (bitfields.c)
> error: actual error text does not match expected error text.
> error: see bitfields.c.error.* for further investigation.
> --- bitfields.c.error.expected  2014-07-15 22:01:09.236942195 -0400
> +++ bitfields.c.error.got       2014-07-15 22:01:09.237942176 -0400
> @@ -0,0 +1,2 @@
> +bitfields.c:16:19: warning: invalid access past the end of 'y' (0 1)
> +bitfields.c:16:19: warning: invalid access past the end of 'y' (0 1)
>
> Though I haven't looked in detail yet as to why it's failing.

Let me take a look and get back to you. I recall there are one more
place in array handling need to use  bits_to_bytes() instead of reference
the bit size directly.

Chris
