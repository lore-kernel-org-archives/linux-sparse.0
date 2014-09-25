From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse-llvm: Fix LLVM 3.5 linker errors
Date: Thu, 25 Sep 2014 08:21:35 +0800
Message-ID: <CANeU7QnXEgjpDMTdL_JYY1T=GG5A_aP4+90ctTPbCsh8DokUyw@mail.gmail.com>
References: <1411592461-22810-1-git-send-email-osandov@osandov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:54053 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaIYAVh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Sep 2014 20:21:37 -0400
Received: by mail-wg0-f51.google.com with SMTP id z12so3223603wgg.10
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2014 17:21:36 -0700 (PDT)
In-Reply-To: <1411592461-22810-1-git-send-email-osandov@osandov.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Alain Kalker <a.c.kalker@gmail.com>

On Thu, Sep 25, 2014 at 5:01 AM, Omar Sandoval <osandov@osandov.com> wrote:
> llvm-config 3.5 no longer lists the non-LLVM libraries needed for linkage when
> passed --libs. The --system-libs flag was added for this purpose. This adds
> these libraries while silently doing nothing for older versions of LLVM.

Thanks for the patch. It looks fine. Applied.

BTW, the patch did not apply cleanly for me. It has some conflict.
I can't see why it failed. Since it is just one line, I just paste it.

Please double check the tip of chrisl repository. I just push it.

Chris
