From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] avoid infinite loop during simplification
Date: Sat, 12 Aug 2017 10:31:11 -0400
Message-ID: <CANeU7QnU+_h-1si+ROWuVqLSG3pTbrzbso0Ck-21ru=q62UsNg@mail.gmail.com>
References: <20170812125525.34044-1-luc.vanoostenryck@gmail.com>
 <CANeU7QmjFd17UTFGSe_FOR+0jTn+azzaHvwq_FtG6sSGL1sx+Q@mail.gmail.com> <CAExDi1RZ9v_5TFvcAOF2JkPWJYD_awt9uqga8tSvgzpmoaHrWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34336 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdHLObM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 10:31:12 -0400
Received: by mail-yw0-f176.google.com with SMTP id s143so36066740ywg.1
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 07:31:12 -0700 (PDT)
In-Reply-To: <CAExDi1RZ9v_5TFvcAOF2JkPWJYD_awt9uqga8tSvgzpmoaHrWQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 12, 2017 at 10:17 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Aug 12, 2017 at 3:55 PM, Christopher Li <sparse@chrisli.org> wrote:
>>
>> Are you considering this in this release?
>
> Yes, I do.
> I've another version with a tunable but this one I made for a
> quick inclusion in the release.


I think we need to draw the line some where.

Now RC5 is out. The merge window is closed.
It is not critical to have it. If  there is serious bug cause
RC6 then we can merge this in as well.

Otherwise I would say hold on to after the release.
We can make a minor 0.5.2 release. We don't have to
pile every thing into one release.

Let's get this 0.5.1 release out.

Chris
