From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix expansion cost of pure functions
Date: Thu, 23 Feb 2017 17:56:39 +0800
Message-ID: <CANeU7Q=6ikz206rW-EhQ2cB2i3+n1wopk=E0kLBnRdOdCYKvkg@mail.gmail.com>
References: <20170216154532.9261-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkmOAAbOJs_QYnxh4O=J7y_Vbg8rM5jmdzKvvL5q_XFxg@mail.gmail.com> <CA+55aFz_+qEteX-o-2O+=RWiNWQ-N603vFDUNTBG8W2Bn11Png@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33616 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdBWJ5j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Feb 2017 04:57:39 -0500
Received: by mail-it0-f65.google.com with SMTP id e137so1906818itc.0
        for <linux-sparse@vger.kernel.org>; Thu, 23 Feb 2017 01:56:40 -0800 (PST)
In-Reply-To: <CA+55aFz_+qEteX-o-2O+=RWiNWQ-N603vFDUNTBG8W2Bn11Png@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 23, 2017 at 9:01 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> No, I think the zero is just a bug, introduced in commit 8376ab091a
> ("sparse: Fix __builtin_safe_p for pure and const functions").
>
> I might be missing something, but I think Luc's patch is fine.

Thanks for the insight. I will apply it.

Chris
