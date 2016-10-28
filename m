From: Thor Thayer <tthayer@opensource.altera.com>
Subject: NiosII GCC Compiler Built-Ins Question
Date: Fri, 28 Oct 2016 09:21:34 -0500
Message-ID: <2a743451-2dda-a16c-6eec-a43e223c5c53@opensource.altera.com>
Reply-To: <tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bl2nam02on0049.outbound.protection.outlook.com ([104.47.38.49]:63488
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754044AbcJ1OP3 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 28 Oct 2016 10:15:29 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

When I'm running sparse on my NiosII Linux build, I'm seeing many errors 
concerning an undefined identifier which is actually a GCC built-in for 
the NiosII architecture [1].

./arch/nios2/include/asm/irqflags.h:25:16: error: undefined identifier 
'__builtin_rdctl'
./arch/nios2/include/asm/irqflags.h:25:16: error: not a function <noident>
./arch/nios2/include/asm/irqflags.h:34:9: error: undefined identifier 
'__builtin_wrctl'
./arch/nios2/include/asm/irqflags.h:34:9: error: not a function <noident>

Googling this error led me to 2 possible solutions.
1. Comment it out in the Linux source [2].
2. Additions in the sparse lib.c file [3].

#2 was accepted but that built-in seems to be generic for all 
architectures. In my case, this is only for the GCC compiler for NiosII.

What is the best way to handle a built-in for a specific architecture?

Thanks,

Thor

Links:
[1] 
https://gcc.gnu.org/onlinedocs/gcc/Altera-Nios-II-Built-in-Functions.html
[2] https://lkml.org/lkml/2015/6/15/616
[3] http://comments.gmane.org/gmane.comp.parsers.sparse/3402

