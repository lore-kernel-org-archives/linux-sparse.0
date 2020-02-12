From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: smatch/sparse complaints on static assertion
Date: Tue, 11 Feb 2020 16:36:10 -0800
Message-ID: <CAHk-=wi7jGZ+bVbt-UfXOkpEQdHzF3Z2HBjkGdjh8q4dvPPGWQ@mail.gmail.com>
References: <e588417e-1bf4-35e3-d8d9-9911fe29e0f5@pensando.io> <ecdd10cb-0022-8f8a-ec36-9d51b3ae85ee@pensando.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lj1-f181.google.com ([209.85.208.181]:46853 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgBLAg3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Feb 2020 19:36:29 -0500
Received: by mail-lj1-f181.google.com with SMTP id x14so222738ljd.13
        for <linux-sparse@vger.kernel.org>; Tue, 11 Feb 2020 16:36:28 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b1sm3501589ljp.72.2020.02.11.16.36.26
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 16:36:26 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id z18so284703lfe.2
        for <linux-sparse@vger.kernel.org>; Tue, 11 Feb 2020 16:36:26 -0800 (PST)
In-Reply-To: <ecdd10cb-0022-8f8a-ec36-9d51b3ae85ee@pensando.io>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Shannon Nelson <snelson@pensando.io>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>

On Tue, Feb 11, 2020 at 9:41 AM Shannon Nelson <snelson@pensando.io> wrote:
>
> drivers/net/ethernet/pensando/ionic/ionic_dev.h:56:1: error: static
> assertion failed: "sizeof(struct ionic_dev_getattr_comp) == 16"

As Luc says, this is because those structures are mis-declared.

See this, for example:

  struct ionic_dev_getattr_comp {
        u8     status;
        u8     rsvd[3];
        union {
                __le64  features;
                u8      rsvd2[11];
        };
        u8     color;
  };

and notice how "__le64  features" is a 64-bit entity but it's in a
union with a "u8 rsvd2[11];".

That makes the whole union align to the same as the __le64 (on x86-32,
that's 32-bit, for bad legacy reasons, on everything else it's
64-bit).

Mark the associated types properly packed individually, rather than
use the disgusting "pragma pack()" that should never be used.

This is not a recent sparse change, it must never have worked.

            Linus
