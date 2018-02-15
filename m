From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC PATCH 0/2] drop the concept of 'known-but-ignored' attributes
Date: Thu, 15 Feb 2018 12:06:06 -0800
Message-ID: <CANeU7Qm7VZc07HkQJwg-uj98D-uz5XJB7MQHqOD86jbtYAa_5g@mail.gmail.com>
References: <20180213232109.20933-1-luc.vanoostenryck@gmail.com>
 <20180215155724.GB1882@localhost> <CA+55aFyWiRtNu+KK3h15hsy7Wt6VXK9ex3+gtJWbcqJ3WtyDrg@mail.gmail.com>
 <20180215195351.ugvy6eqv2lcxdbbn@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36398 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162691AbeBOUGJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Feb 2018 15:06:09 -0500
Received: by mail-qk0-f169.google.com with SMTP id 15so1147310qkl.3
        for <linux-sparse@vger.kernel.org>; Thu, 15 Feb 2018 12:06:08 -0800 (PST)
In-Reply-To: <20180215195351.ugvy6eqv2lcxdbbn@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Lance Richardson <lrichard@redhat.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Randy Dunlap <rdunlap@infradead.org>, Rui Teng <rui.teng@linux.vnet.ibm.com>

On Thu, Feb 15, 2018 at 11:53 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> So I do think the warning itself should be off by default - but maybe
>> the "known but ignored" table should exist so that sparse people can
>> say "is there a new attribute that I need to look at"?
>
> Yes, I think that the off by default is a clear thing.
> For the table, yes, I sort of agree with you and Josh at some level
> but in practice I don't think it will be of any help. There is
> already a number of attributes (and builtins) sparse *should* act on
> (for attributes, I'm thinking to 'noreturn', for example) but haven't
> and this for a long time already. I also think that once the warning
> will be off by default, the table won't be updated anymore.

I agree with the default should be turn off for kernel checking
to reduce the noise.

The known attribute table does have some usage. If the developer are
writing sparse related checking, he might want to know if he misspell
some sparse specific attribute. The other case is that, some sparse
specific attribute is not implement in this version of sparse. It might
be useful to know.

In this case, the developer can turn this warning on to catch if
there is misspell of the "adress_space" attribute for example.

I suggest change default on off, but keep the warning option if
some one want to turn it on.

Chris
