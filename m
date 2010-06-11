From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/1] parser: add support for asm goto
Date: Fri, 11 Jun 2010 17:05:55 +0200
Message-ID: <4C1250D3.10003@suse.cz>
References: <1276158810-21313-1-git-send-email-jslaby@suse.cz> <AANLkTikFMmCaTyACFgGGU84XxPUtpbfz0b3U67ZHj-jJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42759 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab0FKPGB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 Jun 2010 11:06:01 -0400
Received: by yxl31 with SMTP id 31so298140yxl.19
        for <linux-sparse@vger.kernel.org>; Fri, 11 Jun 2010 08:06:00 -0700 (PDT)
In-Reply-To: <AANLkTikFMmCaTyACFgGGU84XxPUtpbfz0b3U67ZHj-jJ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 06/10/2010 09:18 PM, Christopher Li wrote:
> Hi Jirl,

Hi, (the last letter in my name should be small I :))

> Can you add a validations test case for me? It would be great to see
> sparse fail on the test case then your patch makes it work.

static inline int __static_cpu_has(unsigned char bit)
{
        asm goto("1: jmp %l[t_no]\n"
                 "2:\n"
                 ".section .altinstructions,\"a\"\n"
                 "\n"
                 "1b\n"
                 "0\n"         /* no replacement */
                 " .byte %P0\n"         /* feature bit */
                 " .byte 2b - 1b\n"     /* source len */
                 " .byte 0\n"           /* replacement len */
                 " .byte 0xff + 0 - (2b-1b)\n"  /* padding */
                 ".previous\n"
                 : : "i" (bit) : : t_no, ble);
        return 1;
t_no:
        return 0;
}

> Some minor nitpick follows. If you are busy, just give me the test case,
> I can do the rest of the change for you,

If you could do it, I would appreciate that.

thanks,
-- 
js
suse labs
