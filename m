From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] lib: __builtin_object_size should accept void *
Date: Thu, 24 Nov 2016 13:49:17 +0800
Message-ID: <CANeU7Qn0AhfBJszBYMqv+ewP3aZmNYmXmvRbPtF1zGF1Y_1WMw@mail.gmail.com>
References: <1479932572-12543-1-git-send-email-mst@redhat.com>
 <CANeU7Qm4Q7fawnTkGgsgQoiLJXwJLJng+4Y60+n5c_nbK-vRgQ@mail.gmail.com>
 <20161124052744-mutt-send-email-mst@kernel.org> <CANeU7Q=tRrCDxo25xgQC8qAQJsA27dEUiJ8sjDTXU-HAL3_h6w@mail.gmail.com>
 <20161124043536.cw2664fjdsdg7ssy@x> <CANeU7QkS2QTrQ40JYTXmzi19s4JyL+T15+3y9y0vQBmBTNCEKw@mail.gmail.com>
 <20161124051913.ns47h4xnridei33c@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34305 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbcKXFtn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 00:49:43 -0500
Received: by mail-io0-f196.google.com with SMTP id r94so4004551ioe.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 21:49:18 -0800 (PST)
In-Reply-To: <20161124051913.ns47h4xnridei33c@x>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 24, 2016 at 1:19 PM, Josh Triplett <josh@kernel.org> wrote:
> Rebasing a "next" branch, as long as you clearly document that, seems
> fine.

Great. Here is the sparse-next branch. This branch contain the latest patch
I applied. It can be rebased from time to time.

https://git.kernel.org/cgit/devel/sparse/sparse.git/log/?h=sparse-next

Chris
