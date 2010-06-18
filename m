From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/1] parser: add support for asm goto
Date: Fri, 18 Jun 2010 10:21:41 +0200
Message-ID: <4C1B2C95.8000903@suse.cz>
References: <1276158810-21313-1-git-send-email-jslaby@suse.cz>	<AANLkTikFMmCaTyACFgGGU84XxPUtpbfz0b3U67ZHj-jJ@mail.gmail.com>	<4C1250D3.10003@suse.cz>	<AANLkTikFcgP9fOlzepBbrX4GM0ESJaMiHlT1v2bMUVBw@mail.gmail.com> <AANLkTimGxxcjL74Yxshk3ybzQld3uf3Yhuk6VNAvQZWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:39093 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758065Ab0FRIVk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Jun 2010 04:21:40 -0400
Received: by fg-out-1718.google.com with SMTP id l26so307896fgb.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Jun 2010 01:21:38 -0700 (PDT)
In-Reply-To: <AANLkTimGxxcjL74Yxshk3ybzQld3uf3Yhuk6VNAvQZWA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 06/18/2010 02:35 AM, Christopher Li wrote:
> On Fri, Jun 11, 2010 at 1:21 PM, Christopher Li <sparse@chrisli.org> wrote:
>>> static inline int __static_cpu_has(unsigned char bit)
>>> {
>>>        asm goto("1: jmp %l[t_no]\n"
>>>                 "2:\n"
>>>                 ".section .altinstructions,\"a\"\n"
>>>                 "\n"
>>>                 "1b\n"
>>>                 "0\n"         /* no replacement */
>>>                 " .byte %P0\n"         /* feature bit */
>>>                 " .byte 2b - 1b\n"     /* source len */
>>>                 " .byte 0\n"           /* replacement len */
>>>                 " .byte 0xff + 0 - (2b-1b)\n"  /* padding */
>>>                 ".previous\n"
>>>                 : : "i" (bit) : : t_no, ble);
>>>        return 1;
>>> t_no:
>>>        return 0;
>>> }
>>>
> 
> Hi, I update the chrisl branch with your change and the test case.
> 
> Please verify it. I hope I did not do some thing stupid there.

Where can I find it?

> It just hit me, is "asm volatile goto" or "asm goto volatile" valid?
> If so, the asm goto code needs some change.

Holy crap, in docco, there is nothing like that, but I checked gcc
parser sources to be sure, and there indeed is:
     asm type-qualifier[opt] ( asm-argument ) ;
     asm type-qualifier[opt] goto ( asm-goto-argument ) ;
So yes, asm volatile goto is valid. Would you take care of that?

-- 
js
suse labs
