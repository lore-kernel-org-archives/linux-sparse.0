From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix expansion cost of pure functions
Date: Thu, 23 Feb 2017 17:55:44 +0800
Message-ID: <CANeU7Q=kqKYxohGQtwEPS=9boLcRcR0=4k-MNbpKZFeA-Hj4Mw@mail.gmail.com>
References: <20170216154532.9261-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkmOAAbOJs_QYnxh4O=J7y_Vbg8rM5jmdzKvvL5q_XFxg@mail.gmail.com> <CA+55aFz_+qEteX-o-2O+=RWiNWQ-N603vFDUNTBG8W2Bn11Png@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35684 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdBWJzp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Feb 2017 04:55:45 -0500
Received: by mail-it0-f65.google.com with SMTP id 203so1886493ith.2
        for <linux-sparse@vger.kernel.org>; Thu, 23 Feb 2017 01:55:44 -0800 (PST)
In-Reply-To: <CA+55aFz_+qEteX-o-2O+=RWiNWQ-N603vFDUNTBG8W2Bn11Png@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 23, 2017 at 9:01 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Feb 22, 2017 at 3:57 PM, Christopher Li <sparse@chrisli.org> wrote:
>>
>> I think dropping to zero has some thing to do with get rid of
>> the side effect cost. So it possible the cost can be dropping.
>
> No, I think the zero is just a bug, introduced in commit 8376ab091a
> ("sparse: Fix __builtin_safe_p for pure and const functions").
>
> I might be missing something, but I think Luc's patch is fine.
>
>               Linus
