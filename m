From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] avoid infinite loop during simplification
Date: Sat, 12 Aug 2017 10:04:25 -0400
Message-ID: <CANeU7QmgTDZYP+NRH-b0581e5izaCXd9oGjA788UgOBEmhv8zg@mail.gmail.com>
References: <20170812125525.34044-1-luc.vanoostenryck@gmail.com> <CANeU7QmjFd17UTFGSe_FOR+0jTn+azzaHvwq_FtG6sSGL1sx+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33354 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdHLOE1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 10:04:27 -0400
Received: by mail-yw0-f194.google.com with SMTP id u207so3758339ywc.0
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 07:04:26 -0700 (PDT)
In-Reply-To: <CANeU7QmjFd17UTFGSe_FOR+0jTn+azzaHvwq_FtG6sSGL1sx+Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 12, 2017 at 9:55 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, Aug 12, 2017 at 8:55 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> Currently, sparse can enter in infinite loops.
>> The effect can be seen is the normal simplification/CSE
>> loops but the origin of the problem is not there
>> (it's some interaction between simplify_loads() and
>> unreachable code, at least for a good part of them).
>>
>> On the other hand, on normal code, the number of
>> simplification/CSE cycle is fairly small: even in big,
>> complex functions, in 80% of cases only 1 or 2 cycles are
>> needed. The most extreme I found was 12 cycles and that's
>> an unique case (on a total of 172000+).

There is also the other way to do it.
Every time the CFG changed, set a changed flag.
Stop CSE if there is no more change reached.

It should detect the problem that currently we think
there is opportunity to optimize, but turn out there is not.
If we keep repeating this loop, that is a bug, we need
to fix it.

Another way to look at it is, the model should be more
if we are sure there is change can be make, then we
go do the change. Current CSE scanning all instructions
looking for oppertuniity is actually not very optimal.

Chris
