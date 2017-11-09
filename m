From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 27/37] build: use a dot file name instead of local.mk: .sparse.mk
Date: Thu, 9 Nov 2017 16:18:35 +0100
Message-ID: <CAMHZB6EUbo8kU7BQuXVUvXLM7OpxzQ90n+qGh-1Nc7ACtH6yHg@mail.gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
 <20171109064648.15379-28-luc.vanoostenryck@gmail.com> <331e1528-dc30-ecd9-38ea-0b5c03b99c1b@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:51721 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbdKIPSh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 10:18:37 -0500
Received: by mail-vk0-f48.google.com with SMTP id v3so4163851vkb.8
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 07:18:36 -0800 (PST)
In-Reply-To: <331e1528-dc30-ecd9-38ea-0b5c03b99c1b@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>

On Thu, Nov 9, 2017 at 3:56 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> On 09/11/17 06:46, Luc Van Oostenryck wrote:
>> --include local.mk
>> +-include .sparse.mk
>>  ########################################################################
>
> I don't see any reason to make this change. The commit message
> does not make a very convincing argument! :-D

Uwe had already the same reaction. Here was the exchange:
>> Hello Luc,
>>
>> > -local.mk
>> > +.sparse.mk
>>
>> what is the motivation to hide this file? IMHO it is better to be aware
>> of eventual changes to the build system and so don't hide the file.
>>
>> Having said that I question if it is a good idea at all to provide a way
>> to change the build without dirtying the working copy.
>
> I confess that this change is just for my own comfort.
> I often need to change the CFLAGS while debugging or profiling.
> I want that to be in a file, the file must of course not be under
> version control and like .bashrc, kernel's .config or GCC's generated
> .*.o.d files, I don't need to see this file and so I prefer it's a
> hidden one.
>
> I understand your worries but since it's a file purposely changed
> so that files are compiled differently, there are no surprises.
> For dirtying the build ... yes, something could be done but really,
> personally, I don't need this, I know when I need to clean my tree.

So, yes, certainly not a strong argument.

I think I'll take a slightly different way, one that will suit me even better,
something like:
-include local.mk
+SPARSE_LOCAL_MK ?= local.mk
+include ${SPARSE_LOCAL_MK}

Would this be less objectionable?

Regards,
-- Luc
