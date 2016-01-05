From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse error on __int128
Date: Tue, 5 Jan 2016 01:08:02 +0100
Message-ID: <20160105000800.GA12116@macpro.local>
References: <55C9DD4F.9050805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37953 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbcAEAIS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jan 2016 19:08:18 -0500
Received: by mail-wm0-f54.google.com with SMTP id b14so5781131wmb.1
        for <linux-sparse@vger.kernel.org>; Mon, 04 Jan 2016 16:08:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <55C9DD4F.9050805@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tony Camuso <tcamuso@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Tue, Aug 11, 2015 at 07:32:31AM -0400, Tony Camuso wrote:
> I think I've raised this question before, but I don't think I
> got a response that indicated whether this is a sparse bug or
> if there was a source or compile issue.
> 
> Here is the error:
> sparse /work/rh7/drivers/net/wireless/rtlwifi/rtl8723com/fw_common.i
> /work/rh7/drivers/net/wireless/rtlwifi/rtl8723com/fw_common.i:5505:26: error: impossible combination of type specifiers: unsigned __int128
> /work/rh7/drivers/net/wireless/rtlwifi/rtl8723com/fw_common.i:5505:26: error: Expected ) at end of cast operator
> /work/rh7/drivers/net/wireless/rtlwifi/rtl8723com/fw_common.i:5505:26: error: got __int128
> 
> Here is the offending line in context:
> 
>  5503 static inline __attribute__((no_instrument_function)) u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
>  5504 {
>  5505  return (u64)(((unsigned __int128)a * mul) >> shift);
>  5506 }
> 


Hi,

There is no source or compile issue here.
It's just that __int128 is only defined by gcc on x86_64
but is not defined by sparse.

Now, __int128 is only used twice in the kernel:
(mul_u64_u32_shr() & mul_u64_u64_shr()) and then only if
supported by the platform and if __SIZEOF_INT128__ is defined.
Since sparse doesn't define __SIZEOF_INT128__ there shouldn't be any problems
but you have used sparse not on the code itself but on preprocessed code by gcc.
If you run sparse directly on the C code or more simply by using "make C=1 ..."
to build kernel code, no such problem occurs.

Now, of course, one could argue that sparse should also define __int128
on platforms where gcc define it, on x86_64 thus.


Regards,
Luc
