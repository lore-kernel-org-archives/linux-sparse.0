From: Shannon Nelson <snelson@pensando.io>
Subject: Re: smatch/sparse complaints on static assertion
Date: Tue, 11 Feb 2020 17:05:05 -0800
Message-ID: <78345bc2-5d81-24b8-89fe-45887c58c425@pensando.io>
References: <e588417e-1bf4-35e3-d8d9-9911fe29e0f5@pensando.io>
 <ecdd10cb-0022-8f8a-ec36-9d51b3ae85ee@pensando.io>
 <CAHk-=wi7jGZ+bVbt-UfXOkpEQdHzF3Z2HBjkGdjh8q4dvPPGWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38435 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgBLBFI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Feb 2020 20:05:08 -0500
Received: by mail-pj1-f68.google.com with SMTP id j17so114156pjz.3
        for <linux-sparse@vger.kernel.org>; Tue, 11 Feb 2020 17:05:07 -0800 (PST)
In-Reply-To: <CAHk-=wi7jGZ+bVbt-UfXOkpEQdHzF3Z2HBjkGdjh8q4dvPPGWQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>

On 2/11/20 4:36 PM, Linus Torvalds wrote:
> On Tue, Feb 11, 2020 at 9:41 AM Shannon Nelson <snelson@pensando.io> wrote:
>> drivers/net/ethernet/pensando/ionic/ionic_dev.h:56:1: error: static
>> assertion failed: "sizeof(struct ionic_dev_getattr_comp) == 16"
> As Luc says, this is because those structures are mis-declared.
>
> See this, for example:
>
>    struct ionic_dev_getattr_comp {
>          u8     status;
>          u8     rsvd[3];
>          union {
>                  __le64  features;
>                  u8      rsvd2[11];
>          };
>          u8     color;
>    };
>
> and notice how "__le64  features" is a 64-bit entity but it's in a
> union with a "u8 rsvd2[11];".
>
> That makes the whole union align to the same as the __le64 (on x86-32,
> that's 32-bit, for bad legacy reasons, on everything else it's
> 64-bit).
>
> Mark the associated types properly packed individually, rather than
> use the disgusting "pragma pack()" that should never be used.
>
> This is not a recent sparse change, it must never have worked.
>
>              Linus

Thanks, I'll try to work that into this next net-next cycle.

sln
