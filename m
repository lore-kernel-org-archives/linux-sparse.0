From: Josh Triplett <josh@kernel.org>
Subject: Re: [PATCH] lib: __builtin_object_size should accept void *
Date: Wed, 23 Nov 2016 20:35:36 -0800
Message-ID: <20161124043536.cw2664fjdsdg7ssy@x>
References: <1479932572-12543-1-git-send-email-mst@redhat.com>
 <CANeU7Qm4Q7fawnTkGgsgQoiLJXwJLJng+4Y60+n5c_nbK-vRgQ@mail.gmail.com>
 <20161124052744-mutt-send-email-mst@kernel.org>
 <CANeU7Q=tRrCDxo25xgQC8qAQJsA27dEUiJ8sjDTXU-HAL3_h6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59474 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbcKXEg3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 23:36:29 -0500
Content-Disposition: inline
In-Reply-To: <CANeU7Q=tRrCDxo25xgQC8qAQJsA27dEUiJ8sjDTXU-HAL3_h6w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 24, 2016 at 12:01:21PM +0800, Christopher Li wrote:
> On Thu, Nov 24, 2016 at 11:28 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Doesn't seem to be pushed yet - at least I don't see it in master
> > on git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> 
> That is right. I haven't push them out yet. The last few days have been a bit
> hectic for me in terms patch apply and modify.  I am considering setup
> a linux-next
> like staging repository for sparse. Maybe sparse-next?

Probably doesn't need a separate integration repository; if you want to
stage changes that you don't know you want to ship yet, a "next" branch
in the main repository would be easier for people to find and use.  If
you just want to give changes time to stabilize, you can probably put
them on "master" and just not release them yet.
