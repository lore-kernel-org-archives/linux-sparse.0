From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/1] parser: add support for asm goto
Date: Fri, 11 Jun 2010 13:21:26 -0700
Message-ID: <AANLkTikFcgP9fOlzepBbrX4GM0ESJaMiHlT1v2bMUVBw@mail.gmail.com>
References: <1276158810-21313-1-git-send-email-jslaby@suse.cz>
	<AANLkTikFMmCaTyACFgGGU84XxPUtpbfz0b3U67ZHj-jJ@mail.gmail.com>
	<4C1250D3.10003@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57928 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756917Ab0FKUV1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 Jun 2010 16:21:27 -0400
Received: by gwj15 with SMTP id 15so1060175gwj.19
        for <linux-sparse@vger.kernel.org>; Fri, 11 Jun 2010 13:21:26 -0700 (PDT)
In-Reply-To: <4C1250D3.10003@suse.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jun 11, 2010 at 8:05 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> On 06/10/2010 09:18 PM, Christopher Li wrote:
>> Hi Jirl,
>
> Hi, (the last letter in my name should be small I :))

Ah, sorry about that.

>
> static inline int __static_cpu_has(unsigned char bit)
> {
> =A0 =A0 =A0 =A0asm goto("1: jmp %l[t_no]\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "2:\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ".section .altinstructions,\"a\"\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "1b\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0\n" =A0 =A0 =A0 =A0 /* no replaceme=
nt */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " .byte %P0\n" =A0 =A0 =A0 =A0 /* fea=
ture bit */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " .byte 2b - 1b\n" =A0 =A0 /* source =
len */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " .byte 0\n" =A0 =A0 =A0 =A0 =A0 /* r=
eplacement len */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " .byte 0xff + 0 - (2b-1b)\n" =A0/* p=
adding */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ".previous\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : : "i" (bit) : : t_no, ble);
> =A0 =A0 =A0 =A0return 1;
> t_no:
> =A0 =A0 =A0 =A0return 0;
> }
>

I will add that as test case.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
