From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH 3/3] Add NOWARN and NOERR compile conditions
Date: Mon, 03 Aug 2015 13:23:34 +0200
Message-ID: <87lhdsmx8p.fsf@gmail.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
	<1438216001-8862-4-git-send-email-tcamuso@redhat.com>
	<20150730025502.GA1692@x> <55BA0E4E.7000508@redhat.com>
	<CANeU7Qm=nv85N6MWZ=Lo=OLWEmyEOOk84AHbBwFAgfUfhBonbg@mail.gmail.com>
	<55BCA8D2.1040808@redhat.com>
	<CANeU7QkK5N8Jskcq9J1ODCeZEQYSAJTW-6PdKg1uuZeNXPYKTA@mail.gmail.com>
	<55BEA62A.6070604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37668 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbbHCLXi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 3 Aug 2015 07:23:38 -0400
Received: by wibud3 with SMTP id ud3so109409246wib.0
        for <linux-sparse@vger.kernel.org>; Mon, 03 Aug 2015 04:23:37 -0700 (PDT)
In-Reply-To: <55BEA62A.6070604@redhat.com> (Tony Camuso's message of "Sun, 2
	Aug 2015 19:22:18 -0400")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tony Camuso <tcamuso@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Tony,

Tony Camuso <tcamuso@redhat.com> writes:
> Here's one that might be a sparse bug.
>
> /work/linux/fs/bio.i:5368:26: error: Expected ) at end of cast operator
> /work/linux/fs/bio.i:5368:26: error: got __int128
>
> Here is the kernel source in include/linux/math64.h that causes the error.
>
> static inline __attribute__((no_instrument_function)) u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
> {
>  return (u64)(((unsigned __int128)a * mul) >> shift);
> }

This one is probably triggered by running sparse on gcc -E output.

The mul_u64_u32_shr() implementation cited by you is protected by a
  #if ... && defined(__SIZEOF_INT128__)
in include/linux/math64.h

__SIZEOF_INT128__ is #define'd by gcc but not by sparse.


The reason for your parsing error messages is probably that
declaration_specifiers() does not eat up the __int128, leaving this one
to cast_expression().

Could you please confirm that you did indeed run sparse on gcc -E
output?

Thank you,

Nicolai
