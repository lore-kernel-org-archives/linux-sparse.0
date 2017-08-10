From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 7/9] transform (A & M) >> S to (A >> S) & (M >> S)
Date: Fri, 11 Aug 2017 01:41:04 +0200
Message-ID: <CAExDi1Qf15pyLadMRjo4QkjAv_gxq4stPuAd-7eyiuRyKYSCWQ@mail.gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com> <20170809193806.30975-8-luc.vanoostenryck@gmail.com>
 <CANeU7QmSNz8vTjiukmakHsWHveKkA-8bLY_E4AtfKRbKUtJSCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36648 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdHJXlF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 19:41:05 -0400
Received: by mail-oi0-f53.google.com with SMTP id g131so20747066oic.3
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 16:41:05 -0700 (PDT)
In-Reply-To: <CANeU7QmSNz8vTjiukmakHsWHveKkA-8bLY_E4AtfKRbKUtJSCA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 3:16 AM, Christopher Li <sparse@chrisli.org> wrote:

>> +               // replace (A & M) >> S
>> +               // by      (A >> S) & (M >> S)
>
> A little bit suggestion base on my previous reading and question ask on
> this. When I first read the comment without reading the code, then I would
> wondering why (A>>S) & (M>>S) is simpler. The following code actually
> explain the constant mask very well. So the comment best understand if
> the code was read. Adding some comment on M is constant will help a
> lot in the comment.

Yes.
In fact, these patches still need to have a proper commit message.
I've added a not for now.

--Luc
