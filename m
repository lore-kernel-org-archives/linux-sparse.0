From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: sparse problem with Linux kernel v5.5
Date: Thu, 6 Feb 2020 07:18:45 +0000
Message-ID: <CAHk-=wgQM29j0BJ-b0fTfwA9nc_fiS09Mi2oO8hX34oRxR6+xA@mail.gmail.com>
References: <6ee65b69-9ffc-78c6-66b7-3ce586687d74@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36180 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgBFHTG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Feb 2020 02:19:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so4973646ljg.3
        for <linux-sparse@vger.kernel.org>; Wed, 05 Feb 2020 23:19:04 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id w6sm769445lfq.95.2020.02.05.23.19.02
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 23:19:02 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id y6so4990098lji.0
        for <linux-sparse@vger.kernel.org>; Wed, 05 Feb 2020 23:19:02 -0800 (PST)
In-Reply-To: <6ee65b69-9ffc-78c6-66b7-3ce586687d74@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Thu, Feb 6, 2020 at 4:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Also, what is errno 137? (0x89)

I think that's just "killed by signal 9" (the high bit is "killed by
signal", the low bits are the signal number).

SIGKILL - oom? What does 'dmesg' say? Maybe there's some exponential
memory use triggered by something in that bpf_sk_storage file..

                Linus
