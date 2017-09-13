From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Some thoughts on the SSA debate
Date: Wed, 13 Sep 2017 19:25:36 +0100
Message-ID: <CACXZuxeO_rpOFwhjf8vb1SsiHH0NJNneKyoDwF_BzyYyz6n4kw@mail.gmail.com>
References: <CACXZuxdGXjyMJAh8CCUUFbLXWaLfLJ121S8UbRp9NbE4B1koZA@mail.gmail.com>
 <20170909020604.5io7kuw6itquzbfp@ltop.local> <CACXZuxdtwsp=YXN_4q5Ox=6R6fKdz-6kLUcTYskJcwd6qvh5DQ@mail.gmail.com>
 <CAExDi1QyP5FRTrNgfEx7zK=bKQyPQ36gHgDSBRtqWOi=-Bf-sw@mail.gmail.com>
 <CACXZuxcQrFOaM8T5z-5tZNU3XnY8d4aOQ3FfRs2SSY+Gv1T7rA@mail.gmail.com> <CAExDi1QW8U=rkLX-JMzi=uQG0RTJ-bCjRT46m3CTb7LifKXMQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:47151 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdIMSZi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Sep 2017 14:25:38 -0400
Received: by mail-ua0-f179.google.com with SMTP id k23so1355660uaf.4
        for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2017 11:25:37 -0700 (PDT)
In-Reply-To: <CAExDi1QW8U=rkLX-JMzi=uQG0RTJ-bCjRT46m3CTb7LifKXMQA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 12 September 2017 at 14:06, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Sep 12, 2017 at 1:47 PM, Dibyendu Majumdar
>> But the issue
>> right now is that the simplifications are not always correct even with
>> the new SSA so that I have to disable everything anyway.
>
> It's what you do but it's not what I do.
> The other part that is broken is simplify_loads() which try to convert
> more variables after each simplification/CSE steps.
> Since the code is copied from the code for the initial conversion
> it's broken in the same ways.
> I just disabled it and things are then correct.
>

I probably ought to update my project with the latest version you
have. Please let me know if you have an updated minimal changes branch
that I can apply.

Thanks and Regards
Dibyendu
