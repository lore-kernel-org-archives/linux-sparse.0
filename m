From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] lib: __builtin_object_size should accept void *
Date: Thu, 24 Nov 2016 12:01:21 +0800
Message-ID: <CANeU7Q=tRrCDxo25xgQC8qAQJsA27dEUiJ8sjDTXU-HAL3_h6w@mail.gmail.com>
References: <1479932572-12543-1-git-send-email-mst@redhat.com>
 <CANeU7Qm4Q7fawnTkGgsgQoiLJXwJLJng+4Y60+n5c_nbK-vRgQ@mail.gmail.com> <20161124052744-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34641 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754354AbcKXEBX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 23:01:23 -0500
Received: by mail-io0-f196.google.com with SMTP id r94so3810900ioe.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 20:01:22 -0800 (PST)
In-Reply-To: <20161124052744-mutt-send-email-mst@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Josh Triplett <josh@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 24, 2016 at 11:28 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Doesn't seem to be pushed yet - at least I don't see it in master
> on git://git.kernel.org/pub/scm/devel/sparse/sparse.git

That is right. I haven't push them out yet. The last few days have been a bit
hectic for me in terms patch apply and modify.  I am considering setup
a linux-next
like staging repository for sparse. Maybe sparse-next?

Chris
