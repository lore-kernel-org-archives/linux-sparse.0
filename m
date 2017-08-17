From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Thu, 17 Aug 2017 21:51:23 +0200
Message-ID: <CAExDi1S3i_63LjxbUsrdpxWfWKoPr+3Hzr3F=aY3DMb7fa65Ew@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
 <CACXZuxfQejAOR-JwSh+tYtjBgr3wYawVgEFNAXRU6c_QoTQKRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33889 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbdHQTvY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 15:51:24 -0400
Received: by mail-oi0-f49.google.com with SMTP id x3so77181107oia.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 12:51:24 -0700 (PDT)
In-Reply-To: <CACXZuxfQejAOR-JwSh+tYtjBgr3wYawVgEFNAXRU6c_QoTQKRA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 6:59 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Apart from that I faced a problem with this and had to disable
> STRUCT/UNION from being treated as simple types.
>
> The problem was when generating LLVM output for
> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/eic/testcbrt.c.
> I will investigate more and report back my findings.

There is indeed a problem with this case. It seems there is a mixup
with types somewhere and sparse-llvm needs a few lines more.

I'll look at it in the following days.

-- Luc
