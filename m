From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/1] parser: add support for asm goto
Date: Thu, 17 Jun 2010 17:35:56 -0700
Message-ID: <AANLkTimGxxcjL74Yxshk3ybzQld3uf3Yhuk6VNAvQZWA@mail.gmail.com>
References: <1276158810-21313-1-git-send-email-jslaby@suse.cz>
	<AANLkTikFMmCaTyACFgGGU84XxPUtpbfz0b3U67ZHj-jJ@mail.gmail.com>
	<4C1250D3.10003@suse.cz>
	<AANLkTikFcgP9fOlzepBbrX4GM0ESJaMiHlT1v2bMUVBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33812 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757262Ab0FRAf5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 17 Jun 2010 20:35:57 -0400
Received: by vws18 with SMTP id 18so120499vws.19
        for <linux-sparse@vger.kernel.org>; Thu, 17 Jun 2010 17:35:56 -0700 (PDT)
In-Reply-To: <AANLkTikFcgP9fOlzepBbrX4GM0ESJaMiHlT1v2bMUVBw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jun 11, 2010 at 1:21 PM, Christopher Li <sparse@chrisli.org> wr=
ote:
>> static inline int __static_cpu_has(unsigned char bit)
>> {
>> =A0 =A0 =A0 =A0asm goto("1: jmp %l[t_no]\n"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "2:\n"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ".section .altinstructions,\"a\"\n"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "\n"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "1b\n"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0\n" =A0 =A0 =A0 =A0 /* no replacem=
ent */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " .byte %P0\n" =A0 =A0 =A0 =A0 /* fe=
ature bit */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " .byte 2b - 1b\n" =A0 =A0 /* source=
 len */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " .byte 0\n" =A0 =A0 =A0 =A0 =A0 /* =
replacement len */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " .byte 0xff + 0 - (2b-1b)\n" =A0/* =
padding */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ".previous\n"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : : "i" (bit) : : t_no, ble);
>> =A0 =A0 =A0 =A0return 1;
>> t_no:
>> =A0 =A0 =A0 =A0return 0;
>> }
>>

Hi, I update the chrisl branch with your change and the test case.

Please verify it. I hope I did not do some thing stupid there.

It just hit me, is "asm volatile goto" or "asm goto volatile" valid?
If so, the asm goto code needs some change.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
