From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 03/63] canonicalize compare instructions
Date: Sat, 25 Mar 2017 01:03:10 +0100
Message-ID: <CAMHZB6HBo0pSkO86riLvy0SYdWR5=EGGxaqH=wkguLVDi5XRhA@mail.gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
 <20170321001607.75169-4-luc.vanoostenryck@gmail.com> <CANeU7Qkhygbv5xBHKicwJDRdDY-EJctauxvLoz33wZ_keeqXHQ@mail.gmail.com>
 <20170324081156.qhblvgndemthg7wf@macbook.local> <CANeU7QnU-mdNq5MDXcu4-s3V85p2cjF-siSRULjZHD-AB+MxWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36643 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753554AbdCYADR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 20:03:17 -0400
Received: by mail-qk0-f178.google.com with SMTP id p22so3912381qka.3
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 17:03:16 -0700 (PDT)
In-Reply-To: <CANeU7QnU-mdNq5MDXcu4-s3V85p2cjF-siSRULjZHD-AB+MxWA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Sat, Mar 25, 2017 at 12:47 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Mar 24, 2017 at 1:11 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:

>>
>> My preference, if performance mattered here, would be to play
>> with the bits of the opcode, something like:
>>         #define OP_SET__EQUAL   (1 << ...)
>>         #define OP_SET__SIGNED  (1 << ...)
>>         #define OP_SET__LTHAN   ...
>>         #define OP_SET__GTHAN   ...
>>
>>         ...
>>
>>         int swap_compare_opcode(opcode) { return opcode ^= (OP_SET__LTHAN|OP_SET__GTHAN); }
>
> That is ugly. I don't want that.
>
> I cook up an untested patch include here to show what I have in mind.
> It should be very close to your case statement way of writing it.  You are
> welcome to change it.

I already resent the serie, maybe 30 minutes ago or so.
but without this ugly thing you don't want.

-- Luc
