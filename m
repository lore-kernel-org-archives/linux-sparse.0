From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Bad interaction between macro expansion and literal concatenation
Date: Fri, 30 Jan 2015 23:16:40 +0100
Message-ID: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33730 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763283AbbA3WQo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 30 Jan 2015 17:16:44 -0500
Received: by mail-lb0-f181.google.com with SMTP id u10so38564797lbd.12
        for <linux-sparse@vger.kernel.org>; Fri, 30 Jan 2015 14:16:43 -0800 (PST)
Received: from morgan.rasmusvillemoes.dk (ip-24-61.bnaa.dk. [84.238.24.61])
        by mx.google.com with ESMTPSA id zt4sm2973737lbb.3.2015.01.30.14.16.41
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Jan 2015 14:16:42 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I'm trying to write a type checker for the kernel's %p format extensions, but
I've run into a problem with sparse which I can't debug myself.

It seems that something goes wrong when sparse is concatenating literal
strings, one of which was hidden behind a macro. As a random example,
drivers/net/ethernet/realtek/atp.c:471 has this format string:

  KERN_DEBUG "%s: Reset: current Rx mode %d.\n"

KERN_DEBUG ultimately expands to "\001" "7". When I print the
corresponding ->string->data, I get

  ^A6%s7%s: Reset: current Rx mode %d.

(^A is just less' way of showing the \001 byte - that part is
fine). Note the extra "6%s". Needless to say, such random extra content
makes format string verification very hard...

If I replace KERN_DEBUG by its expansion "\001" "7", it works fine. If I
only replace it by its immediate replacement KERN_SOH "7", I see the
same bad behaviour.

Any ideas?

Rasmus
