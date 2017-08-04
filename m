From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix: give a type to bad conditionnal expressions
Date: Fri, 4 Aug 2017 14:31:10 +0200
Message-ID: <CAExDi1SD=F=4Uyr2x5NeMn46M=c-3iMwosLUrVu-343r-u_yPQ@mail.gmail.com>
References: <20170804001122.4ivc2sktypvg2w3i@ltop.local> <20170804001639.4823-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34238 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752325AbdHDMbL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 08:31:11 -0400
Received: by mail-qk0-f172.google.com with SMTP id u139so7980619qka.1
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 05:31:11 -0700 (PDT)
In-Reply-To: <20170804001639.4823-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Please ignore this patch as I must have forgot to recompile the last change.
The problem is there and the solution too but bad_ctype won't solve
the issue here.

I'll send another version which will effectively solve the issue but
I'm far from sure
we'll want it.

-- Luc
