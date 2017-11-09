From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Makefile: use locally built sparse in the selfcheck
 target
Date: Thu, 9 Nov 2017 18:06:45 +0100
Message-ID: <20171109170644.vn6ktpk2newq5ps3@ltop.local>
References: <10d6a020-ebe8-6a31-e4cb-ff67c1a1009c@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:32811 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdKIRGt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 12:06:49 -0500
Received: by mail-wm0-f45.google.com with SMTP id r68so2988371wmr.0
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 09:06:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <10d6a020-ebe8-6a31-e4cb-ff67c1a1009c@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>


Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


BTW, selfcheck also fails when reaching sparse-llvm.c because of
the use of CFLAGS/BASIC_CFLAGS/ALL_CFLAGS/COMMON_CFLAGS/PKG_CFLAGS.

I suppose you don't have LLVM on the platform you use, no problem,
I just wanted to inform you about it.
It's already fixed on my series you just commented about.

Regards,
-- Luc Van Oostenryck
